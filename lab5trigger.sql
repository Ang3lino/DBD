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


INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('depto1', 0);
INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('depto2', 0);
INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('depto3', 0);
INSERT INTO departamento17(nombre, presupuestopersonal) VALUES ('depto4', 0);

SELECT * FROM departamento17;
SELECT * FROM empleado17;


-- 1

CREATE OR REPLACE TRIGGER t1 
    AFTER INSERT OR UPDATE OF salario ON empleado17 
    FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        UPDATE departamento17 
            SET presupuestopersonal = presupuestopersonal + :new.salario
            WHERE nombre = :new.sudpto;
    ELSE 
        UPDATE departamento17 
            SET presupuestopersonal = presupuestopersonal + :new.salario - :old.salario
            WHERE nombre = :new.sudpto;
    END IF;
END;
/


-- stir fry
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 0, 1000, 'depto1' );
SELECT * FROM departamento17;

UPDATE empleado17 SET salario = salario - 200 WHERE dni = 0;
SELECT * FROM departamento17;


-- 2
CREATE OR REPLACE TRIGGER t2 
    BEFORE INSERT ON empleado17
    REFERENCING NEW AS nuevo
    FOR EACH ROW 
    WHEN (nuevo.dni = 66)
BEGIN 
    INSERT INTO departamento17 (nombre, presupuestopersonal) 
       VALUES (:nuevo.sudpto, 100000);
END;
/

SELECT * FROM departamento17;
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 66, 100, 'Jefe' );
SELECT * FROM departamento17;


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

CREATE OR REPLACE TRIGGER t3 
    AFTER INSERT OR UPDATE OF salario ON empleado17 
    FOR EACH ROW 
BEGIN 
    IF INSERTING THEN 
        INSERT INTO CambioSalario_log (quien, cuando, dniEmpleado, salarioAntes, salariodespues)
            VALUES (USER, SYSDATE, :NEW.dni, NULL, :NEW.salario);
    ELSE 
        INSERT INTO CambioSalario_log (quien, cuando, dniEmpleado, salarioAntes, salariodespues)
            VALUES (USER, SYSDATE, :NEW.dni, :OLD.salario, :NEW.salario);
    END IF;
END;
/ 

SELECT * FROM CambioSalario_log;
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 1, 2000, 'depto1' );
SELECT * FROM CambioSalario_log;

UPDATE empleado17 SET salario = salario - 1000;
SELECT * FROM CambioSalario_log;

UPDATE empleado17 SET salario = salario - 1000;
SELECT * FROM CambioSalario_log;


-- 4
CREATE OR REPLACE TRIGGER t4
    BEFORE UPDATE OF salario ON empleado17
    FOR EACH ROW 
BEGIN 
    -- IF MON = 'NOV' THEN 
    IF SYSDATE LIKE '__/11/__' THEN 
        RAISE_APPLICATION_ERROR(-20000, 'Cannot update salary on november');
    END IF;
END; 
/

UPDATE empleado17 SET salario = salario + 1000;
-- exception raised, OK

-- 5
-- higher we go
-- INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 66, 100, 'Jefe' );

SELECT * FROM departamento17;
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 2, 100, 'Jefe' );
SELECT * FROM empleado17 WHERE sudpto = 'Jefe';


CREATE OR REPLACE TRIGGER t5 
    BEFORE INSERT ON empleado17 
    FOR EACH ROW 
    DECLARE e_count INTEGER;
BEGIN 
    -- SELECT COUNT(*) 
    -- SELECT * 
    SELECT COUNT(*) INTO e_count FROM empleado17 WHERE sudpto = :new.sudpto; 
    IF e_count = 3 THEN 
        RAISE_APPLICATION_ERROR(-20000, 'There are enough');
    END IF;
END;
/

INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 3, 100, 'Jefe' );
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 4, 100, 'Jefe' );
-- Error


-- 6
ALTER TABLE empleado17 
    ADD CONSTRAINT c_salario CHECK (salario < 1000000);
SELECT * FROM CambioSalario_log;
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 5, 9999999999, 'Jefe' );
-- Excepcion reportada por gatillo
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 5, 9999999999, 'depto2' );
-- Excepcion reportada por restriccion de integridad


-- 7
ALTER TRIGGER t5 DISABLE;
INSERT INTO empleado17( dni , salario , sudpto ) VALUES ( 5, 9999999999, 'Jefe' );
-- excepcion, violacion de regla de integridad
ALTER TRIGGER t5 ENABLE;


-- 8
SELECT trigger_type, triggering_event, table_name
    FROM user_triggers 
    WHERE trigger_name = 't5';

SELECT trigger_name
    FROM user_triggers 
    WHERE user = 'system';
-- en ambos casos no se selecciono ninguna fila


SELECT trigger_type, triggering_event, table_name
    FROM user_triggers ;

SELECT trigger_name
    FROM user_triggers ;

SELECT trigger_name, trigger_type, triggering_event, table_name
    FROM user_triggers ;
