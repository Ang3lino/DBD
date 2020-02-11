-- A lo mas el guia tendra un descuento del 30%
ALTER TABLE guia ADD CONSTRAINT chk_guia_aumento_porcentaje 
    CHECK (aumento_porcentaje BETWEEN 0 AND 0.30);

