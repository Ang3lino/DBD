CREATE TABLE guia (
    desde DATE DEFAULT SYSDATE,
    salario_mensual NUMBER DEFAULT 500,
    persona_id VARCHAR2(32),
    activo CHAR(1) DEFAULT '1',
    aumento_porcentaje NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT guia_pk PRIMARY KEY (persona_id),
    CONSTRAINT guia_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);

