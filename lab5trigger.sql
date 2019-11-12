

-- 1 Crear tablas

DROP TABLE departamento17;

CREATE TABLE departamento17 (
    nombre VARCHAR2(20),
    presupuestopersonal NUMBER, 
    PRIMARY KEY(nombre) 
);

DROP TABLE empleado17;

CREATE TABLE empleado17 (
    dni NUMBER PRIMARY KEY,
    salario NUMBER,
    sudpto VARCHAR2(20) REFERENCES departamento17(nombre)
);


INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('nombre1', 0);
INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('nombre2', 0);
INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('nombre3', 0);
INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('nombre4', 0);

SELECT * FROM departamento17;

-- 1 Triggers =================================================================
-- Crear un disparador que controle que el atributo presupuestoPersonal del
-- departamento se calcula como la suma de los salarios de los empleados que trabajan en
-- dicho departamento (sólo para los casos de inserción de nuevos empleados y de
-- modificación del sueldo de los ya existentes). Verificar el funcionamiento del trigger 

CREATE OR REPLACE TRIGGER uno 
    AFTER INSERT OR UPDATE OF salario ON empleado17
    FOR EACH ROW 
BEGIN 
    IF INSERTING THEN 
        UPDATE departamento17
            SET presupuestopersonal = presupuestopersonal + :new.salario
            WHERE nombre = :new.sudpto ;
    ELSE 
        UPDATE departamento17
            SET presupuestopersonal = presupuestopersonal + :new.salario - :old.salario
            WHERE departamento17.nombre = :new.sudpto ;
    END IF;
END;

UPDATE departamento17 set presupuestopersonal = 0;
SELECT * FROM departamento17;
SELECT * FROM empleado17;

-- '49578508F'
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 0, 1000, 'nombre1' );
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 1, 500, 'nombre1' );
SELECT * FROM empleado17;
SELECT * FROM departamento17;

UPDATE empleado17 SET salario = 400 WHERE dni = 0;
SELECT * FROM departamento17;

-- 2 
-- Crear un disparador que al introducir el empleado con DNI 66, introducir su nuevo
-- departamento en la tabla DEPARTAMENTO y que dicha tupla tenga como
-- Presupuestopersonal el valor de 100000 euros. Usar la opción REFERENCING

-- CREATE TABLE departamento17 (
--     nombre VARCHAR2(20),
--     presupuestopersonal NUMBER, 
--     PRIMARY KEY(nombre) 
-- );

-- CREATE TABLE empleado17(
--     dni NUMBER PRIMARY KEY,
--     salario NUMBER,
--     sudpto VARCHAR2(20) REFERENCES departamento17(nombre)
-- );


CREATE OR REPLACE TRIGGER dos 
    BEFORE INSERT ON empleado17
    REFERENCING NEW AS nuevo
    FOR EACH ROW 
    WHEN (nuevo.dni = 66)
BEGIN 
    INSERT INTO departamento17 ( nombre , presupuestopersonal ) VALUES (:nuevo.sudpto, 100000);
END;

INSERT INTO empleado17(dni, salario, sudpto) VALUES (66, 100, 'Ibai');
SELECT * FROM empleado17;  
SELECT * FROM departamento17;  -- 100000 + 100

-- 3
-- Realizar un seguimiento de los cambios en el salario de los empleados (inserciones y
-- modificaciones). Estos cambios se irán registrando en la tabla CambioSalario_log.
-- Verificar el funcionamiento del trigger 
CREATE TABLE CambioSalario_log (
    quien varchar2(20) not null, 
    cuando date not null, 
    dniEmpleado number not null, 
    salarioAntes number, 
    salariodespues number
); 

-- CREATE TABLE empleado17(
--     dni NUMBER PRIMARY KEY,
--     salario NUMBER,
--     sudpto VARCHAR2(20) REFERENCES departamento17(nombre)
-- );

CREATE OR REPLACE TRIGGER t3 
    AFTER INSERT OR UPDATE OF salario ON empleado17
    FOR EACH ROW 
BEGIN
    IF INSERTING THEN 
        INSERT INTO CambioSalario_log (
            quien , 
            cuando , 
            dniEmpleado , 
            salarioAntes , 
            salariodespues ) 
        VALUES ( USER, SYSDATE, :new.dni, 0, :new.salario) ;
    ELSE 
        INSERT INTO CambioSalario_log (
            quien , 
            cuando , 
            dniEmpleado , 
            salarioAntes , 
            salariodespues ) 
        VALUES ( USER, SYSDATE, :new.dni, :old.salario, :new.salario) ;
    END IF;
END;

SELECT * FROM empleado17;

INSERT INTO empleado17(dni, salario, sudpto) VALUES (2, 200, 'nombre2');
INSERT INTO empleado17(dni, salario, sudpto) VALUES (3, 300, 'nombre3');

SELECT * FROM CambioSalario_log;

UPDATE empleado17 SET salario = salario + 100 WHERE dni = 2;
UPDATE empleado17 SET salario = salario - 100 WHERE dni = 3;

SELECT * FROM CambioSalario_log;


-- 4
-- Evitar que el salario sea actualizado durante el mes de Noviembre
-- MON- Abreviatura de MONTH
-- Códigos de error entre -20000 y -20999 

-- CREATE TABLE empleado17(
--     dni NUMBER PRIMARY KEY,
--     salario NUMBER,
--     sudpto VARCHAR2(20) REFERENCES departamento17(nombre)
-- );

CREATE OR REPLACE TRIGGER t4 
    BEFORE UPDATE OF salario ON empleado17
BEGIN 
    IF SYSDATE LIKE '__/11/__' THEN 
        RAISE_APPLICATION_ERROR(-20000, 'No se puede actualizar el salario en noviembre.');
    END IF;
END;

SELECT * FROM empleado17;
UPDATE empleado17 SET salario = salario + 100 WHERE dni = 2;  -- Exception raised


-- Trigger 5. Restringir el número máximo de empleados de un departamento a 3 

CREATE OR REPLACE TRIGGER t5 
    BEFORE INSERT ON empleado17
    FOR EACH ROW
    DECLARE people_count INTEGER;
BEGIN 
    SELECT COUNT(*) INTO people_count 
        FROM empleado17 e, departamento17 d
        WHERE d.nombre = e.sudpto AND e.sudpto = :NEW.sudpto;
    IF people_count = 3 THEN 
        RAISE_APPLICATION_ERROR(-20999, 'No se puede tener mas de tres empleados');
    END IF;
END; 

SELECT COUNT(*) 
    FROM empleado17 e, departamento17 d
    WHERE d.nombre = e.sudpto AND e.sudpto = 'nombre2';

SELECT * FROM empleado17;
INSERT INTO empleado17(DNI, salario, sudpto) VALUES (3, 400, 'nombre2' );
INSERT INTO empleado17(DNI, salario, sudpto) VALUES (4, 400, 'nombre2' );
INSERT INTO empleado17(DNI, salario, sudpto) VALUES (5, 400, 'nombre2' );

INSERT INTO empleado17(DNI, salario, sudpto) VALUES (6, 400, 'nombre2' ); -- Exception raised


