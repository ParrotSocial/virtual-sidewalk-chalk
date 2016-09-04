/// <reference path="../typings/index.d.ts" />

import WS = require('ws')
import http = require('http')

const WebSocketServer = WS.Server
const wss = new WebSocketServer({port: 2366})

var defCID = "AAA"
var clients: WS[]  = [];
var cids: string[] = [];

wss.on('connection', (ws) => {
  console.log(timeStamp(new Date()) + " A client has connected")

  ws.send("s:Welcome to the party!")

  for (var i = 0; i < clients.length; i++) {
    clients[i].send("s:Another drawer joined!");
  }

  clients.push(ws)

  cids.push(defCID)

  ws.send("s:Now there are " + clients.length + " drawers connected");
  ws.onclose = function (ws) {
    var whoToSplice = -1;
    for (var i = 0; i < clients.length; i++) {
      if (clients[i].readyState === 3) {
          whoToSplice = i;
      }
    }
    if (whoToSplice !== -1) {
      var deadCid = cids[whoToSplice];
      clients.splice(whoToSplice, 1);
      cids.splice(whoToSplice, 1);
      console.log(timeStamp(new Date()) + "Removed a client from server");
      for (var i = 0; i < clients.length; i++) {
        clients[i].send("s:We've lost an artist.");
        clients[i].send("x:" + deadCid);
      }
    }
  }

  ws.onmessage = function (message) {
    var dA = message.data.split(':');
    //console.log(dA);
    if (dA[0] === 'u')
      cids[cids.length - 1] = dA[2];
    for (var i = 0; i < clients.length; i++) {
      //console.log(message);
      if (clients[i] !== this)
        clients[i].send(message);
    }
  }
})

function timeStamp (date: Date) {
  return date.getDate() + " - " + date.getHours() + ":" + date.getMinutes()
}
