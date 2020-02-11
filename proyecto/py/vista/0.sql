-- Vistas
-- obtener el fragmento minitermino mixto de los estudiantes con su 
-- clave, nombre y nota media
CREATE OR REPLACE VIEW v_estudiante_nota_media AS 
    SELECT 
        p.id, 
        p.nombre, p.primer_apellido, p.segundo_apellido, 
        AVG(em.calificacion) AS nota_media
    FROM persona p 
        JOIN estudiante_materia em ON p.id = em.estudiante_id
        JOIN materia m  ON em.materia_id = m.clave
    GROUP BY p.id, p.nombre, p.primer_apellido, p.segundo_apellido;

