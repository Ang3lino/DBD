
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
    VALUES (1, 'Angel Lopez Manriquez', 'Angelino', 'Mexicana', '28-AUG-1998', '24-AGO-2019');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (2, 'David Ruiz Alunda', 'david.alun', 'Chino Pinyin', '13-APR-1983', '28-OCT-2019');
INSERT INTO PINTORES17 ( codpintor , nombre , nomartistico , nacionalidad , fechanac , fechafalle )
    VALUES (3, 'Inigo Bearsiatuda Lopez', 'RockyRamboa', 'Marciana', '28-AUG-2019', '27-SEP-2020');

INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('El Libiriku', 3, '29-AUG-2019', 'Acuarela', 'Puntillismo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La noche estrellada', 3, '19-FEB-2019', 'Acuarela', 'Puntillismo');

INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La Monalisa', 2, '29-APR-2010', 'Papel y pintura', 'Oleo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La persistencia', 2, '13-MAR-2010', 'Papel y pintura', 'Oleo');

INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La ultima cena', 1, '01-JAN-2000', 'Papel y pintura', 'Oleo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('El nacimiento de Venus', 1, '02-JAN-2000', 'Papel y pintura', 'Oleo');
INSERT INTO CUADRO17 ( titulo , codpintor , fecha , tecnica , estilo )
    VALUES ('La joven de la Perla', 1, '03-APR-2000', 'Papel y pintura', 'Oleo');


-- 3 Anadir la restriccion en la tabla
-- Pondra error si existe alguna tupla que no este 
ALTER TABLE CUADRO17 ADD CONSTRAINT suestilo CHECK (estilo in ('moderno', 'clasico'));

SELECT * FROM CUADRO17;

UPDATE CUADRO17 SET estilo = 'moderno' WHERE codpintor = 3;
UPDATE CUADRO17 SET estilo = 'clasico' WHERE codpintor in (1, 2);

SELECT * FROM CUADRO17;

ALTER TABLE CUADRO17 ADD CONSTRAINT suestilo CHECK (estilo in ('moderno', 'clasico'));


-- 4 Añadir la restricción en la tabla PINTORES  que exprese que la fecha de nacimiento
-- debe estar entre 1800 y 1850 o entre 1900 y 2000 y comprobar su funcionamiento
SELECT * FROM pintores17;

ALTER TABLE pintores17 ADD CONSTRAINT c_fecha CHECK (
    (fechanac BETWEEN '01-jan-1800' AND '01-jan-1850') 
    OR (fechanac BETWEEN '01-jan-1900' AND '01-jan-2000')
);

UPDATE pintores17 SET fechanac = '01-jan-1800' WHERE codpintor = 1;
UPDATE pintores17 SET fechanac = '01-feb-1810' WHERE codpintor = 2;
UPDATE pintores17 SET fechanac = '24-aug-1998' WHERE codpintor = 3;

-- intentar otra vez
ALTER TABLE pintores17 ADD CONSTRAINT c_fecha CHECK (
    (fechanac BETWEEN '01-jan-1800' AND '01-jan-1850') 
    OR (fechanac BETWEEN '01-jan-1900' AND '01-jan-2000')
);


-- 5 Poner un ejemplo con la opción CHECK NOT (sobre dos atributos de una tabla).

-- Ejemplo si el código de pintor es 3 entonces la técnica debe ser óleo.

SELECT * FROM cuadro17;

-- p -> q ssi ~p or q ssi ~(p and ~q) 
-- p := codpintor = 3
-- q := tecnica = 'oleo'

ALTER TABLE cuadro17 ADD CONSTRAINT c_oleo CHECK (
    NOT(codpintor = 3 AND (NOT tecnica LIKE '%oleo%'))
);

SELECT * FROM cuadro17;
UPDATE cuadro17 SET tecnica = 'oleo' WHERE codpintor = 3;
SELECT * FROM cuadro17;

ALTER TABLE cuadro17 ADD CONSTRAINT c_oleo CHECK (
    NOT(codpintor = 3 AND (NOT tecnica LIKE '%oleo%'))
);

-- no deja
UPDATE cuadro17 SET tecnica = 'LOL' WHERE codpintor = 3;


-- 6 Añadir una nueva restricción que exprese que al borrar un pintor se borren
-- automáticamente sus cuadros
ALTER TABLE cuadro17 
    ADD CONSTRAINT c_eliminado
    FOREIGN KEY (codpintor)
    REFERENCES pintores17(codpintor)
    ON DELETE CASCADE;

ALTER TABLE cuadro17
    DROP CONSTRAINT SYS_C0051635;

ALTER TABLE cuadro17 
    ADD CONSTRAINT c_eliminado
    FOREIGN KEY (codpintor)
    REFERENCES pintores17(codpintor)
    ON DELETE CASCADE;


-- 7 Añadir una nueva restricción sobre la tabla CUADRO que indique que la técnica sólo
-- podrá ser plástica en todas las tuplas de la BD (las existentes y las nuevas). ¿Qué
-- ocurre si en la BD ya existen tuplas con técnica Oleo? ¿Cuál es el valor por defecto a
-- la hora de comprobar?

CREATE ASSERTION assertion_plasticas 
    CHECK NOT EXISTS (
        SELECT * FROM cuadro17 
            WHERE tecnica <> 'oleo'
    );

ALTER TABLE cuadro17 
    ADD CONSTRAINT c_todas_plasticas 
    