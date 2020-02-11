CREATE TABLE compra_viaje (
    viaje_id DATE NOT NULL, 
    guia_id VARCHAR2(32) NOT NULL,
    cliente_id VARCHAR2(32) NOT NULL,
    cant_pagada NUMBER,
    fecha DATE DEFAULT SYSDATE,
    descuento_neto NUMBER DEFAULT 0,
    CONSTRAINT compra_viaje_pk 
        PRIMARY KEY (viaje_id, guia_id, cliente_id), 
    CONSTRAINT cv_viaje_fk FOREIGN KEY (viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE,
    CONSTRAINT cv_guia_fk FOREIGN KEY (guia_id)
        REFERENCES guia(persona_id) ON DELETE CASCADE,
    CONSTRAINT cv_cliente_fk FOREIGN KEY (cliente_id)
        REFERENCES cliente(id) ON DELETE CASCADE
);

