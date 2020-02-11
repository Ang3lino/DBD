-- Las fechas de la promocion consistentes, asi como el rango del porcentaje
ALTER TABLE promocion ADD CONSTRAINT chk_promocion_fechas_descuento 
    CHECK (desde <= hasta AND desc_porcentaje BETWEEN 0 AND 1);

