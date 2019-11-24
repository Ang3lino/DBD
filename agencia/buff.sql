CREATE TABLE estudiante (
    persona_id VARCHAR2(32),
    matricula VARCHAR2(16),
    carrera VARCHAR2(32),
    CONSTRAINT estudiante_pk PRIMARY KEY (persona_id),
    CONSTRAINT estudiante_fk FOREIGN KEY (persona_id) 
        REFERENCES persona(id) ON DELETE CASCADE 
);

CREATE TABLE guia_estudiante (
    id VARCHAR2(16) NOT NULL,
    porcentaje_extra NUMBER,
    CONSTRAINT guia_estudiante_pk PRIMARY KEY (id),
    CONSTRAINT guia_estudiante_fk FOREIGN KEY(id)
        REFERENCES persona(id) ON DELETE CASCADE
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

CREATE VIEW v_estudiante_nota_media AS 
    SELECT 
        p.id, 
        p.nombre, 
        p.primer_apellido, 
        p.segundo_apellido, 
        AVG(m.calificacion) AS nota_media
    FROM persona p 
        JOIN estudiante e ON p.id = e.persona_id
        JOIN materia m  ON e.persona_id = m.estudiante_id 
    GROUP BY p.id, p.nombre, p.primer_apellido, p.segundo_apellido;