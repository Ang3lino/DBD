
CREATE OR REPLACE PROCEDURE add_guide_language (
    v_guide_id IN guia_idioma.guia_id%TYPE,
    v_language IN guia_idioma.idioma%TYPE
) AS
BEGIN
    INSERT INTO guia_idioma(guia_id, idioma) VALUES (v_guide_id, v_language);
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
END insert_compra_viaje;
/

CREATE OR REPLACE PROCEDURE insert_estudiante_materia(
    p_materia_id IN estudiante_materia.materia_id%TYPE,
    p_fecha_fin IN estudiante_materia.fecha_fin%TYPE, 
    p_forma_eval IN estudiante_materia.forma_eval%TYPE, 
    p_calificacion IN estudiante_materia.calificacion%TYPE, 
    p_estudiante_id IN estudiante_materia.estudiante_id%TYPE 
) AS 
BEGIN 
    INSERT INTO estudiante_materia (
        materia_id, fecha_fin, forma_eval, 
        calificacion, estudiante_id 
    ) VALUES (
        p_materia_id, 
        p_fecha_fin, 
        p_forma_eval, 
        p_calificacion, 
        p_estudiante_id 
    );
END;
/

CREATE OR REPLACE PROCEDURE insert_materia (
    p_clave IN materia.clave%TYPE,
    p_nombre IN materia.nombre%TYPE
) AS 
BEGIN 
    INSERT INTO materia ( clave , nombre ) VALUES (p_clave, p_nombre);
END insert_materia;
/

-- db.sql
-- restricciones.sql
-- vistas.sql
-- triggers.sql 
