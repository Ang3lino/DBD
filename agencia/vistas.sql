
-- Vistas
-- obtener el fragmento minitermino mixto de los estudiantes con su 
-- clave, nombre y nota media
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

-- visualizar la cantidad invertida por los clientes en el viaje con su nombre
CREATE VIEW v_cliente_inversion AS 
    SELECT 
        p.id, c.nickname, SUM(cv.cant_pagada) AS total
    FROM persona p 
        JOIN cliente c ON p.id = c.id 
        JOIN compra_viaje cv ON c.id = cv.cliente_id 
    GROUP BY p.id, c.nickname
    ORDER BY total DESC;    

-- mostrar todas las habitaciones reservadas para el dia de hoy
CREATE VIEW v_habitaciones_hoy AS 
    SELECT 
        h.ubicacion, v.nombre, hr.planta, hr.numero, hr.cant_personas 
    FROM habitacion_reservada hr 
        JOIN hospedaje h ON hr.ubicacion = h.ubicacion AND hr.fecha = h.fecha
        JOIN viaje v ON h.viaje_id = v.fecha_inicio 
    WHERE v.fecha_inicio = SYSDATE;