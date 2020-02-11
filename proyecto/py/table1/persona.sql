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

