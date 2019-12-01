
CREATE OR REPLACE PROCEDURE add_guide_language (
    v_guide_id IN guia_idioma.guia_id%TYPE,
    v_language IN guia_idioma.idioma%TYPE
) AS
BEGIN
    INSERT INTO guia_idioma(guia_id, idioma) 
        VALUES (v_guide_id, v_language);
    COMMIT;
END add_guide_language;
/

-- BEGIN
--     -- v_guia_id VARCHAR2(32) := '2013631540';
--     add_guide_language('2013631540', 'ingles');
--     add_guide_language('2013631540', 'espanol');
--     add_guide_language('2013631540', 'frances');
-- END;

-- SELECT * FROM guia;
-- SELECT gd.idioma 
--     FROM guia_idioma gd 
--         JOIN guia g ON g.persona_id = gd.guia_id 
--     WHERE g.persona_id = '2013631540' ;

CREATE OR REPLACE PROCEDURE insert_compra_viaje (
    p_viaje_id IN compra_viaje.viaje_id%TYPE,
    p_guia_id IN compra_viaje.guia_id%TYPE,
    p_cliente_id IN compra_viaje.cliente_id%TYPE,
    p_cant_pagada IN compra_viaje.cant_pagada%TYPE
) AS
BEGIN
    INSERT INTO compra_viaje (
    viaje_id , guia_id , cliente_id , cant_pagada 
    ) VALUES (
        p_viaje_id , p_guia_id , p_cliente_id , p_cant_pagada );
    COMMIT;
END insert_compra_viaje;
/

DROP TABLE persona cascade constraints;
DROP TABLE guia cascade constraints;
DROP TABLE guia_idioma cascade constraints;
DROP TABLE estudiante cascade constraints;
DROP TABLE materia cascade constraints;
DROP TABLE estudiante_materia cascade constraints;
DROP TABLE cliente cascade constraints;
DROP TABLE viaje cascade constraints;
DROP TABLE promocion cascade constraints;
DROP TABLE compra_viaje cascade constraints;
DROP TABLE itinerario cascade constraints;
DROP TABLE autobus cascade constraints;
DROP TABLE viaje_autobus cascade constraints;
DROP TABLE hospedaje cascade constraints;
DROP TABLE habitacion_reservada cascade constraints;

-- db.sql
-- restricciones.sql
-- vistas.sql
-- triggers.sql 
