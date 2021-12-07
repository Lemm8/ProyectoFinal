const { request } = require('express');
const express = require('express');
const router = express.Router();

// obtener conexión
const mysql_connection = require('../database');

// GET
router.get('/resenas', (req, res) => {
    mysql_connection.query('select * from resena;', (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

// GET CONSULTORIOS POR SERVICIO
router.get('/resenas_consultorio/:id_consultorio', (req, res) => {
    const { id_consultorio } = req.params;
    const query = 'CALL get_resenas_consultorio(?)';
    mysql_connection.query(query, [id_consultorio], (err, rows, fields) => {
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);            
        }
    });
});


router.post('/resena', (req, res) => {
    const { id_paciente, id_consultorio, calificacion, comentario } = req.body;
    const query = 'CALL registrar_resena(?, ?, ?, ?);';
    mysql_connection.query(query, [id_paciente, id_consultorio, calificacion, comentario], (err, rows, result) => {
        if(!err) {
            res.status(200).json(true);
        } else {
            console.log(err);            
        }
    })
});

// POST CONSUTORIO
// router.post('/consultorios', ( req, res ) => {
//     const 
// });

module.exports = router;