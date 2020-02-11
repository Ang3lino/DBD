-- al detectar que se tiene al menos 3 idiomas, agregar un aumento de sueldo
CREATE OR REPLACE TRIGGER t_idioma_incremento_sueldo 
  BEFORE INSERT ON guia_idioma 
  FOR EACH ROW 
  DECLARE 
      idioma_count NUMBER ;
BEGIN 
  SELECT count(*) INTO idioma_count FROM guia g 
    JOIN guia_idioma gi ON g.persona_id = gi.guia_id
    WHERE persona_id = :new.guia_id;
  IF idioma_count = 2 THEN 
    UPDATE guia 
      SET aumento_porcentaje = aumento_porcentaje + 0.1
      WHERE persona_id = :new.guia_id;
  END IF;
END;
/

