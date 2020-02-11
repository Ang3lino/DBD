-- Hacer la reserva de la compra con haber pagado al menos la mitad y se 
-- aplican los descuentos
CREATE OR REPLACE TRIGGER t_compra_contador 
  BEFORE INSERT ON compra_viaje 
  FOR EACH ROW 
  DECLARE 
    v_lugares NUMBER;
    v_precio NUMBER;
    v_descuento_neto NUMBER := 0;
    v_nota_media NUMBER := 5;
    v_student_too NUMBER := 0;
BEGIN 
  SELECT lugares, precio
    INTO v_lugares, v_precio
    FROM viaje WHERE fecha_inicio = :new.viaje_id;
  SELECT count(*) 
    INTO v_student_too 
    FROM estudiante e
    JOIN cliente c ON e.persona_id = c.id
    WHERE c.id = :new.cliente_id;
  IF v_student_too = 1 THEN 
    SELECT FLOOR(nota_media) INTO v_nota_media
      FROM v_estudiante_nota_media
      WHERE id = :new.cliente_id;
    IF v_nota_media >= 6 THEN  -- o es estudiante, aplicamos descuento
      v_descuento_neto := v_precio * 0.05 * (v_nota_media - 5);
      :new.descuento_neto := v_descuento_neto;
    END IF;
  END IF;
  IF :new.cant_pagada < (v_precio - v_descuento_neto) * 0.5 THEN
    RAISE_APPLICATION_ERROR(-20000, 'Se debe de pagar al menos la mitad del viaje para reservar.');
  END IF;
  UPDATE viaje SET reservados = reservados + 1 WHERE fecha_inicio = :new.viaje_id;
END;
/

