const transporter =  require('../emails/config.email');

const send_email = async (data)=>{
    let {to, subject, message, from} = data;

    await transporter.sendMail({
        from: `<${from}>`, to, subject,
        // text: "Hello world?", // plain text body
        html: 
        ` 
        <!DOCTYPE html>
        <html lang="es">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;700&display=swap" rel="stylesheet">
            <title>Tecnología te informa</title>
        </head>
        <body style="align-items: center;background-color: #ffffff;display: flex;height: 100vh;justify-content: center;">    
            <div style=" border-radius: 15px;box-shadow: -10px -10px 10px #f5f6f7">
                <div style="border: 1px solid #d5dadc; border-radius: 15px; box-shadow: 5px 5px 5px #909394 ;">
                    <div class="title" style="margin-top: 1em;display: block;text-align: center;color: #023e8a;">
                        <div >
                            <img src="https://www.sured.com.co/wp-content/uploads/2020/07/Su-red-azul.png" alt="logo" style="width: 30%;">
                        </div>
                        <h1 style="font-family: sans-serif;text-align: center;display:inline-block;">
                            Mensaje enviado desde SAMAN 
                        </h1>
                        <div style="display: block; text-align: center; width: 60%;margin-left: auto; margin-right: auto;">
                            <p style="font-size: 20px;font-family: sans-serif;display: inline-block;">
                                <p>${message}</p>
                            </p>				
                        </div>
                        <div style="width: 100%; justify-content: center; margin-left: auto; margin-right: auto;">                                
                            <p style="width: 80%;font-size: 16px;font-family: sans-serif;display: inline-block;">
                                En caso de presentar alguna novedad, por favor escribenos a 
                                <strong><i>coordinadordeaplicaciones@acertemos.com</i></strong>
                                estaremos dispuestos a colaborarte.
                            </p>
                        </div>                
                </div>
            </div>
        </body>
        </html>`, 
    })
}

module.exports = send_email;