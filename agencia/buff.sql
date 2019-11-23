CREATE TABLE estudiante (
    persona_id VARCHAR2(32),
    matricula VARCHAR2(16),
    carrera VARCHAR2(32),
    CONSTRAINT estudiante_pk PRIMARY KEY (persona_id),
    CONSTRAINT estudiante_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);

CREATE TABLE guia_estudiante (
    id VARCHAR2(16) NOT NULL,
    porcentaje_extra NUMBER,
    CONSTRAINT guia_estudiante_pk PRIMARY KEY (id),
    CONSTRAINT guia_estudiante_fk FOREIGN KEY(id)
        REFERENCES persona(id) ON DELETE CASCADE
);

CREATE TABLE guia (
    dias_laborados NUMBER, 
    desde DATE,
    salario_mensual NUMBER,
    persona_id VARCHAR2(32),
    activo CHAR(1) DEFAULT '0',
    CONSTRAINT guia_pk PRIMARY KEY (persona_id),
    CONSTRAINT guia_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);

