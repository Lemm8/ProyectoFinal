const express = require('express');
const app = express();
require( 'dotenv' ).config({ path: './src/.env' });

// SETTINGS
// configurar puerto
app.set('port', process.env.port || 3000);


// MIDDLEWARES
// entender y hacer accesible doc json
app.use(express.json());


// ROUTES
app.use(require('./routes/consultorios'));
app.use(require('./routes/pacientes'));
app.use(require('./routes/profesionales'));
app.use(require('./routes/auth'));
app.use(require('./routes/especialidades'));
app.use(require('./routes/interes'));
app.use(require('./routes/resenas'));


// inicializar el servidor en puerto
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
});