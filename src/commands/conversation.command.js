const client = require('../whatsapp/index');
const chat = require('../models/chat.model');
const user = require('../models/user.model');
const bot = require('../commands/bot.command');

const setting_data = (data)=>{
    if(!data) return data;

    let dates = {};
    data.conversation.forEach((element, index) => {
        let date = new Date(element.created).toLocaleDateString();
        dates[date] ? null : (data.conversation.splice(index, 0, {type_date: true, created: element.created}), dates[date] = true);
    })

    return data
};

const send_message = async (io, data)=>{
    let response = {successful: true}, note = null;
    let { from, to, conversation } = data;
    let _chat = await chat.findOne({from, to});

    if(!_chat){_chat = await chat.findOne({from: to, to : from})}

    // Verificar si el usuario está en línea
    let user_to = await user.findOne({user_id: to});
    if(user_to && user_to.whatsapp && user_to.phone_number && user_to.last_connection_time != 'En línea' && socket.user_data){
        client.sendMessage(`${user_to.phone_number}@c.us`, `🔔 *${socket.user_data.name} te ha enviado un mensaje a través de SAMAN:* \n${conversation[0].message}`);
        note = 'Whatsapp';
    }

    if(!_chat){ _chat = new chat({ from, to, conversation}); await _chat.save();
    }else{
        let body =  {author: from, message: conversation[0].message, note}
        conversation[0].file ? body.file = {url: conversation[0].file.url, type: conversation[0].file.type, name: conversation[0].file.name} : null;
        _chat = await chat.findByIdAndUpdate(_chat._id, {"$push": { "conversation": body}});
        _chat = await chat.findById(_chat._id);
    }

    return {...response, data: setting_data(_chat)}
};

module.exports = {
    conversation_command: (io, socket) => {
        const conversation_private = async (data)=>{
            if(data.to == '90'){ await send_message(io, data); await bot(io, data, send_message)}
            else{
                let response = await send_message(io, data)
                io.emit(data.to, {...response, type: 'receive message'});
                io.emit(data.from, {...response, type: 'send private message'}); 
            }
        }
    
        const join_chat = async (data)=>{
            let {to, from} = data;      
            let chat_ = await chat.findOne({from, to});
            let response = {successful: false}
            chat_ ? '' : chat_ = await chat.findOne({to: from, from: to});
    
            if(chat_){
                response.successful = true;
                chat_.conversation.forEach(element => { element.author == to ? element.viewed = true : null })
                await chat.findByIdAndUpdate(chat_._id, chat_)
            }
    
            io.emit(from, {...response, data: setting_data(chat_), type: 'join'});
        }
    
        const typing =  async(data)=>{
            io.emit(data.to, {successful: true, data: {from: data.from}, type: 'typing'});
        }
    
        //Comandos
        // socket.on('chat message', (msg) => {save(msg)});    
        socket.on('typing', (data) => {typing(data)});
        socket.on('join', (data) => {join_chat(data)});
        socket.on("send private message", (data) => {conversation_private(data)});
    }
}