const express = require('express'); //importando express
const mysql = require('mysql'); //importando mysql 
const myconn = require('express-myconnection'); //importando express-myconnection
const routes = require('./routes'); //importamos el archivo de las rutas
const bodyParser = require('body-parser'); //immportando bodyparser
const cors = require('cors');

const app = express(); //Para ejecutar express
app.set('port',process.env.PORT || 9000) //nos ayuda mostrando el puerto que se usara en caso de estar en produccion o en el local usando el puerto asignado
const dbOptions = {
    host: 'localhost',
    port: 3306,
    user:'root',
    password:'',
    database:'cajamorelia'
}

//middlewares =====================================================================================
app.use(myconn(mysql,dbOptions, 'single'))

//routes ===========================================================================================
app.get('/', (req, res)=>{
    res.send('Bienvenido a la API')
})
app.use(bodyParser.urlencoded({extended:false}))
app.use(bodyParser.json())
app.use(cors()) //usamos cors para que no haya problemas de comunicacion entre el servidor y el navegador
app.use('/clientes', routes) //determinamos la ruta principal y accedemos al archivo routes para acceder a las demas rutas

//Server running ========================================================================
app.listen(app.get('port'), () =>{  //Para verificar que esta corriendo correctamente la API en el puerto
    console.log('El servidor esta corriendo en el puerto',app.get('port'))
})