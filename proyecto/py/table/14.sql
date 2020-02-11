CREATE TABLE hospedaje_viaje (
    hospedaje_id VARCHAR2(128) NOT NULL,
    viaje_id DATE NOT NULL,
    fecha DATE DEFAULT SYSDATE,
    CONSTRAINT hospedaje_viaje_hospedaje_fk FOREIGN KEY(hospedaje_id)
        REFERENCES hospedaje(ubicacion) ON DELETE CASCADE,
    CONSTRAINT hospedaje_viaje_viaje_fk FOREIGN KEY(viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE,
    CONSTRAINT hospedaje_viaje_pk PRIMARY KEY(hospedaje_id, viaje_id)
);

