-- No puede haber mas lugares reservados del total de plazas
ALTER TABLE viaje 
    ADD CONSTRAINT chk_viaje_reservados 
    CHECK (reservados <= lugares);

