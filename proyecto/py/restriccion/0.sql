-- Restriciones de integridad
-- Email de una persona validado por expresion regular
ALTER TABLE persona 
    ADD CONSTRAINT chk_persona_email
    CHECK (REGEXP_LIKE (email,'^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'));

