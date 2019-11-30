import express = require("express");
import socket_io = require("socket.io");
import admin = require("firebase-admin");

// Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(require("../serviceAccountKey.json")),
  databaseURL: "https://sch-2019.firebaseio.com"
});
const db = admin.firestore();

// App setup
const app = express();
app.use(express.static("public"));

// Socket setup & pass server
const server = socket_io(
  app.listen(process.env.PORT, () => {
    console.log(`Server Started: http://localhost:${process.env.PORT}/`);
  })
);

initListeners();

server.on("connection", socket => {
  console.log(`Socket ${socket.id} Connected.`);
  server.on("disconnect", () => {
    console.log(`Socket ${socket.id} Disconnected.`);
  });

  socket.on('userLeft', function (data) {
    const batch = db.batch();

    const resRef = db.collection("reservations").doc(data["reservationId"]);
    batch.update(resRef, { "leftOn": admin.firestore.Timestamp.now() });

    const userRef = db.collection("users").doc(data["userId"]);
    batch.update(userRef, { "currentReservation": "" });

    const parcadeRef = db.collection("parcades").doc(data["parcadeId"]);
    batch.update(parcadeRef, { "isAvailable": true });

    batch.commit()
      .then(() =>
        server.sockets.emit("userLeftParcade", {
          userId: data["userId"],
          color: "#" + (((1 << 24) * Math.random()) | 0).toString(16)
        }
        )).catch(e => console.log(e));
  });
});



function initListeners() {
  db.collection("reservations").onSnapshot(
    querySnapshot => {
      querySnapshot.docChanges().forEach(change => {
        if (change.type === "added") {
          console.log("Added Reservation: ", change.doc.data());
          server.sockets.emit("newReservation", {
            reservationId: change.doc.id,
            userId: change.doc.data()["userId"],
            parcadeId: change.doc.data()["parcadeId"],
            color: "#" + (((1 << 24) * Math.random()) | 0).toString(16)
          });
        } else if (change.type === "modified") {
          if (change.doc.data()["canceledOn"] === null && change.doc.data()["leftOn"] === null) {
            server.sockets.emit("arrival");
            console.log("Modified Reservation: ", change.doc.data());
          }
        } else if (change.type === "removed") {
          console.log("Removed Reservation: ", change.doc.data());
        }
      });
    },
    err => {
      console.log(`Encountered error: ${err}`);
    }
  );
}
