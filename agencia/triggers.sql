-- Definicion de disparadores

-- Consistencia en el aumento del guia
CREATE OR REPLACE TRIGGER t_guia_aumento_porcentaje 
    BEFORE INSERT OR UPDATE OF activo ON guia 
    FOR EACH ROW
    DECLARE 
        student_too NUMBER DEFAULT 0;
        previous_percentage_applied NUMBER DEFAULT 0;
BEGIN 
    IF INSERTING THEN 
        SELECT count(*) INTO student_too
            FROM estudiante 
            WHERE persona_id = :new.persona_id;
        IF student_too > 0 AND :new.aumento_porcentaje = 0 THEN 
            :new.aumento_porcentaje := 0.1;
        END IF;
    ELSE 
        IF :new.activo = 0 AND :old.aumento_porcentaje > 0 THEN 
            :new.aumento_porcentaje := :old.aumento_porcentaje - 0.1;
        END IF;
    END IF;
END;
/


-- al detectar que se tiene al menos 3 idiomas, agregar un aumento de sueldo
CREATE OR REPLACE TRIGGER t_idioma_incremento_sueldo 
    BEFORE INSERT ON guia_idioma 
    FOR EACH ROW 
    DECLARE 
        idioma_count NUMBER ;
BEGIN 
    SELECT count(*) INTO idioma_count FROM guia g 
        JOIN guia_idioma gi ON g.persona_id = gi.guia_id
        WHERE persona_id = :new.guia_id;
    IF idioma_count = 2 THEN 
        UPDATE guia 
            SET aumento_porcentaje = aumento_porcentaje + 0.1
            WHERE persona_id = :new.guia_id;
    END IF;
END;
/

-- Los guias tendran al menos 18 anios de edad
CREATE OR REPLACE TRIGGER t_guia_edad 
    BEFORE INSERT ON guia 
    FOR EACH ROW 
    DECLARE 
        v_edad NUMBER := 0;
BEGIN 
    SELECT edad INTO v_edad FROM persona WHERE id = :new.persona_id;
    IF v_edad < 18 THEN 
        RAISE_APPLICATION_ERROR(-20000, 'No tiene la edad suficiente (18).');
    END IF;
END;
/

-- Hacer la reserva de la compra con haber pagado al menos la mitad y se 
-- aplican los descuentos
CREATE OR REPLACE TRIGGER t_compra_contador 
    BEFORE INSERT ON compra_viaje 
    FOR EACH ROW 
    DECLARE 
        v_lugares NUMBER;
        v_precio NUMBER;
        v_descuento_neto NUMBER := 0;
        v_nota_media NUMBER := 5;
        v_student_too NUMBER := 0;
BEGIN 
    SELECT lugares, precio
        INTO v_lugares, v_precio
        FROM viaje WHERE fecha_inicio = :new.viaje_id;
    SELECT count(*) 
        INTO v_student_too 
        FROM estudiante e
        JOIN cliente c ON e.persona_id = c.id
        WHERE c.id = :new.cliente_id;
    IF v_student_too = 1 THEN 
        SELECT FLOOR(nota_media) INTO v_nota_media
            FROM v_estudiante_nota_media
            WHERE id = :new.cliente_id;
        IF v_nota_media >= 6 THEN  -- o es estudiante, aplicamos descuento
            v_descuento_neto := v_precio * 0.05 * (v_nota_media - 5);
            :new.descuento_neto := v_descuento_neto;
        END IF;
    END IF;
    IF :new.cant_pagada < (v_precio - v_descuento_neto) * 0.5 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Se debe de pagar al menos la mitad del viaje para reservar.');
    END IF;
    UPDATE viaje SET reservados = reservados + 1 WHERE fecha_inicio = :new.viaje_id;
END;
/

-- SELECT FLOOR(nota_media) INTO v_nota_media
--     FROM v_estudiante_nota_media
--     WHERE id = '2013631010';