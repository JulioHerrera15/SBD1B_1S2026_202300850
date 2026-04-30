const express = require('express');
const router = express.Router();
const db = require('../database');

// HEALTH CHECK
router.get('/health', (req, res) => {
    res.json({ success: true, message: "API CRUD está corriendo correctamente" });
});

// 1. CREATE (POST)
router.post('/:tabla', async (req, res) => {
    try {
        const { tabla } = req.params;
        const keys = Object.keys(req.body);
        const values = Object.values(req.body).map(val => {
            if (typeof val === 'string' && /^\d{4}-\d{2}-\d{2}/.test(val)) {
                return new Date(val);
            }
            return val;
        });

        if (tabla.toUpperCase() === 'PERSONA' && !keys.includes('fotografía')) {
            keys.push('fotografía');
            values.push(Buffer.from('imagen_falsa_para_pruebas_base64'));
        }
        
        if (keys.length === 0) return res.status(400).json({ error: "El cuerpo de la petición está vacío" });

        const placeholders = keys.map((_, index) => `:${index + 1}`).join(', ');
        const sql = `INSERT INTO ${tabla} (${keys.join(', ')}) VALUES (${placeholders})`;

        const result = await db.query(sql, values);
        res.status(201).json({ success: true, message: `Registro insertado en ${tabla}` });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// 2. READ ALL (GET)
router.get('/:tabla', async (req, res) => {
    try {
        const { tabla } = req.params;
        const sql = tabla.toUpperCase() === 'PERSONA' 
            ? `SELECT id_persona, identificacion, nombre_completo, direccion, telefono, genero, fecha_nacimiento, Municipio_id_municipio FROM ${tabla}`
            : `SELECT * FROM ${tabla}`;
        const result = await db.query(sql);
        res.json({ success: true, data: result.rows });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// 2.1 READ ONE (GET by ID)
router.get('/:tabla/buscar', async (req, res) => {
    try {
        const { tabla } = req.params;
        const { idColumn, idValue } = req.query;

        if (!idColumn || !idValue) return res.status(400).json({ error: "Faltan parámetros de búsqueda (idColumn, idValue)"});
        const projection = tabla.toUpperCase() === 'PERSONA' 
            ? 'id_persona, identificacion, nombre_completo, direccion, telefono, genero, fecha_nacimiento, Municipio_id_municipio' 
            : '*';
        const sql = `SELECT ${projection} FROM ${tabla} WHERE ${idColumn} = :1`;
        const result = await db.query(sql, [idValue]);
        res.json({ success: true, data: result.rows });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// 3. UPDATE (PUT)
// Asume la misma lógica de query params
router.put('/:tabla', async (req, res) => {
    try {
        const { tabla } = req.params;
        const { idColumn, idValue } = req.query;
        const keys = Object.keys(req.body);
        const values = Object.values(req.body);
        
        if (keys.length === 0 || !idColumn || !idValue) {
            return res.status(400).json({ error: "Parámetros incompletos. req.body e id(s) requeridos." });
        }

        const setClause = keys.map((key, index) => `${key} = :${index + 1}`).join(', ');
        const sql = `UPDATE ${tabla} SET ${setClause} WHERE ${idColumn} = :${keys.length + 1}`;

        const result = await db.query(sql, [...values, idValue]);
        res.json({ success: true, message: `Registro(s) actualizado(s) en ${tabla}` });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// 4. DELETE (DELETE)
router.delete('/:tabla', async (req, res) => {
    try {
        const { tabla } = req.params;
        const { idColumn, idValue } = req.query;

        if (!idColumn || !idValue) return res.status(400).json({ error: "Se requiere idColumn y idValue" });

        const sql = `DELETE FROM ${tabla} WHERE ${idColumn} = :1`;
        const result = await db.query(sql, [idValue]);
        res.json({ success: true, message: `Registro eliminado de ${tabla}` });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

module.exports = router;