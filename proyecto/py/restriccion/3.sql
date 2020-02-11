-- la calificacion posible esta entre 0 y 10
ALTER TABLE estudiante_materia 
    ADD CONSTRAINT chk_es_mat_cal 
    CHECK (calificacion BETWEEN 0 AND 10);

