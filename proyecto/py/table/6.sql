CREATE TABLE cliente (
    id VARCHAR2(16) NOT NULL,
    nickname VARCHAR2(32),
    contrasena VARCHAR2(64),
    desde DATE,
    CONSTRAINT cliente_pk PRIMARY KEY (id),
    CONSTRAINT cliente_fk FOREIGN KEY(id)
        REFERENCES persona(id) ON DELETE CASCADE
);

