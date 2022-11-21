let command_old = {};
const fs = require('fs');
const path = require('path');
const axios = require('axios');
const { MessageMedia } = require('whatsapp-web.js');

// const consultando = async ()=>{
//   const media = await MessageMedia.fromUrl('https://media.tenor.com/Z3ooALkQ8tQAAAAd/macaco-babu%C3%ADno.gif');
//   message.reply(media)
// }

module.exports = async ({io, data, send_message, mode = 'saman', client, message}) => {
    let message_user = mode == 'saman' ? data.conversation[0].message : message.body

    //Comandos
    if(message_user === '/exit'){
        let response = await send_message({to: data.from, from: data.to, conversation: [ { message: `Menú disponible`, author: data.to} ] });
        command_old = {};
        io.emit(data.from, {...response, type: 'send private message'}); 
    }

    else if(message_user === '/reportes') {
        if(mode == 'saman'){
            let response = await send_message({to: data.from, from: data.to, conversation: [ { message: `MENÚ DE REPORTES SAMAN \n 1. Lista puntos de venta`, author: data.to} ] })
        
            io.emit(data.to, {...response, type: 'receive message'});
            io.emit(data.from, {...response, type: 'send private message'}); 
        }else message.reply(` *MENÚ DE REPORTES SAMAN* \n1. Lista puntos de venta`);

        command_old['/reportes'] = true;
        return
    }

    else if(command_old['/reportes']  && message_user === '1'){

        if(mode == 'saman'){
            let response = await send_message({to: data.from, from: data.to, conversation: [ { message: 'Consultando...', author: data.to} ] })
            io.emit(data.from, {...response, type: 'send private message'}); 
        }else client.sendMessage(message.from, 'Consultando...');

        axios.post(`${process.env.URL_BACKEND}/reportes/auditoria/listapuntoventas`, {}, { responseType: 'arraybuffer' })
            .then(async (response)=>{
                const file_path = path.join(__dirname, '..', '..', 'public', 'reportes', 'reporte_listapuntoventas.xlsx');
                
                let data_file = Buffer.from(response.data, 'binary').toString('base64');
                let base64Data = data_file.replace(/^data:image\/png;base64,/, "");
            
                fs.writeFile(file_path, base64Data, 'base64', async function(err) {
                    if(!err){
                        if(mode == 'saman'){
                            let response = await send_message({to: data.from, from: data.to, conversation: [ { message: 'Archivo generado', author: data.to, file: {name: 'reporte_listapuntoventas.xlsx', type:'aplication/', url: `${process.env.HOST_AND_PORT_API_REST}/public/reportes/reporte_listapuntoventas.xlsx`}} ] })
                            io.emit(data.from, {...response, type: 'send private message'}); 
                        }else{
                            const media = MessageMedia.fromFilePath(file_path);
                            message.reply(media);
                        }
                    }
                });
            })
            .catch(function (error) {console.log(error);});  

        command_old = {};
        return
    }

    else{
        if(mode == 'saman'){
            let response = await send_message({to: data.from, from: data.to, conversation: [ { message: `No reconozco el comando, por favor verifique si está bien digitado`, author: data.to} ] });
            io.emit(data.from, {...response, type: 'send private message'}); 
        }else message.reply('No reconozco el comando, por favor verifique si está bien digitado')

        command_old = {};
    }
}