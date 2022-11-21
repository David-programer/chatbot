const { Router } = require('express');
const router = Router();

router.get('/commands', async (req, res)=>{
    try {
        let commands = [
            {command: '/menu', description: 'Menú de comandos'},
            {command: '/exit', description: 'Cancelar comandos'}, 
            {command: '/reportes', description: 'Lista de reportes a generar'},
        ];        

        res.json({successful: true, message: '¡Comandos generados con éxito!', data: commands});
    } catch (error) {
        res.json({successful: false, message: 'Tenemos problemas al generar la lista!', data: error});
    }
});

module.exports = router;