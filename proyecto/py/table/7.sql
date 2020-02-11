CREATE TABLE viaje (
    fecha_inicio DATE NOT NULL,
    descripcion VARCHAR2(256),
    nombre VARCHAR2(64),
    precio NUMBER NOT NULL,
    reservados NUMBER DEFAULT 0,
    lugares NUMBER NOT NULL,
    CONSTRAINT viaje_pk PRIMARY KEY(fecha_inicio)
);

