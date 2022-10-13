let identificacion = document.getElementById('ddlTipoID');
let cedula = document.getElementById('txtNumID');
let btnConsultar = document.getElementById('btnConsultar');



let respuesta = document.getElementById('txtRespuestaPregunta');

let respuestas = [
    {
        pregunta: '¿ Cuanto es 4 + 3 ?', 
        respuesta: '7'
    }
];

identificacion.selectedIndex = 1;

function responderPreguntas(){
    preguntaProcu = document.getElementById('lblPregunta');
    preguntas.forEach(pregunta => {
        if(pregunta == preguntaProcu.textContent){
            respuestas.value = traerRespuesta(pregunta);
        }
    });
}

function traerRespuesta(pregunta){
    respuestas.forEach(respuesta => {
        if(pregunta == respuesta.pregunta){
            return respuesta.respuesta;
        }
    });
}

function capturarPreguntas(){ // <--------------------------------------------------------- VOY AQUI
    let cambiarPregunta;
    let preguntaProcu = '';
    let preguntas = [];

    let intervalo =  setInterval(()=>{
        cambiarPregunta = document.getElementById('ImageButton1');
        preguntaProcu = document.getElementById('lblPregunta');
        if(!preguntas.includes(preguntaProcu.textContent)){
            preguntas.push(preguntaProcu.textContent);        
        }
        console.log(preguntas);
        cambiarPregunta.click();

    }, 1000);

    setTimeout(() => { clearInterval(intervalo); console.log('All ', preguntas); }, 20000);   
    
}


function prueba(){
    let cambiarPregunta;
    setInterval(()=>{cambiarPregunta = document.getElementById('ImageButton1'); cambiarPregunta.click();}, 2000);
}


respuestas.forEach(element => {
    preguntaProcu = document.getElementById('lblPregunta');
});



cedula.value = 1144161140;
//preguntas.textContent;

const preguntasPagina = [
    "¿Escriba las dos primeras letras del primer nombre de la persona a la cual esta expidiendo el certificado?",
    "¿Escriba los tres primeros digitos del documento a consultar?",
    "¿Escriba la cantidad de letras del primer nombre de la persona a la cual esta expidiendo el certificado?",
    "¿Cual es el primer nombre de la persona a la cual esta expidiendo el certificado?",
    "¿ Cual es la Capital del Atlantico?",
    "¿ Cuanto es 6 + 2 ?",
    "¿ Cuanto es 3 - 2 ?",
    "¿ Cual es la Capital de Antioquia (sin tilde)?",
    "¿Escriba los dos ultimos digitos del documento a consultar?",
    "¿ Cual es la Capital del Vallle del Cauca?",
    "¿ Cuanto es 3 X 3 ?"
]

function validarPregunta(pregunta){
    pregunta == "¿ Cual es la Capital de Antioquia (sin tilde)?" ? respuesta = "Medellin" :      
    pregunta == "¿ Cual es la Capital de Colombia (sin tilde)?" ? respuesta = "Bogota" :  
    pregunta == "¿ Cual es la Capital del Atlantico?" ? respuesta = "Barranquilla" :  
    pregunta == "¿ Cual es la Capital del Vallle del Cauca?" ? respuesta = "Cali" :       
    pregunta == "¿ Cuanto es 5 + 3 ?" ? respuesta = 8 : 
    pregunta == "¿ Cuanto es 4 + 3 ?" ? respuesta = 7 :
    pregunta == "¿ Cuanto es 9 - 2 ?" ? respuesta = 7 :
    pregunta == "¿ Cuanto es 3 X 3 ?" ? respuesta = 9 :
    pregunta == "¿ Cuanto es 2 X 3 ?" ? respuesta = 6 :
    null;

}
