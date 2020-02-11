-- clientes que no son estudiantes
CREATE OR REPLACE VIEW v_cliente_no_estudiante AS 
    SELECT p.id, p.nombre FROM persona p 
        JOIN cliente c ON p.id = c.id  
    AND NOT p.id IN (SELECT persona_id FROM estudiante);

