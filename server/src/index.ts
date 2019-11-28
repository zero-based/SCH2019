import express = require("express");
import socket_io = require("socket.io");

// App setup
const app = express();

app.get("/", (req, res) => {
  res.send({ msg: "Hello World!" });
});

// Socket setup & pass server
const server = socket_io(
  app.listen(process.env.PORT, () => {
    console.log(`Server Started: http://localhost:${process.env.PORT}/`);
  })
);

server.on("connection", socket => {
  console.log(`Socket ${socket.id} Connected.`);

  server.emit("initial", {
    msg: "Hello World!"
  });

  server.on("disconnect", () => {
    console.log(`Socket ${socket.id} Disconnected.`);
  });
});
