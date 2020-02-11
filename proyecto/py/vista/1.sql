-- visualizar la cantidad invertida por los clientes en el viaje con su nombre
CREATE OR REPLACE VIEW v_cliente_inversion AS 
    SELECT 
        p.id, c.nickname, SUM(cv.cant_pagada) AS total
    FROM persona p 
        JOIN cliente c ON p.id = c.id 
        JOIN compra_viaje cv ON c.id = cv.cliente_id 
    GROUP BY p.id, c.nickname
    ORDER BY total DESC;    

