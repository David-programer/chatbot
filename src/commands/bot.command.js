const chat = require('../models/chat.model');
// const { send_message } = require('./conversation.command');

let command_old = {};
const fs = require('fs');
const path = require('path');
const axios = require('axios');

// {
//     from: 32,
//     to: 90,
//     conversation: [ { message: 'hola', author: 32, file: [Object] } ]
// }

module.exports = async (io, data, send_message) => {
    let conversation = data.conversation[0]

    //Comandos
    if(conversation.message === '/exit'){
        let response = await send_message(io, {to: data.from, from: data.to, conversation: [ { message: `Menú disponible`, author: data.to} ] });
        command_old = {};
        io.emit(data.from, {...response, type: 'send private message'}); 
    }

    else if(conversation.message === '/reportes') {
        let response = await send_message(io, {to: data.from, from: data.to, conversation: [ { message: `MENÚ DE REPORTES SAMAN \n1. Lista puntos de venta`, author: data.to} ] })
        
        io.emit(data.to, {...response, type: 'receive message'});
        io.emit(data.from, {...response, type: 'send private message'}); 

        command_old['/reportes'] = true;
        return
    }

    else if(command_old['/reportes']  && conversation.message === '1'){
        let response = await send_message(io, {to: data.from, from: data.to, conversation: [ { message: 'Consultando...', author: data.to} ] })
        io.emit(data.from, {...response, type: 'send private message'}); 
        
        axios.post(`${process.env.URL_BACKEND}/reportes/auditoria/listapuntoventas`, {}, { responseType: 'arraybuffer' })
            .then(async (response)=>{
                const file_path = path.join(__dirname, '..', '..', 'public', 'reportes', 'reporte_listapuntoventas.xlsx');
                
                let data_file = Buffer.from(response.data, 'binary').toString('base64');
                let base64Data = data_file.replace(/^data:image\/png;base64,/, "");
            
                fs.writeFile(file_path, base64Data, 'base64', async function(err) {
                    if(!err){
                        let response = await send_message(io, {to: data.from, from: data.to, conversation: [ { message: 'Archivo generado', author: data.to, file: {name: 'reporte_listapuntoventas.xlsx', type:'aplication/', url: `${process.env.HOST_AND_PORT_API_REST}/public/reportes/reporte_listapuntoventas.xlsx`}} ] })
                        io.emit(data.from, {...response, type: 'send private message'}); 
                    }
                });
            })
            .catch(function (error) {
                console.log(error);
            });  

        command_old = {};
        return
    }

    else{
        let response = await send_message(io, {to: data.from, from: data.to, conversation: [ { message: `No reconozco el comando, por favor verifique si está bien digitado`, author: data.to} ] });
        command_old = {};

        io.emit(data.from, {...response, type: 'send private message'}); 
    }
}