const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

var connections = {};
var rooms = {};

io.on('connection', (socket) => {
  console.log('a user connected');
  connections[socket.id] = socket;
  // console.log('User connected :: updated connections :: ' + connections[socket.id]);

  socket.on("startchat", (participant) => {
    console.log('starting new chat with :: ' + participant);
    rooms[participant] = socket.id;
    // console.log('starting updated rooms :: ' + rooms[participant]);
  });

  socket.on('chatmsg', (msg) => {
    console.log('message: ' + msg);
    var obj = JSON.parse(msg);
    console.log('participant: ' + obj.participant)
    var sid = rooms[obj.participant];
    // console.log('participant sid : ' + sid);
    var sSocket = connections[sid];
    // console.log('participant sSocket : ' + sSocket);
    if (sSocket != null) {
      sSocket.emit("receivemsg", msg)
    }
  });

  socket.on('key', (msg) => {
    console.log('message: ' + msg);
    var obj = JSON.parse(msg);
    console.log('participant: ' + obj.participant)
    var sid = rooms[obj.participant];
    // console.log('participant sid : ' + sid);
    var sSocket = connections[sid];
    // console.log('participant sSocket : ' + sSocket);
    if (sSocket != null) {
      sSocket.emit("onKey", msg)
    }
  });

  socket.on('disconnect', () => {
    console.log('user disconnected');
  });
});

server.listen(3000, () => {
  console.log('listening on *:3000');
});
