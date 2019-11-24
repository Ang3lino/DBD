
CREATE TABLE persona (
    id VARCHAR2(32) NOT NULL,
    email VARCHAR2(64),
    nombre VARCHAR2(32),
    primer_apellido VARCHAR2(32),
    segundo_apellido VARCHAR2(32),
    direccion VARCHAR2(128),
    iban VARCHAR2(32),
    telefono NUMBER,
    PRIMARY KEY (id) 
);

CREATE TABLE guia (
    dias_laborados NUMBER, 
    desde DATE,
    salario_mensual NUMBER,
    persona_id VARCHAR2(32),
    activo CHAR(1) DEFAULT '0',
    CONSTRAINT guia_pk PRIMARY KEY (persona_id),
    CONSTRAINT guia_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);

CREATE TABLE guia_idioma (
    guia_id VARCHAR(32),
    idioma VARCHAR(16),
    CONSTRAINT guia_idioma_pk PRIMARY KEY (guia_id, idioma),
    CONSTRAINT guia_idioma_fk FOREIGN KEY (guia_id) 
        REFERENCES guia(persona_id) ON DELETE CASCADE 
);

CREATE TABLE estudiante (
    persona_id VARCHAR2(32),
    matricula VARCHAR2(16),
    carrera VARCHAR2(32),
    CONSTRAINT estudiante_pk PRIMARY KEY (persona_id),
    CONSTRAINT estudiante_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);

CREATE TABLE materia (
    clave VARCHAR2(8) NOT NULL,
    calificacion NUMBER NOT NULL,
    fecha_fin DATE NOT NULL,
    nombre VARCHAR2(32) NOT NULL,
    forma_eval VARCHAR2(16) NOT NULL,
    estudiante_id VARCHAR2(32) NOT NULL,
    CONSTRAINT materia_pk PRIMARY KEY(clave),
    CONSTRAINT materia_fk 
        FOREIGN KEY (estudiante_id) 
        REFERENCES estudiante(persona_id)
        ON DELETE CASCADE
);

CREATE TABLE guia_estudiante (
    id VARCHAR2(16) NOT NULL,
    porcentaje_extra NUMBER,
    CONSTRAINT guia_estudiante_pk PRIMARY KEY (id),
    CONSTRAINT guia_estudiante_fk FOREIGN KEY(id)
        REFERENCES persona(id) ON DELETE CASCADE
);

CREATE TABLE cliente (
    id VARCHAR2(16) NOT NULL,
    nickname VARCHAR2(32),
    contrasena VARCHAR2(64),
    desde DATE,
    CONSTRAINT cliente_pk PRIMARY KEY (id),
    CONSTRAINT cliente_fk FOREIGN KEY(id)
        REFERENCES persona(id) ON DELETE CASCADE
);

CREATE TABLE reembolso (
    cliente_id VARCHAR2(16) NOT NULL,
    i NUMBER,
    dia DATE DEFAULT SYSDATE,
    motivo VARCHAR2(256),
    nombre_viaje VARCHAR2(32),
    cant_reembolsada NUMBER,
    CONSTRAINT reembolso_pk PRIMARY KEY(cliente_id, i),
    CONSTRAINT reembolso_fk FOREIGN KEY(cliente_id) 
        REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER reembolso_i_autoincrement 
    BEFORE INSERT ON reembolso 
    FOR EACH ROW 
BEGIN 
    SELECT MAX(i) + 1 INTO :new.i 
        FROM reembolso r, cliente c
        WHERE :new.cliente_id = c.id;
END; 
/


CREATE TABLE viaje (
    fecha_inicio DATE NOT NULL,
    descripcion VARCHAR2(256),
    nombre VARCHAR2(64),
    precio NUMBER,
    reservados NUMBER DEFAULT 0,
    lugares NUMBER NOT NULL,
    CONSTRAINT viaje_pk PRIMARY KEY(fecha_inicio)
);

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

CREATE TABLE itinerario (
    viaje_id DATE NOT NULL,
    a_direccion VARCHAR(64) NOT NULL,
    a_fecha DATE NOT NULL,
    a_hora DATE NOT NULL,
    b_direccion VARCHAR(64) NOT NULL,
    b_fecha DATE NOT NULL,
    b_hora DATE NOT NULL,
    CONSTRAINT itinerario_pk 
        PRIMARY KEY(a_direccion, a_fecha, a_hora),
    CONSTRAINT itinerario_fk
        FOREIGN KEY(viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE
);

CREATE TABLE autobus (
    matricula VARCHAR2(16) NOT NULL,
    viaje_id DATE NOT NULL,
    wc NUMBER,
    cantidad_asientos NUMBER,
    asientos_ocupados NUMBER,
    CONSTRAINT autobus_pk PRIMARY KEY(matricula),
    CONSTRAINT autobus_fk FOREIGN KEY(viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE
);

CREATE TABLE hospedaje (
    ubicacion VARCHAR2(32) NOT NULL,
    fecha DATE NOT NULL,
    nombre VARCHAR2(64) NOT NULL,
    viaje_id DATE NOT NULL,
    valoracion NUMBER,
    CONSTRAINT hospedaje_pk PRIMARY KEY (ubicacion, fecha),
    CONSTRAINT hospedaje_fk FOREIGN KEY (viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE
);

CREATE TABLE habitacion_reservada (
    numero NUMBER NOT NULL,
    planta NUMBER NOT NULL,
    cant_personas NUMBER DEFAULT 1,
    ubicacion VARCHAR(32) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT habitacion_reservada_pk
        PRIMARY KEY(ubicacion, fecha, numero),
    CONSTRAINT habitacion_reservada_fk 
        FOREIGN KEY(ubicacion, fecha)
            REFERENCES hospedaje(ubicacion, fecha) 
            ON DELETE CASCADE
);

