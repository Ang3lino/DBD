-- Restriciones de integridad


-- Email de una persona validado por expresion regular
ALTER TABLE persona 
    ADD CONSTRAINT chk_persona_email
    CHECK (REGEXP_LIKE (email,'^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'));

-- A lo mas el guia tendra un descuento del 30%
ALTER TABLE guia ADD CONSTRAINT chk_guia_aumento_porcentaje 
    CHECK (aumento_porcentaje BETWEEN 0 AND 0.30);

-- Las fechas de la promocion consistentes, asi como el rango del porcentaje
ALTER TABLE promocion ADD CONSTRAINT chk_promocion_fechas_descuento 
    CHECK (desde <= hasta AND desc_porcentaje BETWEEN 0 AND 1);

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
    CHECK (a_fecha <= b_fecha AND a_hora <= b_hora);

-- No puede haber mas lugares reservados del total de plazas
ALTER TABLE viaje 
    ADD CONSTRAINT chk_viaje_reservados 
    CHECK (reservados <= lugares);