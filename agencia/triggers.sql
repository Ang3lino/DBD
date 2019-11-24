-- Definicion de disparadores

-- Consistencia en el aumento del guia
CREATE OR REPLACE TRIGGER t_guia_aumento_porcentaje 
    AFTER INSERT OR UPDATE OF activo ON guia 
    FOR EACH ROW
    DECLARE 
        student_too NUMBER DEFAULT 0;
        previous_percentage_applied NUMBER DEFAULT 0;
BEGIN 
    IF INSERTING THEN 
        SELECT 1 INTO student_too
            FROM estudiante 
            WHERE persona_id = :new.persona_id;
        SELECT aumento_porcentaje INTO previous_percentage_applied
            FROM guia 
            WHERE persona_id = :new.persona_id;
        IF student_too = 1 AND (previous_percentage_applied > 0) THEN 
            UPDATE guia 
                SET aumento_porcentaje = 0.10
                WHERE persona_id = :new.persona_id;
        END IF;
    ELSE 
        IF (:new.activo = 0) AND :old.aumento_porcentaje > 0 THEN 
            UPDATE guia 
                SET aumento_porcentaje = aumento_porcentaje - 0.10
                WHERE persona_id = :new.persona_id;
        END IF;
    END IF;
END;
/

-- al detectar que se tiene al menos 3 idiomas, agregar un aumento de sueldo
CREATE OR REPLACE TRIGGER t_idioma_incremento_sueldo 
    AFTER INSERT ON guia_idioma 
    FOR EACH ROW 
    DECLARE 
        idioma_count NUMBER DEFAULT 1;
BEGIN 
    SELECT count(*) INTO idioma_count 
        FROM guia WHERE persona_id = :new.guia_id;
    IF idioma_count = 3 THEN 
        UPDATE guia SET aumento_porcentaje = aumento_porcentaje + 0.1 
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
    AFTER INSERT ON compra_viaje 
    FOR EACH ROW 
    DECLARE 
        v_reservados NUMBER;
        v_lugares NUMBER;
        v_precio NUMBER;
        v_descuento_neto NUMBER := 0;
        v_nota_media NUMBER := 5;
BEGIN 
    SELECT lugares, precio
        INTO v_lugares, v_precio
        FROM viaje WHERE fecha_inicio = :new.viaje_id;
    SELECT FLOOR(nota_media) INTO v_nota_media
        FROM v_estudiante_nota_media
        WHERE id = :new.cliente_id;
    IF v_nota_media >= 6 THEN  -- o es estudiante, aplicamos descuento
        v_descuento_neto := v_precio * 0.05 * (v_nota_media - 5);
        UPDATE compra_viaje 
            SET descuento_neto = v_descuento_neto
            WHERE viaje_id = :new.viaje_id 
                AND guia_id = :new.guia_id 
                AND cliente_id = :new.cliente_id;
    END IF;
    IF :new.cant_pagada >= (v_precio - v_descuento_neto) * 0.5 THEN
        UPDATE viaje SET reservados = reservados + 1 WHERE fecha_inicio = :new.viaje_id;
    END IF;
END;
/

-- Hacer la reserva de la compra con haber pagado al menos la mitad
CREATE OR REPLACE TRIGGER t_compra_contador 
    AFTER INSERT ON compra_viaje 
    FOR EACH ROW 
    DECLARE 
        v_reservados NUMBER;
        v_lugares NUMBER;
        v_precio NUMBER;
        v_descuento_neto NUMBER := 0;
        v_nota_media NUMBER := 5;
BEGIN 
    SELECT MAX(reservados)
        INTO v_reservados
        FROM viaje WHERE fecha_inicio = :new.viaje_id;
    IF v_reservados = v_lugares THEN 
        RAISE_APPLICATION_ERROR(-20000, 'Ya no hay plazas disponibles');
    END IF;
    SELECT lugares, precio, descuento_neto
        INTO v_lugares, v_precio, v_descuento_neto
        FROM viaje WHERE fecha_inicio = :new.viaje_id;
    SELECT nota_media INTO v_nota_media
        FROM estudiante WHERE :new.cliente_id = persona_id;
    UPDATE compra_viaje 
        SET descuento_neto = 
            CASE 
                WHEN (v_nota_media >= 6) THEN 
                    v_viaje * 0.05 * (6 - FLOOR(v_nota_media))
                ELSE 
                    0
            END
        WHERE viaje_id = :new.viaje_id 
            AND guia_id = :new.guia_id 
            AND cliente_id = :new.cliente_id;
    IF :new.cant_pagada >= (v_precio - v_descuento_neto) * 0.5 THEN
        UPDATE viaje SET reservados = reservados + 1 WHERE fecha_inicio = :new.viaje_id;
    END IF;
END;
/