const http = require('http');
const cors = require('cors');
const path = require('path');
const express = require('express');
const app = express();
const axios = require('axios');
const server = http.createServer(app);
const { Server } = require("socket.io");
const bodyParser = require('body-parser');
const dotenv = require('dotenv').config();
const client = require('./src/whatsapp/index');
const io = new Server(server,  {cors: {origin: "*"}});
const {user_command, leave} = require('./src/commands/user.command');
const {conversation_command} = require('./src/commands/conversation.command');

//midlewars
app.use(cors({origin: process.env.URL_FRONTEND}));

//Settings
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//Database
const { mongoose } = require('./src/database');

//routers
app.get('/', (req, res) => {res.sendFile(__dirname + '/index.html');});
app.use('/chat', require(path.join(__dirname, 'src', 'routers', 'chat.route.js')));

//static files
app.use('/public', express.static(path.join(__dirname, 'public')));

//WebSocket
io.on('connection', (socket) => {
    socket.on('disconnect', () => { let id = socket.user_data ? socket.user_data.user_id : ''; leave({user_id: id}, io)});

    //comandos
    user_command(io, socket);
    conversation_command(io, socket);
});

//Server 
server.listen(3000, () => {
  console.log('\x1b[36m%s\x1b[0m',`Websocket escuchando en el puerto http://10.0.30.8:3000`);
});

app.listen(3001, ()=>{
  console.log('\x1b[31m%s\x1b[0m',`Api rest escuchando en el puerto http://10.0.30.8:3001`);
})

// const instance = axios.create({
//   headers: {
//     Authorization: 'Bearer 4893|igpT0kcEKIbUKXQVIks17NcCHtfdAZOmoO6ewBtm'
//   }
// });

const consultar_colillas_anuladas = (colilla, message)=>{
  colilla = colilla.split('-');

  axios.post(`${process.env.URL_BACKEND}/visado/consultaestadocolilla`, {
    serie: colilla[0],
    numcolilla: colilla[1],
    user_id: 3
  })
  .then(function (response) {
    console.log(response);
    message.reply(`
    Cantidad: ${response.data.cantidad} \n
    Estado: ${response.data.estado} \n
    Data: ${response.data.datos}
    `)
  })
  .catch(function (error) {
    console.log(error);
  });  
}