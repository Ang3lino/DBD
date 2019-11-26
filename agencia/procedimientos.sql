
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

BEGIN
    -- v_guia_id VARCHAR2(32) := '2013631540';
    add_guide_language('2013631540', 'ingles');
    add_guide_language('2013631540', 'espanol');
    add_guide_language('2013631540', 'frances');
END;

SELECT * FROM guia;
SELECT gd.idioma 
    FROM guia_idioma gd 
        JOIN guia g ON g.persona_id = gd.guia_id 
    WHERE g.persona_id = '2013631540' ;


CREATE TABLE persona (
    id VARCHAR2(32) NOT NULL,
    email VARCHAR2(64),
    nombre VARCHAR2(32),
    edad NUMBER,
    primer_apellido VARCHAR2(32),
    segundo_apellido VARCHAR2(32),
    direccion VARCHAR2(128),
    iban VARCHAR2(32),
    telefono NUMBER,
    PRIMARY KEY (id) 
);

CREATE TABLE guia (
    desde DATE DEFAULT SYSDATE,
    salario_mensual NUMBER DEFAULT 500,
    persona_id VARCHAR2(32),
    activo CHAR(1) DEFAULT '1',
    aumento_porcentaje NUMBER DEFAULT 0,
    CONSTRAINT guia_pk PRIMARY KEY (persona_id),
    CONSTRAINT guia_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);