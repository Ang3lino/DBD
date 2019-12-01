
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

CREATE TABLE guia (
    desde DATE DEFAULT SYSDATE,
    salario_mensual NUMBER DEFAULT 500,
    persona_id VARCHAR2(32),
    activo CHAR(1) DEFAULT '1',
    aumento_porcentaje NUMBER DEFAULT 0,
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
    nombre VARCHAR2(64) NOT NULL,
    CONSTRAINT materia_pk PRIMARY KEY(clave)
);

CREATE TABLE estudiante_materia (
    estudiante_id VARCHAR2(32) NOT NULL,
    materia_id VARCHAR2(8) NOT NULL,
    calificacion NUMBER NOT NULL,
    fecha_fin DATE NOT NULL,
    forma_eval VARCHAR2(16) NOT NULL,
    CONSTRAINT estudiante_materia_pk PRIMARY KEY(estudiante_id, materia_id)
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

CREATE TABLE autobus (
    matricula VARCHAR2(16) NOT NULL,
    wc NUMBER,
    cantidad_asientos NUMBER,
    CONSTRAINT autobus_pk PRIMARY KEY(matricula)
);

CREATE TABLE viaje_autobus (
    matricula VARCHAR2(16) NOT NULL,
    viaje_id DATE NOT NULL,
    CONSTRAINT viaje_autobus_pk PRIMARY KEY(matricula, viaje_id),
    CONSTRAINT viaje_autobus_viaje_fk FOREIGN KEY(viaje_id)
        REFERENCES viaje(fecha_inicio) ON DELETE CASCADE,
    CONSTRAINT viaje_autobus_autobus_fk FOREIGN KEY(matricula)
        REFERENCES autobus(matricula) ON DELETE CASCADE
);

CREATE TABLE hospedaje (
    ubicacion VARCHAR2(128) NOT NULL,
    nombre VARCHAR2(128) NOT NULL,
    valoracion NUMBER,
    CONSTRAINT hospedaje_pk PRIMARY KEY (ubicacion)
);

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

