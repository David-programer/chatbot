// const chat = require('../models/chat.model');
// const user = require('../models/user.model');
let command_old = {};
const fs = require('fs');
const path = require('path');
const axios = require('axios');
const { MessageMedia } = require('whatsapp-web.js');

module.exports = (message, client) => {

    // const consultando = async ()=>{
    //   const media = await MessageMedia.fromUrl('https://media.tenor.com/Z3ooALkQ8tQAAAAd/macaco-babu%C3%ADno.gif');
    //   message.reply(media)
    // }

    //Comandos
    if(message.body === '/reportes') {
        message.reply(` *MENÚ DE REPORTES SAMAN* \n1. Lista puntos de venta`);
        command_old['/reportes'] = true;
        return
    }
    
    else if(command_old['/reportes'] && message.body === '1'){
      client.sendMessage(message.from, 'Consultando...');
        
      axios.post(`${process.env.URL_BACKEND}/reportes/auditoria/listapuntoventas`, {}, { responseType: 'arraybuffer' })
        .then(async (response)=>{
          const file_path = path.join(__dirname, '..', '..', '..', 'public', 'reportes', 'reporte_listapuntoventas.xlsx');
          console.log(file_path);
          let data = Buffer.from(response.data, 'binary').toString('base64');
          let base64Data = data.replace(/^data:image\/png;base64,/, "");
      
          fs.writeFile(file_path, base64Data, 'base64', function(err) {
            if(!err){
              const media = MessageMedia.fromFilePath(file_path);
              message.reply(media);
            }
          });
        })
        .catch(function (error) {
          console.log(error);
        });  

      command_old = {};
      return
    }
}