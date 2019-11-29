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
});

function initListeners() {
  db.collection("reservations").onSnapshot(
    querySnapshot => {
      querySnapshot.docChanges().forEach(change => {
        if (change.type === "added") {
          console.log("Added Reservation: ", change.doc.data());
          server.sockets.emit("newReservation", {
            id: change.doc.id,
            color: "#" + (((1 << 24) * Math.random()) | 0).toString(16)
          });
        } else if (change.type === "modified") {
          server.sockets.emit("arrival");
          console.log("Modified Reservation: ", change.doc.data());
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
