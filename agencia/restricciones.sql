

-- Restriciones de integridad
-- la calificacion posible esta entre 0 y 10
ALTER TABLE materia 
    ADD CONSTRAINT chk_materia_calificacion 
    CHECK (calificacion BETWEEN 0 AND 10);

-- a lo mas habria dos banos en un autobus
ALTER TABLE autobus 
    ADD CONSTRAINT chk_autobus_wc 
    CHECK (wc BETWEEN 0 AND 2);

-- el punto de reunion b de la relacion itinerario debe ser posterior al punto a
ALTER TABLE itinerario 
    ADD CONSTRAINT chk_itinerario_fecha_hora
    CHECK (a_fecha <= b_fecha AND a_hora <= b_fecha);


-- Vistas
-- obtener el fragmento minitermino mixto de los estudiantes con su 
-- clave, nombre y nota media
CREATE VIEW v_estudiante_nota_media AS 
    SELECT 
        p.id, 
        p.nombre, 
        p.primer_apellido, 
        p.segundo_apellido, 
        AVG(m.calificacion) AS nota_media
    FROM persona p 
        JOIN estudiante e ON p.id = e.persona_id
        JOIN materia m  ON e.persona_id = m.estudiante_id 
    GROUP BY p.id, p.nombre, p.primer_apellido, p.segundo_apellido;

-- visualizar la cantidad invertida por los clientes en el viaje con su nombre
CREATE VIEW v_cliente_inversion AS 
    SELECT 
        p.id, c.nickname, SUM(cv.cant_pagada) AS total
    FROM persona p 
        JOIN cliente c ON p.id = c.id 
        JOIN compra_viaje cv ON c.id = cv.cliente_id 
    GROUP BY p.id, c.nickname
    ORDER BY total DESC;    

-- mostrar todas las habitaciones reservadas para el dia de hoy
CREATE VIEW v_habitaciones_hoy AS 
    SELECT 
        h.ubicacion, v.nombre, hr.planta, hr.numero, hr.cant_personas 
    FROM habitacion_reservada hr 
        JOIN hospedaje h ON hr.ubicacion = h.ubicacion AND hr.fecha = h.fecha
        JOIN viaje v ON h.viaje_id = v.fecha_inicio 
    WHERE v.fecha_inicio = SYSDATE;


ALTER TABLE guia ADD aumento_porcentaje NUMBER DEFAULT 0;
ALTER TABLE guia ADD CONSTRAINT chk_guia_aumento_porcentaje 
    CHECK (aumento_porcentaje BETWEEN 0 AND 0.30);

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
        IF (:new.activo <> 0) AND :old.aumento_porcentaje > 0 THEN 
            UPDATE guia 
                SET aumento_porcentaje = aumento_porcentaje - 0.10
                WHERE persona_id = :new.persona_id;
        END IF;
    END IF;
END;
/

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

-- TODO: agregar esto en db.sql
ALTER TABLE viaje ADD reservados NUMBER DEFAULT 0;
ALTER TABLE viaje ADD lugares NUMBER NOT NULL;

CREATE OR REPLACE TRIGGER t_compra_contador 
    BEFORE INSERT ON compra_viaje 
    FOR EACH ROW 
    DECLARE 
        v_reservados NUMBER;
        v_lugares NUMBER;
BEGIN 
    SELECT MAX(reservados) INTO v_reservados 
        FROM viaje WHERE fecha_inicio = :new.viaje_id;
    SELECT lugares INTO v_lugares 
        FROM viaje WHERE fecha_inicio = :new.viaje_id;
    IF v_reservados = v_lugares THEN 
        RAISE_APPLICATION_ERROR(-20000, 'Ya no hay plazas disponibles');
    END IF;
    UPDATE viaje SET reservados = reservados + 1 WHERE fecha_inicio = :new.viaje_id;
END;
/
