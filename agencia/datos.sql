BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE alumno';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

/*!40101 SET @saved_cs_client   = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE alumno (
  boleta number(10) NOT NULL,
  Nombre varchar2(50) NOT NULL,
  ApPaterno varchar2(50) NOT NULL,
  ApMaterno varchar2(50) NOT NULL,
  email varchar2(50) NOT NULL,
  password varchar2(50) NOT NULL,
  Login_idLogin number(10) NOT NULL,
  PRIMARY KEY (boleta,Login_idLogin),
  CONSTRAINT c_email UNIQUE  (email)
) ;

-- CREATE INDEX fk_alumno_Login1_idx ON alumno (Login_idLogin);
/*!40101 SET character_set_client = @saved_cs_client */;

-- INSERT INTO alumno  SELECT 2013631010,'Sabrina','Perez','Araiza','Sabrina17222@gmail.com','cfvlq',173 FROM dual UNION ALL  SELECT 2013631052,'Julieta','Ruiz','Miroslava','Julieta16526@gmail.com','rpmax',166 FROM dual UNION ALL  SELECT 2013631133,'Angel','Varela','Sanchez','Angel7414@gmail.com','lhphf',75 FROM dual UNION ALL  SELECT 2013631139,'Gladys','Contreras','Loyola','Gladys3829@gmail.com','ojhfd',39 FROM dual UNION ALL  SELECT 2013631226,'Angel','Obregon','Loyola','Angel15714@gmail.com','lkqnd',158 FROM dual UNION ALL  SELECT 2013631372,'Jose','Molina','Bodet','Jose813@gmail.com','rgnbb',9 FROM dual UNION ALL  SELECT 2013631439,'Angel','Ruiz','Mesa','Angel2714@gmail.com','ffddv',28 FROM dual UNION ALL  SELECT 2013631444,'David','Vazques','Contreras','David1824@gmail.com','daqbx',183 FROM dual UNION ALL  SELECT 2013631458,'Alberto','Molina','Contreras','Alberto228@gmail.com','arteo',23 FROM dual UNION ALL  SELECT 2013631497,'Bryan','Oroszco','Ayala','Bryan5017@gmail.com','igulv',51 FROM dual UNION ALL  SELECT 2013631538,'Hugo','Lopez','Mesa','Hugo6716@gmail.com','eernj',68 FROM dual;

SELECT count(*) FROM alumno;
-- INSERT INTO alumno 

INSERT INTO alumno  SELECT 2013631540,'Miguel','Perez','Gumez','Miguel1011@gmail.com','qfipj',11 FROM dual UNION ALL  SELECT 2013631576,'Ruben','Ruiz','Ayala','Ruben75@gmail.com','jwxki',8 FROM dual UNION ALL  SELECT 2013631642,'Raymundo','Oroszco','Ayala','Raymundo557@gmail.com','skujh',56 FROM dual UNION ALL  SELECT 2013631735,'Julieta','Carranza','Montes','Julieta18326@gmail.com','cxyig',184 FROM dual UNION ALL  SELECT 2013631753,'Erik','Robles','Ayala','Erik499@gmail.com','bsdsx',50 FROM dual UNION ALL  SELECT 2013631759,'Ruben','Oroszco','Ayala','Ruben735@gmail.com','qqjeg',74 FROM dual UNION ALL  SELECT 2013631771,'Raul','Mota','Esparza','Raul1312@gmail.com','aapuj',132 FROM dual UNION ALL  SELECT 2013631855,'Erik','Ayala','Ayala','Erik1459@gmail.com','durif',146 FROM dual UNION ALL  SELECT 2013631883,'Julieta','Rojero','Araiza','Julieta18426@gmail.com','uryrq',185 FROM dual UNION ALL  SELECT 2013631901,'Bryan','Oroszco','Mesa','Bryan16217@gmail.com','skwlo',163 FROM dual UNION ALL  SELECT 2013631931,'Itzel','Contreras','Loyola','Itzel15527@gmail.com','bohbd',156 FROM dual UNION ALL  SELECT 2013631936,'Gladys','Lopez','Bodet','Gladys2529@gmail.com','srtfu',26 FROM dual UNION ALL  SELECT 2013631937,'Sabrina','Mota','Esparza','Sabrina19222@gmail.com','sbffe',193 FROM dual UNION ALL  SELECT 2013631938,'Andres','Robles','Ayala','Andres11415@gmail.com','fvcen',115 FROM dual UNION ALL  SELECT 2013631950,'Erik','Rojero','Miroslava','Erik879@gmail.com','ngilj',88 FROM dual;
DESC alumno;

INSERT INTO 
persona (
  id ,
  email ,
  nombre ,
  edad ,
  primer_apellido ,
  segundo_apellido ,
  direccion ,
  iban ,
  telefono 
) SELECT 
   boleta,
   email,
   nombre,
   18,
   appaterno,
   apmaterno,
   'direccion',
   12345678,
   555212345678
FROM alumno;
COMMIT;

SELECT * FROM persona
   ORDER BY id;
   -- FETCH FIRST 5 ROWS ONLY;

-- Personas con edad de 16
TRUNCATE table alumno;

SELECT count(*) FROM alumno;

INSERT INTO alumno SELECT 2013632088,'Itzel','Ruiz','Montes','Itzel3927@gmail.com','rcrwf',40 FROM dual UNION ALL  SELECT 2013632096,'Pedro','Ayala','Marquez','Pedro8318@gmail.com','ijhjm',84 FROM dual UNION ALL  SELECT 2013632141,'Alexis','Mota','Contreras','Alexis5410@gmail.com','djadv',55 FROM dual UNION ALL  SELECT 2013632263,'Andrea','Obregon','Centeno','Andrea10421@gmail.com','wxkrd',105 FROM dual UNION ALL  SELECT 2013632274,'Erik','Varela','Miroslava','Erik689@gmail.com','nrurn',69 FROM dual UNION ALL  SELECT 2013632311,'Ruben','Ruiz','Ayala','Ruben1035@gmail.com','ijmrv',104 FROM dual UNION ALL  SELECT 2013632352,'Josue','Carranza','Araiza','Josue1073@gmail.com','abgyp',108 FROM dual UNION ALL  SELECT 2013632377,'Raymundo','Ayala','Ayala','Raymundo337@gmail.com','dkljs',34 FROM dual UNION ALL  SELECT 2013632418,'Raymundo','Armenta','Sanchez','Raymundo917@gmail.com','nhxuu',92 FROM dual UNION ALL  SELECT 2013632447,'Alexis','Varela','Esparza','Alexis2610@gmail.com','lwcfg',27 FROM dual UNION ALL  SELECT 2013632456,'Luis','Perez','Centeno','Luis1406@gmail.com','xkseu',141 FROM dual UNION ALL  SELECT 2013632460,'Ruben','Mota','Araiza','Ruben1645@gmail.com','gnovs',165 FROM dual UNION ALL  SELECT 2013632470,'David','Molina','Miroslava','David1594@gmail.com','pghrq',160 FROM dual UNION ALL  SELECT 2013632471,'Alexis','Carranza','Centeno','Alexis18110@gmail.com','gbtlp',182 FROM dual UNION ALL  SELECT 2013632488,'Luis','Perez','Esparza','Luis466@gmail.com','bkowf',47 FROM dual UNION ALL  SELECT 2013632530,'Andrea','Varela','Mesa','Andrea6321@gmail.com','khfsm',64 FROM dual UNION ALL  SELECT 2013632532,'Hugo','Obregon','Loyola','Hugo7016@gmail.com','xoujf',71 FROM dual;
COMMIT;

INSERT INTO 
persona (
  id , email , nombre ,
  edad , primer_apellido , segundo_apellido ,
  direccion , iban , telefono 
) SELECT 
   boleta, email, nombre,
   12, appaterno, apmaterno,
   'direccion', 12345678, 555212345678
FROM alumno
   FETCH FIRST 5 ROWS ONLY;

SELECT * FROM persona ORDER BY id; 
-- INSERT INTO alumno SELECT 2013632622,'Cintia','Vazques','Ayala','Cintia9524@gmail.com','wghen',96 FROM dual UNION ALL  SELECT 2013632641,'Gladys','Molina','Torrez','Gladys13429@gmail.com','opgmw',135 FROM dual UNION ALL  SELECT 2013632664,'Andrea','Rojero','Montes','Andrea12121@gmail.com','tplcs',122 FROM dual UNION ALL  SELECT 2013632752,'Bryan','Robles','Mesa','Bryan15017@gmail.com','jcvvf',151 FROM dual UNION ALL  SELECT 2013632792,'Jose','Perez','Loyola','Jose6613@gmail.com','beeqo',67 FROM dual UNION ALL  SELECT 2013632847,'Mauricio','Contreras','Centeno','Mauricio1530@gmail.com','eaipm',154 FROM dual UNION ALL  SELECT 2013632893,'Bryan','Ayala','Araiza','Bryan7617@gmail.com','ksyeq',77 FROM dual UNION ALL  SELECT 2013632941,'Norma','Contreras','Esparza','Norma4428@gmail.com','cdnti',45 FROM dual UNION ALL  SELECT 2013633094,'Alberto','Rojero','Miroslava','Alberto1878@gmail.com','sutgj',188 FROM dual UNION ALL  SELECT 2013633097,'Jhonatan','Carranza','Miroslava','Jhonatan12012@gmail.com','ieqtm',121 FROM dual UNION ALL  SELECT 2013633154,'Maria','Obregon','Centeno','Maria1520@gmail.com','gridl',16 FROM dual UNION ALL  SELECT 2013633226,'Hugo','Obregon','Araiza','Hugo10016@gmail.com','rbskb',101 FROM dual UNION ALL  SELECT 2013633239,'Andres','Ayala','Ayala','Andres8015@gmail.com','lnvmy',81 FROM dual 
-- INSERT INTO alumno SELECT 2013633317,'Cintia','Lopez','Miroslava','Cintia4124@gmail.com','umhjg',42 FROM dual UNION ALL  SELECT 2013633318,'Julion','Varela','Araiza','Julion5819@gmail.com','tbyrx',59 FROM dual UNION ALL  SELECT 2013633365,'Ruben','Obregon','Torrez','Ruben1245@gmail.com','kpxxg',125 FROM dual UNION ALL  SELECT 2013633418,'Alberto','Carranza','Gumez','Alberto1898@gmail.com','apcjc',190 FROM dual UNION ALL  SELECT 2013633480,'Norma','Molina','Mesa','Norma11228@gmail.com','ehvgi',113 FROM dual UNION ALL  SELECT 2013633541,'Miguel','Molina','Araiza','Miguel10611@gmail.com','dsisw',107 FROM dual UNION ALL  SELECT 2013633610,'Erik','Lopez','Esparza','Erik949@gmail.com','xdpaw',95 FROM dual UNION ALL  SELECT 2013633635,'Karla','Obregon','Sanchez','Karla2025@gmail.com','taoso',21 FROM dual UNION ALL  SELECT 2013633661,'Jhonatan','Ruiz','Mesa','Jhonatan17012@gmail.com','pflcp',171 FROM dual UNION ALL  SELECT 2013633676,'Hugo','Obregon','Contreras','Hugo8516@gmail.com','hbici',86 FROM dual UNION ALL  SELECT 2013633698,'Sabrina','Mota','Miroslava','Sabrina9022@gmail.com','lvhxv',91 FROM dual UNION ALL  SELECT 2013633737,'Mauricio','Ayala','Esparza','Mauricio1090@gmail.com','ijecr',110 FROM dual UNION ALL  SELECT 2013633813,'Karla','Perez','Bodet','Karla14425@gmail.com','magjf',145 FROM dual UNION ALL  SELECT 2013633826,'Mauricio','Contreras','Mesa','Mauricio770@gmail.com','yfypt',78 FROM dual UNION ALL  SELECT 2013633846,'Alexis','Ayala','Bodet','Alexis17710@gmail.com','ofgts',178 FROM dual UNION ALL  SELECT 2013633872,'Jhonatan','Ayala','Bodet','Jhonatan3012@gmail.com','bvbxr',31 FROM dual UNION ALL  SELECT 2013633926,'Sabrina','Mota','Esparza','Sabrina2422@gmail.com','nnaxv',25 FROM dual UNION ALL  SELECT 2013633985,'Miguel','Contreras','Montes','Miguel12211@gmail.com','chbmc',123 FROM dual UNION ALL  SELECT 2013634016,'Gladys','Armenta','Mesa','Gladys16629@gmail.com','ycfbh',167 FROM dual UNION ALL  SELECT 2013634031,'Alberto','Rojero','Miroslava','Alberto898@gmail.com','niuss',90 FROM dual UNION ALL  SELECT 2013634058,'Jose','Ayala','Ayala','Jose8113@gmail.com','vevjq',82 FROM dual UNION ALL  SELECT 2013634080,'Itzel','Contreras','Torrez','Itzel1127@gmail.com','obkrk',12 FROM dual UNION ALL  SELECT 2013634082,'Alberto','Lopez','Esparza','Alberto1168@gmail.com','hwxbr',117 FROM dual UNION ALL  SELECT 2013634139,'Hugo','Robles','Marquez','Hugo6216@gmail.com','nhlrx',63 FROM dual;
-- INSERT INTO alumno SELECT 2013634147,'Sabrina','Ruiz','Montes','Sabrina16322@gmail.com','gewcx',164 FROM dual UNION ALL  SELECT 2013634319,'Gladys','Molina','Bodet','Gladys13829@gmail.com','vehyx',139 FROM dual UNION ALL  SELECT 2013634319,'Julion','Ayala','Torrez','Julion17419@gmail.com','rufkr',175 FROM dual UNION ALL  SELECT 2013634348,'Alexis','Varela','Esparza','Alexis12310@gmail.com','kddvc',124 FROM dual UNION ALL  SELECT 2013634349,'Andres','Ruiz','Miroslava','Andres4315@gmail.com','ubbtw',44 FROM dual UNION ALL  SELECT 2013634375,'Ruben','Carranza','Suarez','Ruben15@gmail.com','oddsw',2 FROM dual UNION ALL  SELECT 2013634432,'Luis','Armenta','Contreras','Luis1176@gmail.com','elioa',118 FROM dual UNION ALL  SELECT 2013634461,'Andres','Ayala','Montes','Andres15415@gmail.com','mlsew',155 FROM dual UNION ALL  SELECT 2013634532,'Norma','Oroszco','Mesa','Norma14328@gmail.com','ggeqh',144 FROM dual UNION ALL  SELECT 2013634579,'Angel','Molina','Araiza','Angel11814@gmail.com','seywh',119 FROM dual UNION ALL  SELECT 2013634581,'Miguel','Robles','Mesa','Miguel3611@gmail.com','kufvm',37 FROM dual UNION ALL  SELECT 2013634597,'Andres','Obregon','Loyola','Andres11915@gmail.com','vpojr',120 FROM dual UNION ALL  SELECT 2013634638,'Julion','Oroszco','Loyola','Julion15819@gmail.com','eyqcw',159 FROM dual UNION ALL  SELECT 2013634639,'Mariana','Rojero','Torrez','Mariana8623@gmail.com','sqnxb',87 FROM dual UNION ALL  SELECT 2013634662,'Raymundo','Armenta','Ayala','Raymundo1967@gmail.com','uhnkn',197 FROM dual UNION ALL  SELECT 2013634675,'Hugo','Oroszco','Centeno','Hugo616@gmail.com','fymqg',7 FROM dual UNION ALL  SELECT 2013634684,'Rodolfo','Vazques','Centeno','Rodolfo121@gmail.com','lssxq',13 FROM dual UNION ALL  SELECT 2013634720,'Maria','Contreras','Bodet','Maria4220@gmail.com','cbpbn',43 FROM dual UNION ALL  SELECT 2013634860,'Pedro','Mota','Marquez','Pedro19818@gmail.com','widib',199 FROM dual UNION ALL  SELECT 2013634915,'Mauricio','Contreras','Loyola','Mauricio1850@gmail.com','uhrcu',186 FROM dual;


-- CREATE TABLE guia (
--   desde DATE DEFAULT SYSDATE,
--   salario_mensual NUMBER DEFAULT 500,
--   persona_id VARCHAR2(32),
--   activo CHAR(1) DEFAULT '0',
--   aumento_porcentaje NUMBER DEFAULT 0,
--   CONSTRAINT guia_pk PRIMARY KEY (persona_id),
--   CONSTRAINT guia_fk FOREIGN KEY (persona_id) 
--     REFERENCES persona(id) ON DELETE CASCADE 
-- );

INSERT INTO 
   estudiante(persona_id, matricula, carrera)
SELECT id, 'm47r1cul4', 'Informatica'
   FROM persona
   ORDER BY id
   FETCH FIRST 3 ROWS ONLY;

-- update guia 
--    set aumento_porcentaje = aumento_porcentaje + 0.1
--    WHERE persona_id in ('2013631540', '2013631576', '2013631642');

INSERT INTO 
guia (
  persona_id 
) SELECT id FROM persona 
   FETCH FIRST 5 ROWS ONLY;

SELECT COUNT(*) FROM persona;

-- INSERT INTO 
-- cliente (
--   persona_id 
-- ) SELECT id FROM persona 
--    FETCH FIRST 10 ROWS ONLY;

INSERT INTO cliente (
   id ,
   nickname ,
   contrasena ,
   desde 
) SELECT id, 'nickname', '12345678', SYSDATE 
   FROM persona FETCH FIRST 10 ROWS ONLY;

INSERT INTO materia (
  clave , nombre
) 
   SELECT 'C101', 'ANALISIS VECTORIAL'
    FROM dual UNION ALL
   SELECT 'C102', 'CALCULO'
    FROM dual UNION ALL
   SELECT 'C103', 'MATEMATICAS DISCRETAS'
    FROM dual UNION ALL
   SELECT 'C104', 'ALGORITMIA Y PROGRAMACION ESTRUCTURADA'
    FROM dual UNION ALL
   SELECT 'C105', 'FISICA'
    FROM dual UNION ALL
   SELECT 'C106', 'INGENIERIA ETICA Y SOCIEDAD'
    FROM dual UNION ALL
   SELECT 'C107', 'ECUACIONES DIFERENCIALES'
    FROM dual UNION ALL
   SELECT 'C108', 'ALGEBRA LINEAL'
    FROM dual UNION ALL
   SELECT 'C109', 'CALCULO APLICADO'
    FROM dual UNION ALL
   SELECT 'C110', 'ESTRUCTURAS DE DATOS'
    FROM dual UNION ALL
   SELECT 'C111', 'COMUNICACION ORAL Y ESCRITA'
    FROM dual UNION ALL
   SELECT 'C112', 'ANALISIS FUNDAMENTAL DE CIRCUITOS'
    FROM dual
;

INSERT INTO materia(clave, nombre)
   SELECT 'C213', 'MATEMATICAS AVANZADAS PARA LA INGENIERIA' 
    FROM dual UNION ALL
   SELECT 'C214', 'FUNDAMENTOS ECONOMICOS' 
    FROM dual UNION ALL
   SELECT 'C215', 'FUNDAMENTOS DE DISEÑO DIGITAL' 
    FROM dual UNION ALL
   SELECT 'C216', 'TEORIA COMPUTACIONAL' 
    FROM dual UNION ALL
   SELECT 'C217', 'BASES DE DATOS' 
    FROM dual UNION ALL
   SELECT 'C218', 'PROGRAMACION ORIENTADA A OBJETOS' 
    FROM dual UNION ALL
   SELECT 'C219', 'ELECTRONICA ANALOGICA' 
    FROM dual UNION ALL
   SELECT 'C220', 'REDES DE COMPUTADORAS' 
    FROM dual UNION ALL
   SELECT 'C221', 'DISEÑO DE SISTEMAS DIGITALES' 
    FROM dual UNION ALL
   SELECT 'C222', 'PROBABILIDAD Y ESTADISTICA' 
    FROM dual UNION ALL
   SELECT 'C223', 'SISTEMAS OPERATIVOS' 
    FROM dual UNION ALL
   SELECT 'C224', 'ANALISIS Y DISEÑO ORIENTADO A OBJETOS' 
    FROM dual UNION ALL
   SELECT 'C225', 'TECNOLOGIAS PARA LA WEB' 
    FROM dual UNION ALL
   SELECT 'C226', 'ADMINISTRACION FINANCIERA' 
    FROM dual;


INSERT INTO estudiante_materia (
   materia_id, fecha_fin, forma_eval, 
   calificacion, estudiante_id 
) 
   SELECT 'C101', '18-12-2016', 'ORD',	9, '2013631540'
    FROM dual UNION ALL
   SELECT 'C102', '18-12-2916', 'ORD', 10 , '2013631540'
    FROM dual UNION ALL
   SELECT 'C103', '18-12-2016', 'ORD',	8, '2013631540'
    FROM dual UNION ALL
   SELECT 'C104', '18-12-2016',	'ORD',	7, '2013631540'
    FROM dual UNION ALL
   SELECT 'C105', '18-12-2016', 'ORD', 9, '2013631540'
    FROM dual UNION ALL
   SELECT 'C106', '18-12-2016', 'ORD', 8, '2013631540'
    FROM dual UNION ALL
   SELECT 'C107', '18-12-2016', 'ORD', 10, '2013631540'
    FROM dual UNION ALL
   SELECT 'C108', '18-12-2016', 'ORD',  9, '2013631540'
    FROM dual UNION ALL
   SELECT 'C109', '18-12-2016', 'ORD', 10, '2013631540'
    FROM dual UNION ALL
   SELECT 'C110', '18-12-2016', 'ORD', 10, '2013631540'
    FROM dual UNION ALL
   SELECT 'C111', '18-12-2016', 'ORD', 10 , '2013631540'
    FROM dual UNION ALL
   SELECT 'C112',  '18-12-2016', 'ORD', 8, '2013631540'
    FROM dual
;

INSERT INTO estudiante_materia (
   materia_id, estudiante_id, fecha_fin, 
   forma_eval, calificacion
) 
   SELECT 'C213', '2013631576', '20-12-2017',	'ORD', 6
    FROM dual UNION ALL
   SELECT 'C216', '2013631576', '26-07-2018', 'ORD', 6
    FROM dual UNION ALL
   SELECT 'C218', '2013631576', '26-07-2018', 'ORD', 6
    FROM dual UNION ALL
   SELECT 'C220', '2013631576', '26-07-2018', 'ORD', 6
    FROM dual UNION ALL
   SELECT 'C221', '2013631576', '26-07-2018', 'ORD', 6
    FROM dual UNION ALL
   SELECT 'C224', '2013631576', '26-07-2018', 'ORD', 6
    FROM dual UNION ALL
   SELECT 'C214', '2013631576', '26-07-2018', 'ORD', 9
    FROM dual;

INSERT INTO estudiante_materia (
   materia_id, estudiante_id, fecha_fin, 
   forma_eval, calificacion
) 
   SELECT 'C226', '2013631642', '26-07-2018', 'ORD', 9
    FROM dual UNION ALL
   SELECT 'C215', '2013631642', '20-12-2017', 'ORD', 8
    FROM dual ;

INSERT INTO estudiante_materia (
   materia_id, estudiante_id, fecha_fin, 
   forma_eval, calificacion
) 
   SELECT 'C222', '2013631642', '26-07-2018', 'ORD', 8
    FROM dual UNION ALL
   SELECT 'C217', '2013631642', '26-07-2018', 'ORD', 8
    FROM dual UNION ALL
   SELECT 'C225', '2013631642', '26-07-2018', 'ORD', 8
    FROM dual UNION ALL
   SELECT 'C223', '2013631642', '26-07-2018', 'ORD', 7
    FROM dual UNION ALL
   SELECT 'C219', '2013631642', '26-07-2018', 'ORD', 6
    FROM dual;


INSERT INTO viaje (
  fecha_inicio , descripcion , nombre ,
  precio , lugares 
) 
   SELECT 
    '09-12-2019', 
    'El Viaje a Marruecos es una experiencia inolvidable en la que tendremos la oportunidad de conocer la cultura árabe de primera mano. Cruzaremos las Montañas del Atlas, dormiremos en las dunas más altas de Marruecos...',
    'Viaje a Marruecos',
    160,
    5 FROM dual;

INSERT INTO autobus (
   matricula, wc, cantidad_asientos
) VALUES ('3000AAA', 2, 5);

INSERT INTO viaje_autobus (
  matricula , viaje_id 
) VALUES (
   '3000AAA', '09-12-2019'
);

INSERT INTO itinerario (
  viaje_id ,
  a_direccion , a_fecha , a_hora 
)  SELECT '09-12-2019', 
    'Aeropuerto de Marrakech', '09-12-2019', '14:28' FROM dual;

-- local
INSERT INTO compra_viaje (
  viaje_id , guia_id , cliente_id , cant_pagada 
) VALUES (
  '09-12-2019', '2013631540', '2013631540', 70);

INSERT INTO compra_viaje (
  viaje_id , guia_id , cliente_id , cant_pagada 
) VALUES (
  '09-12-2019', '2013631540', '2013631735', 80);

INSERT INTO compra_viaje (
  viaje_id , guia_id , cliente_id , cant_pagada 
) VALUES (
  '09-12-2019', '2013631540', '2013631576', 90);

INSERT INTO compra_viaje (
  viaje_id , guia_id , cliente_id , cant_pagada 
) VALUES (
  '09-12-2019', '2013631540', '2013631642', 100);

INSERT INTO compra_viaje (
  viaje_id , guia_id , cliente_id , cant_pagada 
) VALUES (
  '09-12-2019', '2013631540', '2013631753', 110);

INSERT INTO compra_viaje (
  viaje_id , guia_id , cliente_id , cant_pagada 
) VALUES (
  '09-12-2019', '2013631540', '2013631759', 110);

commit;


-- Here we go
BEGIN
  insert_compra_viaje('09-12-2019', '2013631540', '2013631540', 70);
  insert_compra_viaje('09-12-2019', '2013631540', '2013631735', 80);
  insert_compra_viaje('09-12-2019', '2013631540', '2013631576', 90);
  insert_compra_viaje('09-12-2019', '2013631540', '2013631642', 100);
  insert_compra_viaje('09-12-2019', '2013631540', '2013631753', 110);
  insert_compra_viaje('09-12-2019', '2013631540', '2013631759', 110);
END;

-- BEGIN
--    insert_compra_viaje('09/12/2019', '2013631010', '2013631052', 80);
--    insert_compra_viaje('09-12-2019', '2013631010', '2013631133', 90);
--    insert_compra_viaje('09-12-2019', '2013631010', '2013631139', 100);
--    insert_compra_viaje('09-12-2019', '2013631010', '2013631226', 90);
--    insert_compra_viaje('09-12-2019', '2013631010', '2013631372', 80);
-- END;