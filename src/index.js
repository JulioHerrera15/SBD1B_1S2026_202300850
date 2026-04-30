require('dotenv').config();
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const db = require('./database');

const app = express();

app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const PORT = process.env.PORT || 3000;

// Inicializa la base de datos y arranca el servidor
async function startServer() {
    try {
        await db.initialize();
        console.log('Conexión a Oracle DB establecida.');
        
        // Rutas API
        app.use('/api/estadisticas', require('./routes/stats.routes'));
        app.use('/api/crud', require('./routes/crud.routes'));

        app.listen(PORT, () => {
            console.log(`Servidor escuchando en el puerto ${PORT}`);
        });
    } catch (err) {
        console.error('Error al iniciar el servidor:', err);
        process.exit(1);
    }
}

startServer();

// Para apagar limpiamente la base de datos en caso de cerrar la API
process.on('SIGINT', async () => {
    console.log('Cerrando conexión a la DB...');
    await db.close();
    process.exit(0);
});