const fs = require('fs');
const path = require('path');

module.exports = (io, socket) => {
    const conversation_private = (msg)=>{
        io.emit('chat message', msg);

        let { message, user_emit, user_receiving } = msg;
        let name_file = path.join(__dirname, '..', '..', 'conversations', `con_${user_emit}_${user_receiving}.json`);

        //Verificando conversación

        // console.table(msg)

        // fs.readFile(name_file, (err, data) => {
        //     if (err) console.log(err);
        //     let student = JSON.parse(data);
        //     console.log(student);
        // });

        // let save = {

        // }

        fs.writeFile(name_file, JSON.stringify(msg), (err) => {
            if (err) throw err;
            console.log("The file was succesfully saved!");
        }); 
    }

    //Comandos
    // socket.on('chat message', (msg) => {save(msg)});    

    socket.on("private message", (anotherSocketId, msg) => {
        console.log(socket.id, msg)
        
        socket.to(anotherSocketId).emit("private message", socket.id, msg);
    });
}