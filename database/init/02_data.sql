-- =============================================
-- ARCHIVO: 02_data_load.sql
-- DESCRIPCIÓN: Carga de datos iniciales corregidos
-- =============================================

ALTER SESSION SET CONTAINER = XEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = CEM_USER;

-- 1. DATOS GEOGRÁFICOS
INSERT INTO Departamento (id_departamento, nombre) VALUES (1, 'Guatemala');
INSERT INTO Departamento (id_departamento, nombre) VALUES (2, 'Sacatepéquez');
INSERT INTO Departamento (id_departamento, nombre) VALUES (3, 'Escuintla');

INSERT INTO Municipio (id_municipio, nombre, Departamento_id_departamento) VALUES (1, 'Guatemala', 1);
INSERT INTO Municipio (id_municipio, nombre, Departamento_id_departamento) VALUES (2, 'Mixco', 1);
INSERT INTO Municipio (id_municipio, nombre, Departamento_id_departamento) VALUES (3, 'Villa Nueva', 1);
INSERT INTO Municipio (id_municipio, nombre, Departamento_id_departamento) VALUES (4, 'Escuintla', 3);
INSERT INTO Municipio (id_municipio, nombre, Departamento_id_departamento) VALUES (5, 'Antigua Guatemala', 2);

-- 2. CENTROS Y ESCUELAS (Incluye direcciones obligatorias)
INSERT INTO Centro_Evaluacion (id_centro, nombre, direccion) VALUES (1, 'Centro de Evaluación Zona 12', 'Zona 12, Ciudad');
INSERT INTO Centro_Evaluacion (id_centro, nombre, direccion) VALUES (2, 'Centro de Evaluación Antigua Guatemala', 'Antigua Centro');
INSERT INTO Centro_Evaluacion (id_centro, nombre, direccion) VALUES (3, 'Centro de Evaluación Escuintla', 'Centro Escuintla');

INSERT INTO Escuela_Automovilismo (id_escuela, nombre, direccion, no_autorizacion) VALUES (1, 'Escuela de Manejo AutoMaster', 'Avenida Reforma 15-45, Zona 10', 'ESC-AM-001');
INSERT INTO Escuela_Automovilismo (id_escuela, nombre, direccion, no_autorizacion) VALUES (2, 'Academia Vial GuateDrive', 'Boulevard Los Próceres 18-20, Zona 10', 'ESC-GD-002');
INSERT INTO Escuela_Automovilismo (id_escuela, nombre, direccion, no_autorizacion) VALUES (3, 'Instituto de Conducción Segura', 'Calzada Roosevelt 25-30, Zona 11', 'ESC-ICS-003');

-- 3. RELACIÓN CENTRO_ESCUELA (Corrección de la ubicación 2-2 necesaria para el examen 5)
INSERT INTO Centro_Escuela (id_centro, id_escuela) VALUES (1, 1);
INSERT INTO Centro_Escuela (id_centro, id_escuela) VALUES (2, 1);
INSERT INTO Centro_Escuela (id_centro, id_escuela) VALUES (1, 2);
INSERT INTO Centro_Escuela (id_centro, id_escuela) VALUES (2, 3);
INSERT INTO Centro_Escuela (id_centro, id_escuela) VALUES (3, 3);
INSERT INTO Centro_Escuela (id_centro, id_escuela) VALUES (2, 2); 

-- 4. DEPENDENCIAS DE CATÁLOGOS
INSERT INTO Usuario (id_usuario, nombre) VALUES (1, 'Admin Calificador');
INSERT INTO Instructor (id_instructor, nombre) VALUES (1, 'Instructor Asignado');
INSERT INTO Tramite (id_tramite, tipo_licencia, tipo_tramite) VALUES (1, 'A', 'Licencia de Conducir');
INSERT INTO Tramite (id_tramite, tipo_licencia, tipo_tramite) VALUES (2, 'B', 'Licencia de Conducir');

-- 5. BANCO DE PREGUNTAS Y RESPUESTAS (Normalizado)
INSERT INTO Pregunta_Teorica (id_pregunta, texto_pregunta) VALUES (1, '¿Cuál es la distancia mínima que debe mantener entre vehículos en carretera?');
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (1, '2 metros', 0, 1);
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (2, '3 segundos de distancia', 1, 1);

INSERT INTO Pregunta_Teorica (id_pregunta, texto_pregunta) VALUES (2, '¿Qué significa una señal de alto?');
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (3, 'Reducir velocidad', 0, 2);
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (4, 'Detenerse completamente', 1, 2);

INSERT INTO Pregunta_Teorica (id_pregunta, texto_pregunta) VALUES (3, '¿Cuál es el límite de velocidad en zona escolar?');
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (5, '20 km/h', 1, 3);
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (6, '30 km/h', 0, 3);

INSERT INTO Pregunta_Teorica (id_pregunta, texto_pregunta) VALUES (4, '¿Qué debe hacer al ver una ambulancia con sirena activada?');
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (7, 'Acelerar para salir del camino', 0, 4);
INSERT INTO Respuesta_Teorica (id_respuesta, texto_respuesta, es_correcta, Pregunta_Teorica_id_pregunta) VALUES (8, 'Orillarse y detenerse', 1, 4);

INSERT INTO Instruccion_Practica (id_instruccion, descripcion) VALUES (1, 'Realizar estacionamiento en paralelo en un espacio de 6 metros');
INSERT INTO Instruccion_Practica (id_instruccion, descripcion) VALUES (2, 'Conducir en reversa por 50 metros manteniendo trayectoria recta');
INSERT INTO Instruccion_Practica (id_instruccion, descripcion) VALUES (3, 'Maniobra de tres puntos en espacio reducido');
INSERT INTO Instruccion_Practica (id_instruccion, descripcion) VALUES (4, 'Conducción en zona urbana respetando señales de tránsito');

-- 6. PERSONAS (Manejo de BLOB y campos NOT NULL)
INSERT INTO Persona (id_persona, identificacion, nombre_completo, direccion, telefono, fotografía, genero, fecha_nacimiento, Municipio_id_municipio) 
VALUES (1, 'CUI-1', 'Juan Carlos López García', 'Ciudad', '0000', EMPTY_BLOB(), 'M', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO Persona (id_persona, identificacion, nombre_completo, direccion, telefono, fotografía, genero, fecha_nacimiento, Municipio_id_municipio) 
VALUES (2, 'CUI-2', 'María Elena Rodríguez Morales', 'Ciudad', '0000', EMPTY_BLOB(), 'F', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO Persona (id_persona, identificacion, nombre_completo, direccion, telefono, fotografía, genero, fecha_nacimiento, Municipio_id_municipio) 
VALUES (3, 'CUI-3', 'Carlos Alberto Méndez Castillo', 'Ciudad', '0000', EMPTY_BLOB(), 'M', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 3);

INSERT INTO Persona (id_persona, identificacion, nombre_completo, direccion, telefono, fotografía, genero, fecha_nacimiento, Municipio_id_municipio) 
VALUES (4, 'CUI-4', 'Ana Sofía Guerrero Díaz', 'Ciudad', '0000', EMPTY_BLOB(), 'F', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 4);

INSERT INTO Persona (id_persona, identificacion, nombre_completo, direccion, telefono, fotografía, genero, fecha_nacimiento, Municipio_id_municipio) 
VALUES (5, 'CUI-5', 'Pedro José Hernández Ruiz', 'Ciudad', '0000', EMPTY_BLOB(), 'M', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 5);

-- 7. EVALUACIONES (Maestras)
INSERT INTO Evaluacion (id_evaluacion, correlativo_diario, fecha_registro, nota_teorica, nota_practica, Persona_id_persona, Tramite_id_tramite, Usuario_id_usuario, id_centro, Centro_Escuela_id_escuela) 
VALUES (1, 1, TO_TIMESTAMP('2025-01-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 31, 1, 1, 1, 1, 1);

INSERT INTO Evaluacion (id_evaluacion, correlativo_diario, fecha_registro, nota_teorica, nota_practica, Persona_id_persona, Tramite_id_tramite, Usuario_id_usuario, id_centro, Centro_Escuela_id_escuela) 
VALUES (2, 2, TO_TIMESTAMP('2025-01-15 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 50, 2, 2, 1, 2, 1);

INSERT INTO Evaluacion (id_evaluacion, correlativo_diario, fecha_registro, nota_teorica, nota_practica, Persona_id_persona, Tramite_id_tramite, Usuario_id_usuario, id_centro, Centro_Escuela_id_escuela) 
VALUES (3, 3, TO_TIMESTAMP('2025-01-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 15, 3, 1, 1, 1, 2);

INSERT INTO Evaluacion (id_evaluacion, correlativo_diario, fecha_registro, nota_teorica, nota_practica, Persona_id_persona, Tramite_id_tramite, Usuario_id_usuario, id_centro, Centro_Escuela_id_escuela) 
VALUES (4, 4, TO_TIMESTAMP('2025-01-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0, 4, 1, 1, 3, 3);

INSERT INTO Evaluacion (id_evaluacion, correlativo_diario, fecha_registro, nota_teorica, nota_practica, Persona_id_persona, Tramite_id_tramite, Usuario_id_usuario, id_centro, Centro_Escuela_id_escuela) 
VALUES (5, 5, TO_TIMESTAMP('2025-01-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0, 5, 2, 1, 2, 2);

-- 8. DETALLE DE RESPUESTAS (Transaccional)
INSERT INTO Evaluacion_Pregunta (id_evaluacion, Pregunta_Teorica_id_pregunta, Respuesta_Teorica_id_respuesta) VALUES (1, 1, 2);
INSERT INTO Evaluacion_Pregunta (id_evaluacion, Pregunta_Teorica_id_pregunta, Respuesta_Teorica_id_respuesta) VALUES (1, 2, 4);
INSERT INTO Evaluacion_Practica (Evaluacion_id_evaluacion, id_instruccion, Instructor_id_instructor) VALUES (1, 1, 1);
INSERT INTO Evaluacion_Practica (Evaluacion_id_evaluacion, id_instruccion, Instructor_id_instructor) VALUES (1, 2, 1);

INSERT INTO Evaluacion_Pregunta (id_evaluacion, Pregunta_Teorica_id_pregunta, Respuesta_Teorica_id_respuesta) VALUES (2, 3, 5);
INSERT INTO Evaluacion_Pregunta (id_evaluacion, Pregunta_Teorica_id_pregunta, Respuesta_Teorica_id_respuesta) VALUES (2, 4, 8);
INSERT INTO Evaluacion_Practica (Evaluacion_id_evaluacion, id_instruccion, Instructor_id_instructor) VALUES (2, 3, 1);
INSERT INTO Evaluacion_Practica (Evaluacion_id_evaluacion, id_instruccion, Instructor_id_instructor) VALUES (2, 4, 1);

INSERT INTO Evaluacion_Pregunta (id_evaluacion, Pregunta_Teorica_id_pregunta, Respuesta_Teorica_id_respuesta) VALUES (3, 1, 2);
INSERT INTO Evaluacion_Pregunta (id_evaluacion, Pregunta_Teorica_id_pregunta, Respuesta_Teorica_id_respuesta) VALUES (3, 2, 3);
INSERT INTO Evaluacion_Practica (Evaluacion_id_evaluacion, id_instruccion, Instructor_id_instructor) VALUES (3, 1, 1);

COMMIT;