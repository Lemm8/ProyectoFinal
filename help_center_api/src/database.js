const mysql = require('mysql');
console.log("")
const mysql_connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DATABASE
});

mysql_connection.connect(function (err) {
    if(err) {
        console.log(err);
        return;
    } else {
        console.log('BD conectada');
    }
});

module.exports = mysql_connection;
