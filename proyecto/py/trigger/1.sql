-- Definicion de disparadores
-- Consistencia en el aumento del guia
CREATE OR REPLACE TRIGGER t_guia_aumento_porcentaje 
  BEFORE INSERT OR UPDATE OF activo ON guia 
  FOR EACH ROW
  DECLARE 
    student_too NUMBER DEFAULT 0;
    previous_percentage_applied NUMBER DEFAULT 0;
BEGIN 
  IF INSERTING THEN 
    SELECT count(*) INTO student_too
      FROM estudiante 
      WHERE persona_id = :new.persona_id;
    IF student_too > 0 AND :new.aumento_porcentaje = 0 THEN 
      :new.aumento_porcentaje := 0.1;
    END IF;
  ELSE 
      IF :new.activo = 0 AND :old.aumento_porcentaje > 0 THEN 
        :new.aumento_porcentaje := :old.aumento_porcentaje - 0.1;
      END IF;
  END IF;
END;
/

