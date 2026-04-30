const express = require('express');
const router = express.Router();
const db = require('../database');

// 1. Estadísticas de evaluaciones por centro y escuela
router.get('/estadisticas', async (req, res) => {
    try {
        const sql = `
            SELECT 
                ce.nombre AS centro,
                ea.nombre AS escuela,
                COUNT(e.id_evaluacion) AS total_examenes,
                ROUND(AVG(e.nota_teorica), 2) AS promedio_teorico,
                ROUND(AVG(e.nota_practica), 2) AS promedio_practico,
                SUM(CASE WHEN (e.nota_teorica + e.nota_practica) >= 140 THEN 1 ELSE 0 END) AS aprobados
            FROM Evaluacion e
            JOIN Centro_Evaluacion ce ON e.id_centro = ce.id_centro
            JOIN Escuela_Automovilismo ea ON e.Centro_Escuela_id_escuela = ea.id_escuela
            GROUP BY ce.nombre, ea.nombre
        `;
        const result = await db.query(sql);
        res.json({ success: true, data: result.rows });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// 2. Ranking de evaluados por resultado final
router.get('/ranking', async (req, res) => {
    try {
        const sql = `
            SELECT 
                p.nombre_completo AS aspirante,
                e.nota_teorica,
                e.nota_practica,
                (e.nota_teorica + e.nota_practica) AS resultado_final
            FROM Evaluacion e
            JOIN Persona p ON e.Persona_id_persona = p.id_persona
            ORDER BY resultado_final DESC
        `;
        const result = await db.query(sql);
        res.json({ success: true, data: result.rows });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// 3. Pregunta con menor porcentaje de aciertos
router.get('/peor-pregunta', async (req, res) => {
    try {
        const sql = `
            SELECT 
                pt.id_pregunta,
                pt.texto_pregunta,
                COUNT(ep.id_evaluacion) AS total_respuestas,
                SUM(rt.es_correcta) AS aciertos,
                ROUND((SUM(rt.es_correcta) / COUNT(ep.id_evaluacion)) * 100, 2) AS porcentaje_aciertos
            FROM Pregunta_Teorica pt
            JOIN Evaluacion_Pregunta ep ON pt.id_pregunta = ep.Pregunta_Teorica_id_pregunta
            JOIN Respuesta_Teorica rt ON ep.Respuesta_Teorica_id_respuesta = rt.id_respuesta
            GROUP BY pt.id_pregunta, pt.texto_pregunta
            ORDER BY porcentaje_aciertos ASC
            FETCH FIRST 1 ROWS ONLY
        `;
        const result = await db.query(sql);
        res.json({ success: true, data: result.rows });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

module.exports = router;