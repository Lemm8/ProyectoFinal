const { request } = require('express');
const express = require('express');
const router = express.Router();

// obtener conexión
const mysql_connection = require('../database');

// GET
router.get('/consultorios', (req, res) => {
    mysql_connection.query('select * from consultorio', (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

// GET CONSULTORIOS POR SERVICIO
router.get('/consultorios/consultorio_servicios/:id_especialidad', (req, res) => {
    const { id_especialidad } = req.params;
    const query = 'CALL get_consultorios_especialidad(?)';
    mysql_connection.query(query, [id_especialidad], (err, rows, fields) => {
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);            
        }
    });
});


router.get('/consultorios/consultorios_interes/:id_paciente', (req, res) => {
    const { id_paciente } = req.params;
    const query = 'CALL get_fav_consultorios(?);';
    mysql_connection.query(query, [id_paciente], (err, rows, fields) => {
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);            
        }
    })
});


router.get('/consultorios_profesional/:id_profesional', (req, res) => {
    const { id_profesional } = req.params;
    const query = 'call get_consultorios_profesional(?)';
    mysql_connection.query(query, [id_profesional], (err, rows, fields) => {
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);            
        }
    })
});

module.exports = router;