/* Crear tablas */

CREATE TABLE aerolineas (
id_aerolinea INTEGER,
nombre_aerolinea VARCHAR(30)
);

CREATE TABLE aeropuertos (
id_aeropuerto INTEGER,
nombre_aeropuerto VARCHAR(30)
);

CREATE TABLE movimientos (
id_movimiento INTEGER,
descripcion VARCHAR(30)
);

CREATE TABLE vuelos (
id_aerolinea INTEGER,
id_aeropuerto INTEGER,
id_movimiento INTEGER,
dia DATE
);

/* Agregar datos. */ 

INSERT INTO aerolineas (id_aerolinea,nombre_aerolinea)
VALUES (1,'Volaris'),
(2,'Aeromar'),
(3,'Interjet'),
(4,'Aeromexico');

INSERT INTO aeropuertos (id_aeropuerto,nombre_aeropuerto)
VALUES (1,'Benito Juarez'),
(2,'Guanajuato'),
(3,'La Paz'),
(4,'Oaxaca');

INSERT INTO movimientos (id_movimiento,descripcion)
VALUES (1,'Salida'),
(2,'Llegada');

INSERT INTO vuelos (id_aerolinea,id_aeropuerto,id_movimiento,dia)
VALUES (1,1,1,'2021-05-02'),
(2,1,1,'2021-05-02'),
(3,2,2,'2021-05-02'),
(4,3,2,'2021-05-02'),
(1,3,2,'2021-05-02'),
(2,1,1,'2021-05-02'),
(2,3,1,'2021-05-04'),
(3,4,1,'2021-05-04'),
(3,4,1,'2021-05-04');

/* 1. ¿Cuál es el nombre aeropuerto que ha tenido mayor movimiento durante el año? */

SELECT 	aeropuertos.nombre_aeropuerto, 
	COUNT(vuelos.id_aeropuerto) AS mayormovimientoaño
FROM vuelos
LEFT JOIN aeropuertos ON vuelos.id_aeropuerto = aeropuertos.id_aeropuerto
GROUP BY vuelos.id_aeropuerto,
	 aeropuertos.nombre_aeropuerto	
ORDER BY COUNT(vuelos.id_aeropuerto) DESC
LIMIT 2;

/* 2. ¿Cuál es el nombre aerolínea que ha realizado mayor número de vuelos durante el año? */

SELECT 	aerolineas.nombre_aerolinea,
	COUNT(vuelos.id_aerolinea) AS mayornumvuelosaño
FROM vuelos
LEFT JOIN aerolineas ON vuelos.id_aerolinea = aerolineas.id_aerolinea
GROUP BY vuelos.id_aerolinea,
	 aerolineas.nombre_aerolinea
ORDER BY COUNT(vuelos.id_aerolinea) DESC
LIMIT 2;

/* 3. ¿En qué día se han tenido mayor número de vuelos? */

SELECT 	vuelos.dia, 
	COUNT(vuelos.id_aerolinea) AS vuelosdia
FROM vuelos
GROUP BY vuelos.dia
ORDER BY COUNT(vuelos.dia) DESC
LIMIT 1;

/* 4. ¿Cuáles son las aerolíneas que tienen mas de 2 vuelos por día?
   En esta consulta el resultado es considerando todos los dias.      */

SELECT aerolineas.NOMBRE_AEROLINEA, count(vuelos.ID_AEROLINEA) as cuentavuelostotales
FROM vuelos
LEFT JOIN aerolineas ON vuelos.id_aerolinea = aerolineas.id_aerolinea
GROUP BY vuelos.id_aerolinea,
	 aerolineas.NOMBRE_AEROLINEA
HAVING COUNT(vuelos.id_aerolinea) > 2;

/* 4. ¿Cuáles son las aerolíneas que tienen mas de 2 vuelos por día?
   En esta consulta el resultado es considerando un dia en específico. */

SELECT aerolineas.NOMBRE_AEROLINEA, count(vuelos.ID_AEROLINEA) as cuentavuelosdia
FROM vuelos
LEFT JOIN aerolineas ON vuelos.id_aerolinea = aerolineas.id_aerolinea
WHERE vuelos.dia = '2021-05-02'
GROUP BY vuelos.id_aerolinea,
		 aerolineas.NOMBRE_AEROLINEA
HAVING COUNT(vuelos.id_aerolinea) > 2;