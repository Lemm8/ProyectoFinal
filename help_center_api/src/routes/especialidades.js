const { request } = require('express');
const express = require('express');
const router = express.Router();

// obtener conexión
const mysql_connection = require('../database');

// GET
router.get('/especialidades', (req, res) => {
    mysql_connection.query('select * from especialidad', (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.get('/consultorio_especialidades/:id', ( req, res ) => {
    const { id } = req.params;
    const query = 'call get_especialidades_consultorio(?);';
    mysql_connection.query(query, [id], (err, rows, fields) => {
        if(!err) {
            res.json(rows[0]);
        } else {
            console.log(err);
        }
    });
});

module.exports = router;