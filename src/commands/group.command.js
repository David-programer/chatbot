const group = require('../models/group.model');

module.exports = {
    group_command: (io, socket) => {
        // const joined =  async(data)=>{
        //     let user_ = await user.findOne({user_id: data.user_id})
    
        //     if(!user_){
        //         user_ = new user({user_id : data.user_id, name: data.name, email: data.email, phone_number: data.phone_number});
        //         await user_.save();
        //     }else{
        //         user_ = await user.findByIdAndUpdate(user_._id, {last_connection_time: 'En línea'});
        //         user_ = await user.findById(user_._id);
        //     }
    
        //     socket.user_data = user_;
        //     io.emit('joined_user', {successful: true, data : user_});
        //     io.emit(`update_user_${data.user_id}`, {successful: true, data: user_});    
        // }

        const list_group = async(data)=>{

        }
    
        //Comandos
        socket.on("joined", (data) => {joined(data)});
    }
}