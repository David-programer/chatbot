const {model, Schema}= require('mongoose');

const schema_user = new Schema({
    email: String,
    phone_number: String,
    chats: {type: Array, default: null},
    name: {type: String, require: true},
    user_id : {type: Number, require: true},
    whatsapp: {type: Boolean, default: true},
    last_connection_time : {type: String, default: 'En línea'}
},{ collection: 'users'});

module.exports = new model('user', schema_user);