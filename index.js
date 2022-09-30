const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const bodyParser = require('body-parser');
const io = new Server(server,  {cors: {origin: "*"}});
const conversation = require('./src/commands/save_conversation.command');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//routers
app.get('/', (req, res) => {res.sendFile(__dirname + '/index.html');});


io.on('connection', (socket) => {
    console.log('usuario conectado')
    socket.on('disconnect', () => {console.log('user disconnected');});

    //comandos
    conversation(io, socket);
});

server.listen(3000, () => {
  console.log(`Escuchando en el puerto http://10.0.30.8:3000`);
});