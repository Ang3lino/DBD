CREATE TABLE persona (
    id VARCHAR2(32) NOT NULL,
    email VARCHAR2(64),
    nombre VARCHAR2(32),
    edad NUMBER NOT NULL,
    primer_apellido VARCHAR2(32),
    segundo_apellido VARCHAR2(32),
    direccion VARCHAR2(128),
    iban VARCHAR2(32),
    telefono NUMBER,
    PRIMARY KEY (id) 
);
-- ALTER TABLE persona MODIFY (edad NOT NULL);

