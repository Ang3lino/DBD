
-- 1 cREAR LAS SIGUIENTE TRES tablas

CREATE TABLE PELIS17(
    PID NUMBER, 
    TITULO VARCHAR2(20),
    ANIO NUMBER, 
    DIRECTOR VARCHAR2(20),
    PRIMARY KEY (PID)
);

CREATE TABLE CRITICOCINE17 (
    CID NUMBER, 
    NOMBRE VARCHAR2(20),
    PRIMARY KEY (CID)
);

CREATE TABLE VALORACION17(
    PID NUMBER,
    CID NUMBER,
    PUNTUACION NUMBER,
    FECHA DATE,
    PRIMARY KEY(PID, CID),
    FOREIGN KEY (PID) REFERENCES PELIS17(PID),
    FOREIGN KEY(CID) REFERENCES CRITICOCINE17(CID)
);

-- Insercion de tuplas
INSERT INTO PELIS17( PID , TITULO , ANIO , DIRECTOR ) 
    VALUES (1, 'El titanic', 1998, 'James Cameron');
INSERT INTO PELIS17( PID , TITULO , ANIO , DIRECTOR ) 
    VALUES (2, 'Avatar', 2014, 'James Cameron');
INSERT INTO PELIS17( PID , TITULO , ANIO , DIRECTOR ) 
    VALUES (3, 'Infinity war', 2018, 'Tony Stark');
INSERT INTO PELIS17( PID , TITULO , ANIO , DIRECTOR ) 
    VALUES (4, 'El camino', 2019, 'Heisenberg');
INSERT INTO PELIS17( PID , TITULO , ANIO , DIRECTOR ) 
    VALUES (5, 'Shrek', 1997, 'Pena nieto');
SELECT * FROM PELIS17;

INSERT INTO CRITICOCINE17 ( CID , NOMBRE )
    VALUES (1, 'Antoine de Baecque');
INSERT INTO CRITICOCINE17 ( CID , NOMBRE )
    VALUES (2, 'Montserrat Hormigos ');
INSERT INTO CRITICOCINE17 ( CID , NOMBRE )
    VALUES (3, 'José Ramón');
INSERT INTO CRITICOCINE17 ( CID , NOMBRE )
    VALUES (4, 'Miguel Barbachano');
INSERT INTO CRITICOCINE17 ( CID , NOMBRE )
    VALUES (5, 'Owen Gleiberman');
SELECT * FROM CRITICOCINE17;

INSERT INTO VALORACION17( PID , CID , PUNTUACION , FECHA )
    VALUES (1, 1, 10, '22-OCT-2019');
INSERT INTO VALORACION17( PID , CID , PUNTUACION , FECHA )
    VALUES (1, 2, 9, '22-OCT-2019');
INSERT INTO VALORACION17( PID , CID , PUNTUACION , FECHA )
    VALUES (1, 3, 8, '22-OCT-2019');

INSERT INTO VALORACION17( PID , CID , PUNTUACION , FECHA )
    VALUES (2, 2, 9, '22-OCT-2019');
INSERT INTO VALORACION17( PID , CID , PUNTUACION , FECHA )
    VALUES (3, 3, 8, '22-OCT-2019');
INSERT INTO VALORACION17( PID , CID , PUNTUACION , FECHA )
    VALUES (4, 4, 7, '22-OCT-2019');
INSERT INTO VALORACION17( PID , CID , PUNTUACION , FECHA )
    VALUES (5, 5, 6, '22-OCT-2019');
SELECT * FROM VALORACION17;

-- extra
UPDATE VALORACION17 SET PUNTUACION = 9 WHERE PID = 2 AND CID = 2;
UPDATE VALORACION17 SET PUNTUACION = 8 WHERE PID = 3 AND CID = 3;
UPDATE VALORACION17 SET PUNTUACION = 7 WHERE PID = 4 AND CID = 4;
UPDATE VALORACION17 SET PUNTUACION = 6 WHERE PID = 5 AND CID = 5;

CREATE VIEW v2 AS 
    SELECT p.TITULO, c.NOMBRE, v.PUNTUACION
    FROM PELIS17 p, CRITICOCINE17 c, VALORACION17 v
    WHERE v.CID = c.CID 
        AND v.PID = p.PID ;
SELECT * FROM v2;

CREATE VIEW v3 AS 
    SELECT MAX(v.PUNTUACION) as puntuacion
        FROM v2 v, PELIS17 p 
        WHERE p.PID = 1;
SELECT * FROM v3;

-- 4
SELECT * FROM v2;
CREATE VIEW v4 AS
    SELECT titulo, count(*) as numero_valoraciones, avg(PUNTUACION) as promedio
    FROM v2
    GROUP BY titulo;
SELECT * FROM v4;

-- 5
CREATE VIEW Post80 AS
    SELECT titulo, anio FROM PELIS17 
    WHERE anio > 1980;
SELECT * FROM Post80;


-- Actualizas vistas

-- 6 
-- a
SELECT * FROM POST80;
INSERT INTO  POST80 (titulo, anio)
    VALUES ('La vida es bella', 1950);  -- Error, cannot insert null
SELECT * FROM POST80;

-- b 
DELETE POST80 
WHERE TITULO = 'Shrek' AND ANIO = 1997;  
-- Error report -
-- ORA-02292: integrity constraint (DBDC17.SYS_C0051427) violated - child record found

-- c 
UPDATE POST80 
SET TITULO = 'Shrek 2' WHERE ANIO = 1997;
SELECT * FROM POST80;
SELECT * FROM PELIS17;
-- Row updated
-- Se cambiaron recursivamente

-- 7
CREATE VIEW v7 AS
SELECT TITULO FROM PELIS17 GROUP BY TITULO;

SELECT * FROM V7;
SELECT * FROM PELIS17;

UPDATE V7 SET TITULO = 'Infinity war 2' WHERE TITULO = 'Infinity war';
-- SQL Error: ORA-01732: data manipulation operation not legal on this view

SELECT * FROM PELIS17;

-- 8 
-- a
CREATE VIEW v8 AS
    SELECT p.titulo, p.PID, p.anio 
        FROM PELIS17 p
        WHERE p.anio > 1980
    ;
SELECT * FROM v8;

SELECT * FROM PELIS17;
INSERT INTO v8 (titulo, pid, anio)
    VALUES ('Lola la trailera', 6, 1940)
-- Se inserta en PELIS17, no en la vista

SELECT * FROM PELIS17;
SELECT * FROM v8;

-- b
DROP VIEW V8;
CREATE VIEW v8 AS
    SELECT p.titulo, p.PID, p.anio 
        FROM PELIS17 p
        WHERE p.anio > 1980
    WITH CHECK OPTION;
SELECT * FROM v8;
INSERT INTO v8 (titulo, pid, anio) VALUES ('Cantiflas', 6, 1950);
-- Esta vez no se inserto en pelis17
SELECT * FROM PELIS17;

-- 9 punto 2 ?


-- Borrar vistas

-- 10
DROP VIEW POST80;
CREATE VIEW Post80 AS
    SELECT titulo, anio FROM PELIS17 
    WHERE anio > 1980
WITH READ ONLY;
INSERT INTO POST80(titulo, anio) VALUES ('Pollitos en fuga', 1970);
-- SQL Error: ORA-42399: cannot perform a DML operation on a read-only view


-- 11
