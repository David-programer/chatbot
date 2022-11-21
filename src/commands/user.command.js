const user = require('../models/user.model');
const chat = require('../models/chat.model');

const estruct_data = async (data, users)=>{
    let users_ = {};
    let chats = await chat.find().or([{from: data.id_user}, {to: data.id_user}])

    users.forEach(element => {
        if(element.user_id != data.id_user){
            users_[element.user_id] = {...element._doc, notifications: 0, date_last_message: {}};
        }
    });

    if(chats){
        chats.forEach(chat => {
            let id = chat.from == data.id_user ? chat.to : chat.from;
            let {created, message} = chat.conversation[chat.conversation.length - 1];
            chat.conversation.forEach(element => {
                if(element.author != data.id_user){
                    element.viewed == false ? users_[element.author].notifications += 1 : null;
                }
            })
            if(users_[id]) {users_[id]['date_last_message']['message'] = message; users_[id]['date_last_message']['created'] = created;}
        })
    }

    return users_;
}

const leave = async(data, io)=>{
    let user_ = await user.findOne({user_id: data.user_id})

    if(user_){
        user_ = await user.findByIdAndUpdate(user_._id, {last_connection_time: Date.now()});
        user_ = await user.findById(user_._id);
    }

    io.emit('joined_user', {successful: true, data : user_});
}

module.exports = {
    leave,
    user_command: (io, socket) => {
        const joined =  async(data)=>{
            let user_ = await user.findOne({user_id: data.user_id})
    
            if(!user_){
                user_ = new user({user_id : data.user_id, name: data.name, email: data.email, phone_number: data.phone_number});
                await user_.save();
            }else{
                user_ = await user.findByIdAndUpdate(user_._id, {last_connection_time: 'En línea'});
                user_ = await user.findById(user_._id);
            }
    
            socket.user_data = user_;
            io.emit('joined_user', {successful: true, data : user_});
            io.emit(`update_user_${data.user_id}`, {successful: true, data: user_});    
        }
    
        const list_users = async(data)=>{
            let users = await user.find();
            
            estruct_data(data, users).then(response => {
                io.emit(data.id_user, {successful: true, data: response, type : 'list_users'});
            })

            // mentions(data.id_user)
        }

        const chat_add = async(data)=>{
            await user.findOneAndUpdate({user_id: data.user_id}, {"$push": { "chats": data.user_add}});
        }

        const register_user = async(data)=>{
            let user_ = new user({user_id : data.user_id, name: data.name, email: data.email, phone_number: data.phone_number, chats: data.chats, last_connection_time: 'Sin iniciar sesión'});
            await user_.save();
        }

        // const mentions = async(data)=>{
        //     let messages = [];
        //     let chats = await chat.find({'conversation.mentions': { '$all': [data] }});
        //     chats.forEach(item => {
        //         item.conversation.forEach(element =>{if(element.mentions.find(i => i == data) && !element.viewed) messages.push(element)})
        //     });

        //     io.emit(data, {successful: true, data: messages, type : 'mentions'});
        // }
    
        //Comandos
        socket.on("joined", (data) => {joined(data)});
        socket.on("leave", (data) => {leave(data, io)});
        socket.on("chat_add", (data) => {chat_add(data)});
        socket.on("list_users", (data) => {list_users(data)});
        socket.on("register_user", (data)=> {register_user(data)});
    }
}