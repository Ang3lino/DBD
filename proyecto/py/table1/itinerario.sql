CREATE TABLE itinerario (
    viaje_id DATE NOT NULL,
    a_direccion VARCHAR(256) NOT NULL,
    a_fecha DATE NOT NULL,
    a_hora VARCHAR2(8) DEFAULT '09:00',
    b_direccion VARCHAR(256) ,
    b_fecha DATE ,
    b_hora VARCHAR2(8),
    CONSTRAINT itinerario_pk 
        PRIMARY KEY(viaje_id, a_direccion, a_fecha, a_hora),
    CONSTRAINT itinerario_fk
        FOREIGN KEY(viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE
);

