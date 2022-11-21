const {model, Schema}= require('mongoose');

module.exports = new model('chat', new Schema({
    from : {type: Number, required: true},
    to: {type: Number, required: true},
    conversation: [
        {
            note: String,
            answer : Object,
            message: {type: String},
            author: {type: Number, required: true},
            viewed: {type: Boolean, default: false},
            created: {type: Date, default: Date.now},
            type_date : {type: Boolean, default: false},
            file: {type: Object, default: {name : null, type: null, url: null }},
        }
    ],
},{
    collection: 'chats'
}));