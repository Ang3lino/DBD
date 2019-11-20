
-- Credenciales 
-- Nombre conexión: DBDCXX
-- Usuario: DBDCXX
-- Contraseña: DBDCXX

-- Host: vsids11.si.ehu.es
-- SID: GIPUZKOA

-- 1 Crear las siguientes tablas

CREATE TABLE PINTORES17 (
    codpintor NUMBER PRIMARY KEY, 
    nombre VARCHAR2(31),
    nomartistico varchar2(31), 
    nacionalidad varchar2(15), 
    fechanac DATE, 
    fechafalle date
);

CREATE TABLE CUADRO17 (
    titulo varchar2(31), 
    codpintor number REFERENCES PINTORES17 (codpintor), 
    fecha date, 
    tecnica varchar2(15), 
    estilo varchar2(15), 
    primary key (titulo, codpintor)
);

-- 2 Inserte tuplas
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (1, 'Angel Lopez Manriquez', 'Angelino', 'Mexicana', '28-AGO-1998', '24-AGO-2019');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (2, 'David Ruiz Alunda', 'david.alun', 'Chino Pinyin', '13-ABR-1983', '28-OCT-2019');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (3, 'Inigo Bearsiatuda Lopez', 'RockyRamboa', 'Marciana', '28-AGO-2019', '27-SEP-2020');

INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('El Libiriku', 3, '29-AGO-2019', 'Acuarela', 'Puntillismo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La noche estrellada', 3, '19-FEB-2019', 'Acuarela', 'Puntillismo');

INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La Monalisa', 2, '29-ABR-2010', 'Papel y pintura', 'Oleo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La persistencia', 2, '13-MAR-2010', 'Papel y pintura', 'Oleo');

INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La ultima cena', 1, '01-ENE-2000', 'Papel y pintura', 'Oleo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('El nacimiento de Venus', 1, '02-ENE-2000', 'Papel y pintura', 'Oleo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La joven de la Perla', 1, '03-ABR-2000', 'Papel y pintura', 'Oleo');



-- 3 Agregar la restriccion en la tabla cuadro que exprese que el estilo puede 
--   ser o no moderno o clasico.
ALTER TABLE CUADRO17 ADD CONSTRAINT su_estilo_c CHECK (estilo in ('moderno', 'clasico'));
-- ALTER TABLE CUADRO17 DROP CONSTRAINT su_estilo_c;


-- 4 
ALTER TABLE PINTORES17 ADD CONSTRAINT c4 
    CHECK (
        (fechanac BETWEEN '01-jan-1800' AND '01-jan-1850') OR 
        (fechanac BETWEEN '01-jan-1900' AND '01-jan-2000')
    );

UPDATE pintores17 SET fechanac = '01-ene-1800' WHERE codpintor = 1;
UPDATE pintores17 SET fechanac = '01-feb-1810' WHERE codpintor = 2;
UPDATE pintores17 SET fechanac = '24-ago-1998' WHERE codpintor = 3;

ALTER TABLE PINTORES17 ADD CONSTRAINT c4 
    CHECK (
        (fechanac BETWEEN '01-jan-1800' AND '01-jan-1850') OR 
        (fechanac BETWEEN '01-jan-1900' AND '01-jan-2000')
    );


-- 5
-- p: c.codpintor = 3, q: c.tecnica = oleo
ALTER TABLE CUADRO17 ADD CONSTRAINT c5 
    CHECK (
        NOT (
            codpintor = 3 AND tecnica <> 'oleo'
        )
    ) ENABLE NOVALIDATE ;


-- 6 Añadir una nueva restricción que exprese que al borrar un pintor se borren
-- automáticamente sus cuadros
ALTER TABLE cuadro17 
    ADD CONSTRAINT c_eliminado
    FOREIGN KEY (codpintor)
    REFERENCES pintores17(codpintor)
    ON DELETE CASCADE;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM all_constraints 
    WHERE table_name = 'CUADRO17';

ALTER TABLE cuadro17
    DROP CONSTRAINT SYS_C008256;

ALTER TABLE cuadro17 
    ADD CONSTRAINT c_eliminado
    FOREIGN KEY (codpintor)
    REFERENCES pintores17(codpintor)
    ON DELETE CASCADE;

-- SELECT * FROM CUADRO17 ;
SELECT * FROM CUADRO17 ORDER BY codpintor;
SELECT * FROM PINTORES17 ;
DELETE cuadro17 WHERE codpintor = 3;
SELECT * FROM PINTORES17 ;

DELETE pintores17 WHERE codpintor = 3;

SELECT * FROM PINTORES17 ;

-- 7 
ALTER TABLE CUADRO17 ADD CONSTRAINT c7 CHECK (tecnica = 'plastica');
SELECT tecnica FROM cuadro17;
UPDATE cuadro17 SET tecnica = 'plastica';
ALTER TABLE CUADRO17 ADD CONSTRAINT c7 CHECK (tecnica = 'plastica');

-- 8 
ALTER TABLE pintores17 ADD CONSTRAINT c8 CHECK (nacionalidad = 'alemana')
    ENABLE NOVALIDATE;

select * from pintores17;

INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (3, 'Inigo Bearsiatuda Lopez', 'RockyRamboa', 'colombiana', '24-ago-1998', '27-SEP-2020');
-- Restriccion de control violada
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (3, 'Inigo Bearsiatuda Lopez', 'RockyRamboa', 'alemana', '24-ago-1998', '27-SEP-2020');

-- 9 
ALTER TABLE PINTORES17 MODIFY CONSTRAINT c8 DISABLE;
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (4, 'Valeria Leza Sanchez', 'adams', 'totonaca', '12-sep-1997', '27-SEP-2020');
-- funciona, al 100

SELECT * FROM PINTORES17;

-- regresemos
ALTER TABLE PINTORES17 MODIFY CONSTRAINT c8 ENABLE NOVALIDATE;

-- 10
ALTER TABLE PINTORES17 ADD CONSTRAINT c10 CHECK (
    codpintor BETWEEN 1 AND 100
) DEFERRABLE INITIALLY IMMEDIATE;

-- Apagar nacionalidad alemana
ALTER TABLE pintores17 MODIFY CONSTRAINT c8 DISABLE;

INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (5, 'Fatima Sanchez', 'fatiisanchez', 'espanola', '12-sep-1997', '27-SEP-2020');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (106, 'Federico Buroni', 'fedeburoni', 'Ecuador', '20-feb-1990', '27-SEP-2020');
-- Error en la regla de integridad

SELECT * FROM PINTORES17;
-- No se han visto reflejados los cambios

COMMIT;

SELECT * FROM PINTORES17;
-- Ahora se ven los cambios

INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (6, 'Federico Buroni', 'fedeburoni', 'Ecuador', '20-feb-1990', '27-SEP-2020');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (7, 'Fatima Sanchez', 'fatiisanchez', 'espanola', '12-sep-1997', '27-SEP-2020');
COMMIT;

DELETE PINTORES17 WHERE codpintor = 7;



-- 11
ALTER TABLE PINTORES17 ADD CONSTRAINT c10 CHECK (
    codpintor BETWEEN 1 AND 100
) DEFERRABLE INITIALLY IMMEDIATE;

-- ASI NO PENDEJO
-- ALTER TABLE PINTORES17 MODIFY CONSTRAINT c10 DEFERRABLE INITIALLY DEFERRED; 

SET CONSTRAINT c10 DEFERRED;

INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (8, 'Alexander Lopez', 'lonely_deadman', 'mexicana', '12-sep-1997', '27-SEP-2020');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (9, 'Valentina', 'valentinagaleano', 'espana', '12-sep-1997', '27-SEP-2020');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (1000, 'Alonso Bravo', 'alonso.to', 'Frances', '12-sep-1997', '27-SEP-2020');
-- Ningun error

COMMIT;
-- Ahora muestra el error, no se realizo ninguna insercion. Intentando otra vez

INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (8, 'Alexander Lopez', 'lonely_deadman', 'mexicana', '12-sep-1997', '27-SEP-2020');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (9, 'Valentina', 'valentinagaleano', 'espana', '12-sep-1997', '27-SEP-2020');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (10, 'Alonso Bravo', 'alonso.to', 'Frances', '12-sep-1997', '27-SEP-2020');  

COMMIT;
-- Se llevo todo a cabo correctamente

-- 11
SET CONSTRAINT c8 DEFERRED;

ALTER TABLE PINTORES17 DROP CONSTRAINT c8;

ALTER TABLE PINTORES17 ADD CONSTRAINT c8 CHECK (nacionalidad = 'aleman') 
    INITIALLY DEFERRED
    ENABLE NOVALIDATE;


DELETE PINTORES17 WHERE codpintor IN (11, 12, 13);

INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (11, 'Juan Diego', 'juandarango', 'Colombia', '12-sep-1997', '27-SEP-2020');  
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (12, 'Luis', 'luisillo', 'Belga', '12-sep-1997', '27-SEP-2020');  
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (13, 'Erick Raul', 'Aleman', 'aleman', '12-sep-1997', '27-SEP-2020');  

SELECT * FROM pintores17;

COMMIT;


-- 12 
ALTER SESSION SET CONSTRAINTS = DEFERRED;
ALTER SESSION SET CONSTRAINTS = IMMEDIATE;


