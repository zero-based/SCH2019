import five = require("johnny-five");
import io = require('socket.io-client');

const socket = io(`http://localhost:${process.env.PORT}/`);
const board = new five.Board();
let ignoreIr: Boolean = true;
let parked: Boolean = false;
let userId: String = "";
let reservationId: String = "";
let parcadeId: String = "";

board.on("ready", function () {
    const greenLed = new five.Led(2);
    const redLed = new five.Led(3);
    const motion = new five.Motion(4);
    greenLed.on();
    redLed.off();

    /* Socket Callbacks */
    socket.on("newReservation", function (data: any) {
        console.log(data);
        greenLed.off();
        redLed.on();
        //TODO: Parcade up here.

        userId = data["userId"];
        reservationId  = data["reservationId"];
        parcadeId = data["parcadeId"];
    });

    socket.on("arrival", function (data: any) {
        console.log(data);
        greenLed.off();
        redLed.on();
        ignoreIr = false;
        //TODO: Parcade down here.
    });

    /* IR Sensor Callbacks */

    /*
     *   "calibrated" occurs once, at the beginning of a session.
    */
    motion.on("calibrated", function () {
        console.log("calibrated", Date.now());
    });

    /*
     *   "motionstart" events are fired when the "calibrated" area is disrupted,
          generally by some form of movement.
    */
    motion.on("motionstart", function () {
        if (parked) {
            // Left spot
            console.log("motionstart", Date.now());
            greenLed.on();
            redLed.off();
            ignoreIr = true;
            parked = false;
            //TODO: Parcade up here.
            socket.emit('userLeft', { userId, reservationId, parcadeId });
        }
    });

    /*
     *   "motionend" events are fired following a "motionstart" event
         when no movement has occurred in X ms.
    */
    motion.on("motionend", function () {
        if (!ignoreIr) {
            parked = true;
            ignoreIr = false;
            console.log("motionend", Date.now());
        }
    });

});