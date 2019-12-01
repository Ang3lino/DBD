
-- Vistas
-- obtener el fragmento minitermino mixto de los estudiantes con su 
-- clave, nombre y nota media
CREATE OR REPLACE VIEW v_estudiante_nota_media AS 
    SELECT 
        p.id, 
        p.nombre, p.primer_apellido, p.segundo_apellido, 
        AVG(em.calificacion) AS nota_media
    FROM persona p 
        JOIN estudiante_materia em ON p.id = em.estudiante_id
        JOIN materia m  ON em.materia_id = m.clave
    GROUP BY p.id, p.nombre, p.primer_apellido, p.segundo_apellido;

-- visualizar la cantidad invertida por los clientes en el viaje con su nombre
CREATE OR REPLACE VIEW v_cliente_inversion AS 
    SELECT 
        p.id, c.nickname, SUM(cv.cant_pagada) AS total
    FROM persona p 
        JOIN cliente c ON p.id = c.id 
        JOIN compra_viaje cv ON c.id = cv.cliente_id 
    GROUP BY p.id, c.nickname
    ORDER BY total DESC;    

-- clientes que no son estudiantes
CREATE OR REPLACE VIEW v_cliente_no_estudiante AS 
    SELECT p.id, p.nombre FROM persona p 
        JOIN cliente c ON p.id = c.id  
    AND NOT p.id IN (SELECT persona_id FROM estudiante);

