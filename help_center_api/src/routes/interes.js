const { request } = require('express');
const express = require('express');
const router = express.Router();

// obtener conexión
const mysql_connection = require('../database');

// GET
router.get('/interes_consultorio/:id', (req, res) => {
    const { id } = req.params;
    const query = 'select * from interes where id_consultorio = ?';
    mysql_connection.query(query, [id], (err, rows, fields) => {
        if(!err) {
            res.status(200).json(rows);
        } else {
            res.status(500).send(err);
        }
    });
});

router.get('/interes_paciente_consultorio/:id_paciente/:id_consultorio', ( req, res ) => {
    const { id_paciente, id_consultorio } = req.params;
    const query = 'select * from interes where id_paciente = ? and id_consultorio = ?;';    
    mysql_connection.query(query, [id_paciente, id_consultorio], (err, rows, fields) => {
        if(!err) {
            if(rows.length > 0) {
                res.status(200).json(true);
            } else {
                res.status(200).json(false);
            }
        } else {
            res.status(500).send(err);
        }
    });
});


function getDate() {
    var today = new Date();
    var date = today.getFullYear() + '-' + (today.getMonth()+1) + '-' + today.getDate() +  ' ';
    var time = today.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit', second:'2-digit'});
    return date + time;
}

router.post('/interes', (req, res) => {
    const { id_paciente, id_consultorio } = req.body;
    const query = "insert into interes(id_paciente, id_consultorio, fecha) values(?, ?, ?);";
    const date = getDate();
    mysql_connection.query(query, [id_paciente, id_consultorio, date], (err, result) => {
        if(!err) {
            res.status(200).send(true);
        } else {
            res.status(500).send(false);
        }
    });
});

router.delete('/interes/:id_paciente/:id_consultorio', (req, res) => {
    const { id_paciente, id_consultorio } = req.params;
    const query = "delete from interes where id_paciente = ? and id_consultorio = ?;";
    mysql_connection.query(query, [id_paciente, id_consultorio], (err, result) => {
        if(!err) {
            res.status(200).send(true);
        } else {
            res.status(500).send(false);
        }
    });
});



module.exports = router;