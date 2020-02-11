CREATE TABLE estudiante (
    persona_id VARCHAR2(32),
    matricula VARCHAR2(16),
    carrera VARCHAR2(32),
    CONSTRAINT estudiante_pk PRIMARY KEY (persona_id),
    CONSTRAINT estudiante_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);

