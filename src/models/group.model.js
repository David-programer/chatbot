const {model, Schema}= require('mongoose');

const schema_group = new Schema({
    name: {type: String, require: true},
    members: [Number],
    profile_photo_path: String,
    conversation: [
        {
            note: String,
            mentions: Array,
            message: {type: String},
            author: {type: Number, required: true},
            viewed: {type: Boolean, default: false},
            created: {type: Date, default: Date.now},
            type_date : {type: Boolean, default: false},
            file: {type: Object, default: {name : null, type: null, url: null }},
        }
    ],
},{ collection: 'groups'});

module.exports = new model('group', schema_group);