# Centros de Evaluación de Manejo - Proyecto 2

Este repositorio contiene la entrega del Proyecto 2 del curso de Sistemas de Bases de Datos 1 de la Universidad de San Carlos de Guatemala. 

El proyecto consiste en la evolución del sistema de gestión para los Centros de Evaluación de Manejo hacia una arquitectura de microservicios. Utiliza una base de datos **Oracle XE 21c dockerizada** (con inicialización automática del DDL) y expone las operaciones de datos mediante un **API REST construido en Node.js y Express**.

## Requisitos
- Docker Desktop
- Docker Compose
- Node.js (opcional para desarrollo local fuera del contenedor)
- DBeaver (para conectarse y verificar la base de datos)
- Postman (para probar los endpoints)

## Instrucciones para levantar el proyecto
1. Clonar el repositorio.
2. Asegurar tener el script DDL de la Práctica 1 en el archivo `database/init.sql`.
3. Ejecutar el siguiente comando desde la raíz del proyecto para construir y arrancar los contenedores de Oracle DB y la API REST:
   ```bash
   docker-compose up -d --build
   ```
4. Esperar unos minutos (la imagen XE de Oracle tarda un poco en inicializar la base de datos y correr el script DDL). Puedes ver los logs para confirmar usando:
   ```bash
   docker logs -f sbd1-oracle-db
   ```
5. Una vez que la base de datos indique que está lista, el backend (Node.js) se conectará exitosamente y empezará a escuchar peticiones en `http://localhost:3000`.

## Conexión a DBeaver
- **Host:** localhost
- **Port:** 1521
- **Database/Service Name:** XEPDB1
- **User:** system
- **Password:** admin

## Endpoints Disponibles
La API expone las siguientes rutas principales:

**Consultas Estadísticas:**
- `GET /api/estadisticas/estadisticas` : Resumen de exámenes y promedios por centro y escuela.
- `GET /api/estadisticas/ranking` : Ranking de aspirantes según la nota final (teórica + práctica).
- `GET /api/estadisticas/peor-pregunta` : Identificación de la pregunta teórica con menor porcentaje de acierto.

**CRUD Dinámico:** (Soporta las 15 tablas del esquema)
- `POST /api/crud/{tabla}` : Insertar registro.
- `GET /api/crud/{tabla}` : Leer todos los registros.
- `GET /api/crud/{tabla}/buscar?idColumn=...&idValue=...` : Leer un registro.
- `PUT /api/crud/{tabla}?idColumn=...&idValue=...` : Actualizar registro.
- `DELETE /api/crud/{tabla}?idColumn=...&idValue=...` : Borrar registro.

## Evidencias y Capturas de Pantalla
(*Reemplaza o añade a continuación las capturas solicitadas en la rúbrica*)

### 1. Despliegue en Docker y carga DDL
![Docker Logs](/img/logs_nodejs.png)
![Docker Logs](/img/logs_oracle.png)

### 2. Conexión en DBeaver
![DBeaver Tables](/img/dbeaver_conexion.png)

### 3. Pruebas Postman (CRUD y Estadísticas)
#### 3.1 GET:
![Postman GET](/img/get_persona.png)
![Postman GET](/img/get_por_id_persona.png)

#### 3.2 POST:
![Postman POST](/img/post_persona.png)

#### 3.3 PUT:
![Postman PUT](/img/put_centro.png)

#### 3.4 DELETE:
![Postman DELETE](/img/delete_persona.png)

#### 3.5 Estadísticas:
![Postman Estadísticas](/img/get_estadisticas.png)
![Postman Ranking](/img/get_ranking.png)
![Postman Peor Pregunta](/img/get_peor_pregunta.png)