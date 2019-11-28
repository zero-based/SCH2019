import express = require("express");
import socket_io = require("socket.io");


// App setup
const app = express();
app.use(express.static("public"));


// Socket setup & pass server
const server = socket_io(
  app.listen(process.env.PORT, () => {
    console.log(`Server Started: http://localhost:${process.env.PORT}/`);
  })
);

server.on("connection", socket => {
  console.log(`Socket ${socket.id} Connected.`);

  setInterval(() => emit(), 1000);

  server.on("disconnect", () => {
    console.log(`Socket ${socket.id} Disconnected.`);
  });
});

function emit() {
  setTimeout(() => {
    server.emit("main", {
      text: Math.random()
        .toString(36)
        .substring(7),
      color: "#" + (((1 << 24) * Math.random()) | 0).toString(16)
    });
  }, 1000);
}
