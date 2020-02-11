CREATE TABLE guia_idioma (
    guia_id VARCHAR(32),
    idioma VARCHAR(16),
    CONSTRAINT guia_idioma_pk PRIMARY KEY (guia_id, idioma),
    CONSTRAINT guia_idioma_fk FOREIGN KEY (guia_id) 
        REFERENCES guia(persona_id) ON DELETE CASCADE 
);

