const nodemailer = require("nodemailer");

let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: {
      user: 'cirisdavi8@gmail.com',
      pass: 'komgoyhyhxpozzkd'
    },
});


transporter.verify().then(()=>{
    console.log('\x1b[35m%s\x1b[0m',`Gmail is ready`);
})

module.exports = transporter;