const { request } = require('express');
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs')

const router = express.Router();

// obtener conexión
const mysql_connection = require('../database');


// AUTENTICACIÓN Y REGISTRO DE PACIENTE
router.post('/auth/registro_paciente', ( req, res ) => {
    // OBTENER DATOS
    const { nombre, apellidos, correo, contrasena } = req.body;

    const query = 'call registrar_paciente(?, ?, ?, ?)';
    var hashedPassword = bcrypt.hashSync(contrasena, 8);

    // QUERY DE CORREO
    mysql_connection.query(query, [nombre, apellidos, correo, hashedPassword], async (err, results) => {
        if(err) {
            res.status(500).send(err);
        } else {
            var result = (JSON.parse(JSON.stringify(results[0])))[0];
            return res.status(200).send(result);            
        }
    });
})

// AUTENTICACIÓN Y REGISTRO DE CONSULTORIO
router.post('/auth/registro_consultorio', ( req, res ) => {
    // OBTENER DATOS
    const { nombre, correo, telefono, contrasena, direccion, tipo } = req.body;

    const query = 'call registrar_consultorio(?, ?, ?, ?, ?, ?)';
    var hashedPassword = bcrypt.hashSync(contrasena, 8);

    // QUERY DE CORREO
    mysql_connection.query(query, [nombre, correo, telefono, hashedPassword, direccion, tipo], async (err, results) => {
        if(err) {
            res.status(500).send(err);
        } else {
            var result = (JSON.parse(JSON.stringify(results[0])))[0];
            return res.status(200).send(result);            
        }
    });
})

// AUTENTICACIÓN Y REGISTRO DE PROFESIONAL
router.post('/auth/registro_profesional', ( req, res ) => {
    // OBTENER DATOS
    const { nombre, apellidos, correo, contrasena } = req.body;

    const query = 'call registrar_profesional(?, ?, ?, ?)';
    var hashedPassword = bcrypt.hashSync(contrasena, 8);

    // QUERY DE CORREO
    mysql_connection.query(query, [nombre, apellidos, correo, hashedPassword], async (err, results) => {
        if(err) {
            res.status(500).send(err);
        } else {
            var result = (JSON.parse(JSON.stringify(results[0])))[0];
            return res.status(200).send(result);         
        }
    });
})




// AUTENTICACIÓN Y LOGIN DEL USUARIO
router.post('/auth/login_usuario', ( req, res ) => {
    // OBTENER DATOS
    const { tipoUsuario, correo, contrasena } = req.body;
    // COMPROBAR QUE SI EXISTA EL CORREO
    const query = 'call login_usuario(?, ?)';
    // QUERY DE CORREO
    mysql_connection.query(query, [tipoUsuario, correo], async (err, results, rows) => {
        if(err) {
            return res.status(500).send(err)
        } else {
            var rows = JSON.parse(JSON.stringify(results[0]));
            //console.log(rows[0].contrasena);
            bcrypt.compare(contrasena, rows[0].contrasena, function( err, result ) {                    
                if(err) {
                    console.log(err);
                    return res.status(500).send("Email o contraseña inválidos");
                } else {
                    
                    if (result) {
                        return res.status(200).send(rows[0]);
                    } else {
                        return res.status(500).send('Contraseña inválida');
                    }                                                
                }
            });
        }        
    });
})



module.exports = router;