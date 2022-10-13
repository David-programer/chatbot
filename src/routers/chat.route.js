const path = require('path');
const multer = require('multer');
const { Router } = require('express');
const router = Router();

//settings multer
let storage = multer.diskStorage({
    destination: path.join(__dirname, '..', '..', 'public', 'storage'),
    filename: (req, file, cb)=>{ cb(null, `${Date.now()}_${file.originalname}`)}
});

const upload = multer({ storage });

router.post('/upload', upload.single('file'), async (req, res)=>{
    try {
        let file_name = `${process.env.HOST_AND_PORT_API_REST}/public/storage/${req.file.filename}`;
        res.json({successful: true, message: '¡El archivo se ha almacenado con éxito!', data: {url: file_name}});
    } catch (error) {
        res.json({successful: false, message: 'Tenemos problemas al subir el archivo!', data: error});
    }
});

module.exports = router;