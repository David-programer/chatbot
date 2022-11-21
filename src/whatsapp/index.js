const path = require('path');
const qrcode = require('qrcode-terminal');
const bot = require('../commands/bot.command');
const { Client, LocalAuth } = require('whatsapp-web.js');
const client = new Client( {
    authStrategy: new LocalAuth({dataPath: path.join(__dirname, 'wwebjs_auth/')})
});

//QR para el authenticated
client.on('qr', qr => { qrcode.generate(qr, {small: true});});

//Evento para determinar si el cliente está listo para recibir y enviar mensajes
client.on('ready', () => { console.log('\x1b[32m%s\x1b[0m','Whatsapp is ready')});

client.on('message', (message) => {
    bot({message, client, mode: 'Whatsapp'}); 
    
    return

//   if(message.body === '1') {
//     message_old = message.body;
//     message.reply('Digite el número y la serie de la colilla, con la siguiente estructura: TT-1521512');
//     return
// 	}

//   if(!message.fromMe && message_old === '1'){
//     message.reply('Consultando...')
//     consultar_colillas_anuladas(message.body, message)
//   }
});

client.initialize();

module.exports = client;
