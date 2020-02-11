CREATE OR REPLACE TRIGGER tr_persona_guia_edad 
  BEFORE UPDATE OF edad ON persona
  FOR EACH ROW 
  WHEN (new.edad < 18)
  DECLARE 
    v_guia_too NUMBER := 0;
BEGIN 
  SELECT count(*) 
    INTO v_guia_too 
    FROM guia 
    WHERE persona_id = :new.id;
  IF v_guia_too = 1 THEN 
    RAISE_APPLICATION_ERROR(-20005, 'La edad al actualizar debe ser mayor a 18');
  END IF;
END;
/

