const express =  require('express')
const routes = express.Router()

//Mostrar todos los registros de los clientes
routes.get('/', (req, res)=>{
    req.getConnection((err,conn)=>{
        if(err) return res.send(err)

        conn.query('CALL mostrarClientes()',(err,rows)=>{
            if(err) return res.send(err)
                if(!rows[0]){
                    return res.send('No hay ningun registro')
                }
                res.json(rows[0])

        })
    })
})

//Mostramos la informacion del cliente 
routes.get('/verCliente/:id', (req, res)=>{
    req.getConnection((err,conn)=>{
        if(err) return res.send(err)
        console.log(req.params.id)
        conn.query('CALL detalleCliente(?)',[req.params.id],(err,rows)=>{
            if(err) return res.send(err)
                console.log(rows)
                if(!rows[0][0]){
                    return res.send('No existe el cliente con ese identificador')
                }   
                res.json(rows[0][0])
        })
    })
})

//checamos los datos financieros del cliente con su id
routes.get('/verDetalles/:id', (req, res)=>{
    req.getConnection((err,conn)=>{
        if(err) return res.send(err)

        conn.query('CALL detalleCuenta(?)',[req.params.id],(err,rows)=>{
            if(err) return res.send(err)
                if(!rows[0][0]){
                    return res.send('No existe el cliente con ese identificador')
                } 
            res.json(rows[0][0])
        })
    })
})
//Actualizamos los datos personales del clente
routes.patch('/editarCliente/:id', (req, res)=>{
    console.log(req)
    req.getConnection((err,conn)=>{
        if(err) return res.send(err)

        conn.query('CALL editarInformacionClientes(?,?,?,?,?,?)',[req.params.id, req.body.nombre, req.body.apellidoPaterno, req.body.apellidoMaterno, req.body.rfc,req.body.curp],(err,rows)=>{
            if(err) return res.send(err)
            res.json(rows)
        })
    })
})
//Eliminamos el elemento con el id capturado
routes.delete('/eliminar/:id', (req, res)=>{
    req.getConnection((err,conn)=>{
        if(err) return res.send(err)

        conn.query('CALL eliminarCliente(?)',[req.params.id],(err,rows)=>{
            if(err) return res.send(err)
            res.json('Cliente eliminado')
        })
    })
})




module.exports = routes