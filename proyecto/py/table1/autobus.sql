CREATE TABLE autobus (
    matricula VARCHAR2(16) NOT NULL,
    wc NUMBER,
    cantidad_asientos NUMBER,
    CONSTRAINT autobus_pk PRIMARY KEY(matricula)
);

