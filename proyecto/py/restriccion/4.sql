-- a lo mas habria dos banos en un autobus
ALTER TABLE autobus 
    ADD CONSTRAINT chk_autobus_wc 
    CHECK (wc BETWEEN 0 AND 2);

