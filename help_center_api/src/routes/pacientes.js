const { request } = require('express');
const express = require('express');
const router = express.Router();

// obtener conexión
const mysql_connection = require('../database');

// GET
router.get('/pacientes', (req, res) => {
    mysql_connection.query('select * from paciente', (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

// GET{ID}
router.get('/pacientes/:id', ( req, res ) => {
    // obtener id
    const { id } = req.params;
    mysql_connection.query('select * from paciente where id_paciente = ?', [id] , (err, rows, fields) => {
        if(!err) {
            // if( rows.length > 0 )
            //     res.json(rows[0]);
            // else {
            //     res.json(false);
            // }
            res.json(rows[0]);
        } else {
            console.log(err);
        }
    });
});



module.exports = router;