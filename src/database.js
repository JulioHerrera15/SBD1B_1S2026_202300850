const oracledb = require('oracledb');
require('dotenv').config();

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;
oracledb.autoCommit = true;

// Definir objeto de conexión
let pool;

async function initialize() {
    // Retry connection mechanism since Oracle XE takes a while to start up in Docker
    let retries = 10;
    while(retries > 0) {
        try {
            pool = await oracledb.createPool({
                user: process.env.DB_USER,
                password: process.env.DB_PASSWORD,
                connectString: process.env.DB_CONNECT_STRING,
                poolMin: 2,
                poolMax: 10,
                poolIncrement: 1
            });
            console.log("Pool de conexiones creado con éxito.");
            return pool;
        } catch (error) {
            console.error(`Error de conexión a la BD, reintentando. Intentos restantes: ${retries - 1}`);
            retries -= 1;
            await new Promise(res => setTimeout(res, 5000));
        }
    }
    throw new Error('No se pudo conectar a la base de datos después de múltiples reintentos.');
}

async function close() {
    if (pool) {
        try {
            await pool.close(10);
            console.log("Pool de conexiones cerrado");
        } catch(err) {
            console.error("Error al cerrar pool de conexiones", err);
        }
    }
}

async function query(sql, binds = [], options = {}) {
    let connection;
    try {
        connection = await oracledb.getConnection();
        const result = await connection.execute(sql, binds, options);
        return result;
    } catch (err) {
        console.error("Error ejecutando query = ", err);
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error("Error cerrando conexión", err);
            }
        }
    }
}

module.exports = {
    initialize,
    close,
    query
};