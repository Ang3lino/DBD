CREATE TABLE promocion (
    codigo VARCHAR(32) NOT NULL,
    viaje_id DATE NOT NULL,
    desde DATE DEFAULT SYSDATE,
    hasta DATE,
    desc_porcentaje NUMBER,
    CONSTRAINT promocion_pk PRIMARY KEY (codigo), 
    CONSTRAINT promocion_fk FOREIGN KEY (viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE 
);

