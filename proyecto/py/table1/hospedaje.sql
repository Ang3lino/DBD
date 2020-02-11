CREATE TABLE hospedaje (
    ubicacion VARCHAR2(128) NOT NULL,
    nombre VARCHAR2(128) NOT NULL,
    valoracion NUMBER,
    CONSTRAINT hospedaje_pk PRIMARY KEY (ubicacion)
);

