const { Router } = require('express');
const router = Router();

const user = require('../models/user.model')

router.post('/update_whatsapp', async (req, res)=>{
    try {
        let {value, _id} = req.body;
        await user.findOneAndUpdate({_id}, {whatsapp: value});
        res.json({successful: true, message: 'Registro actualizado', data: []});
    } catch (error) {
        res.json({successful: false, message: 'Tenemos problemas al actualizar el registro', data: []});
    }
});

module.exports = router;