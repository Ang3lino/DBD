CREATE TABLE estudiante_materia (
    estudiante_id VARCHAR2(32) NOT NULL,
    materia_id VARCHAR2(8) NOT NULL,
    calificacion NUMBER NOT NULL,
    fecha_fin DATE NOT NULL,
    forma_eval VARCHAR2(16) NOT NULL,
    CONSTRAINT estudiante_materia_pk PRIMARY KEY(estudiante_id, materia_id)
);

