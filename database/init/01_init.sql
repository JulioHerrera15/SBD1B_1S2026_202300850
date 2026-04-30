-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-02-24 00:09:34 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

ALTER SESSION SET CONTAINER = XEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = CEM_USER;

CREATE TABLE Centro_Escuela 
    ( 
     id_centro  NUMBER  NOT NULL , 
     id_escuela NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Centro_Escuela 
    ADD CONSTRAINT Centro_Escuela_PK PRIMARY KEY ( id_centro, id_escuela ) ;

CREATE TABLE Centro_Evaluacion 
    ( 
     id_centro NUMBER  NOT NULL , 
     nombre    VARCHAR2 (150)  NOT NULL , 
     direccion VARCHAR2 (250)  NOT NULL 
    ) 
;

ALTER TABLE Centro_Evaluacion 
    ADD CONSTRAINT Centro_Evaluacion_PK PRIMARY KEY ( id_centro ) ;

CREATE TABLE Departamento 
    ( 
     id_departamento NUMBER  NOT NULL , 
     nombre          VARCHAR2 (200)  NOT NULL 
    ) 
;

ALTER TABLE Departamento 
    ADD CONSTRAINT Departamento_PK PRIMARY KEY ( id_departamento ) ;

CREATE TABLE Escuela_Automovilismo 
    ( 
     id_escuela      NUMBER  NOT NULL , 
     nombre          VARCHAR2 (150)  NOT NULL , 
     direccion       VARCHAR2 (250)  NOT NULL , 
     no_autorizacion VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Escuela_Automovilismo 
    ADD CONSTRAINT Escuela_Automovilismo_PK PRIMARY KEY ( id_escuela ) ;

CREATE TABLE Evaluacion 
    ( 
     id_evaluacion             NUMBER  NOT NULL , 
     correlativo_diario        NUMBER  NOT NULL , 
     fecha_registro            TIMESTAMP  NOT NULL , 
     nota_teorica              NUMBER  NOT NULL , 
     nota_practica             NUMBER  NOT NULL , 
     Persona_id_persona        NUMBER  NOT NULL , 
     Tramite_id_tramite        NUMBER  NOT NULL , 
     Usuario_id_usuario        NUMBER  NOT NULL , 
     id_centro                 NUMBER  NOT NULL , 
     Centro_Escuela_id_escuela NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Evaluacion 
    ADD CONSTRAINT Evaluacion_PK PRIMARY KEY ( id_evaluacion ) ;

CREATE TABLE Evaluacion_Practica 
    ( 
     Evaluacion_id_evaluacion NUMBER  NOT NULL , 
     id_instruccion           NUMBER  NOT NULL , 
     Instructor_id_instructor NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Evaluacion_Practica 
    ADD CONSTRAINT Evaluacion_Practica_PK PRIMARY KEY ( Evaluacion_id_evaluacion, id_instruccion ) ;

CREATE TABLE Evaluacion_Pregunta 
    ( 
     id_evaluacion                  NUMBER  NOT NULL , 
     Pregunta_Teorica_id_pregunta   NUMBER  NOT NULL , 
     Respuesta_Teorica_id_respuesta NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Evaluacion_Pregunta 
    ADD CONSTRAINT Evaluacion_Pregunta_PK PRIMARY KEY ( id_evaluacion, Pregunta_Teorica_id_pregunta ) ;

CREATE TABLE Instruccion_Practica 
    ( 
     id_instruccion NUMBER  NOT NULL , 
     descripcion    VARCHAR2 (500)  NOT NULL 
    ) 
;

ALTER TABLE Instruccion_Practica 
    ADD CONSTRAINT Instruccion_Practica_PK PRIMARY KEY ( id_instruccion ) ;

CREATE TABLE Instructor 
    ( 
     id_instructor NUMBER  NOT NULL , 
     nombre        VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Instructor 
    ADD CONSTRAINT Instructor_PK PRIMARY KEY ( id_instructor ) ;

CREATE TABLE Municipio 
    ( 
     id_municipio                 NUMBER  NOT NULL , 
     nombre                       VARCHAR2 (100)  NOT NULL , 
     Departamento_id_departamento NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Municipio 
    ADD CONSTRAINT Municipio_PK PRIMARY KEY ( id_municipio ) ;

CREATE TABLE Persona 
    ( 
     id_persona             NUMBER  NOT NULL , 
     identificacion         VARCHAR2 (20)  NOT NULL , 
     nombre_completo        VARCHAR2 (200)  NOT NULL , 
     direccion              VARCHAR2 (250)  NOT NULL , 
     telefono               VARCHAR2 (15)  NOT NULL , 
     fotografía             BLOB  NOT NULL , 
     genero                 CHAR (1)  NOT NULL , 
     fecha_nacimiento       DATE  NOT NULL , 
     Municipio_id_municipio NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Persona 
    ADD CONSTRAINT Persona_PK PRIMARY KEY ( id_persona ) ;

CREATE TABLE Pregunta_Teorica 
    ( 
     id_pregunta    NUMBER  NOT NULL , 
     texto_pregunta VARCHAR2 (500)  NOT NULL , 
     imagen_ref     BLOB 
    ) 
;

ALTER TABLE Pregunta_Teorica 
    ADD CONSTRAINT Pregunta_Teorica_PK PRIMARY KEY ( id_pregunta ) ;

CREATE TABLE Respuesta_Teorica 
    ( 
     id_respuesta                 NUMBER  NOT NULL , 
     texto_respuesta              VARCHAR2 (500)  NOT NULL , 
     imagen_respuesta             BLOB , 
     es_correcta                  NUMBER  NOT NULL , 
     Pregunta_Teorica_id_pregunta NUMBER  NOT NULL 
    ) 
;

ALTER TABLE Respuesta_Teorica 
    ADD CONSTRAINT Respuesta_Teorica_PK PRIMARY KEY ( id_respuesta ) ;

CREATE TABLE Tramite 
    ( 
     id_tramite    NUMBER  NOT NULL , 
     tipo_licencia CHAR (1)  NOT NULL , 
     tipo_tramite  VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Tramite 
    ADD CONSTRAINT Tramite_PK PRIMARY KEY ( id_tramite ) ;

CREATE TABLE Usuario 
    ( 
     id_usuario NUMBER  NOT NULL , 
     nombre     VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Usuario 
    ADD CONSTRAINT Usuario_PK PRIMARY KEY ( id_usuario ) ;

ALTER TABLE Evaluacion_Pregunta 
    ADD CONSTRAINT Eval_Preg_Evaluacion_FK FOREIGN KEY 
    ( 
     id_evaluacion
    ) 
    REFERENCES Evaluacion 
    ( 
     id_evaluacion
    ) 
;

ALTER TABLE Evaluacion_Pregunta 
    ADD CONSTRAINT Eval_Preg_Preg_Teo_FK FOREIGN KEY 
    ( 
     Pregunta_Teorica_id_pregunta
    ) 
    REFERENCES Pregunta_Teorica 
    ( 
     id_pregunta
    ) 
;

ALTER TABLE Evaluacion_Pregunta 
    ADD CONSTRAINT Eval_Preg_Resp_Teo_FK FOREIGN KEY 
    ( 
     Respuesta_Teorica_id_respuesta
    ) 
    REFERENCES Respuesta_Teorica 
    ( 
     id_respuesta
    ) 
;

ALTER TABLE Evaluacion 
    ADD CONSTRAINT Evaluacion_CE_FK FOREIGN KEY 
    ( 
     id_centro,
     Centro_Escuela_id_escuela
    ) 
    REFERENCES Centro_Escuela 
    ( 
     id_centro,
     id_escuela
    ) 
;

ALTER TABLE Evaluacion 
    ADD CONSTRAINT Evaluacion_Persona_FK FOREIGN KEY 
    ( 
     Persona_id_persona
    ) 
    REFERENCES Persona 
    ( 
     id_persona
    ) 
;

ALTER TABLE Evaluacion_Practica 
    ADD CONSTRAINT Evaluacion_PI_Practica_FK FOREIGN KEY 
    ( 
     id_instruccion
    ) 
    REFERENCES Instruccion_Practica 
    ( 
     id_instruccion
    ) 
;

ALTER TABLE Evaluacion_Practica 
    ADD CONSTRAINT Evaluacion_Prac_Eval_FK FOREIGN KEY 
    ( 
     Evaluacion_id_evaluacion
    ) 
    REFERENCES Evaluacion 
    ( 
     id_evaluacion
    ) 
;

ALTER TABLE Evaluacion_Practica 
    ADD CONSTRAINT Evaluacion_Prac_Inst_FK FOREIGN KEY 
    ( 
     Instructor_id_instructor
    ) 
    REFERENCES Instructor 
    ( 
     id_instructor
    ) 
;

ALTER TABLE Evaluacion 
    ADD CONSTRAINT Evaluacion_Tramite_FK FOREIGN KEY 
    ( 
     Tramite_id_tramite
    ) 
    REFERENCES Tramite 
    ( 
     id_tramite
    ) 
;

ALTER TABLE Evaluacion 
    ADD CONSTRAINT Evaluacion_Usuario_FK FOREIGN KEY 
    ( 
     Usuario_id_usuario
    ) 
    REFERENCES Usuario 
    ( 
     id_usuario
    ) 
;

ALTER TABLE Centro_Escuela 
    ADD CONSTRAINT FK_CE_Centro FOREIGN KEY 
    ( 
     id_centro
    ) 
    REFERENCES Centro_Evaluacion 
    ( 
     id_centro
    ) 
;

ALTER TABLE Centro_Escuela 
    ADD CONSTRAINT FK_CE_Escuela FOREIGN KEY 
    ( 
     id_escuela
    ) 
    REFERENCES Escuela_Automovilismo 
    ( 
     id_escuela
    ) 
;

ALTER TABLE Municipio 
    ADD CONSTRAINT Muni_Dep_FK FOREIGN KEY 
    ( 
     Departamento_id_departamento
    ) 
    REFERENCES Departamento 
    ( 
     id_departamento
    ) 
;

ALTER TABLE Persona 
    ADD CONSTRAINT Persona_Municipio_FK FOREIGN KEY 
    ( 
     Municipio_id_municipio
    ) 
    REFERENCES Municipio 
    ( 
     id_municipio
    ) 
;

ALTER TABLE Respuesta_Teorica 
    ADD CONSTRAINT Resp_Teo_Preg_Teo_FK FOREIGN KEY 
    ( 
     Pregunta_Teorica_id_pregunta
    ) 
    REFERENCES Pregunta_Teorica 
    ( 
     id_pregunta
    ) 
;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
