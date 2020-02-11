-- Los guias tendran al menos 18 anios de edad
CREATE OR REPLACE TRIGGER t_guia_edad 
  BEFORE INSERT ON guia 
  FOR EACH ROW 
  DECLARE 
    v_edad NUMBER := 0;
BEGIN 
  SELECT edad INTO v_edad FROM persona WHERE id = :new.persona_id;
  IF v_edad < 18 THEN 
    RAISE_APPLICATION_ERROR(-20000, 'No tiene la edad suficiente (18).');
  END IF;
END;
/

