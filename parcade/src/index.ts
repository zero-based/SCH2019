import five = require("johnny-five");
import io = require('socket.io-client');

const socket = io(`http://localhost:${process.env.PORT}/`);
const board = new five.Board();

board.on("ready", function () {
    const led = new five.Led(7);
    led.off();

    socket.on("newReservation", function (data: any) {
        console.log(data);
        led.toggle();
    });

});