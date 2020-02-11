CREATE TABLE viaje_autobus (
    matricula VARCHAR2(16) NOT NULL,
    viaje_id DATE NOT NULL,
    CONSTRAINT viaje_autobus_pk PRIMARY KEY(matricula, viaje_id),
    CONSTRAINT viaje_autobus_viaje_fk FOREIGN KEY(viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE,
    CONSTRAINT viaje_autobus_autobus_fk FOREIGN KEY(matricula)
        REFERENCES autobus(matricula) ON DELETE CASCADE
);

