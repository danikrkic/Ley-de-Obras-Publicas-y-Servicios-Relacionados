CREATE USER admin WITH PASSWORD '1234';
CREATE DATABASE plataforma_fepi WITH OWNER admin;

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre_actor VARCHAR(50) UNIQUE NOT NULL,
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, 
    nombre_completo VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    rol_id INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE, 
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE RESTRICT
);

INSERT INTO roles (nombre) VALUES ('Dependencia'), ('Residente de obra'), ('Superintendente'), ('Supervisión');

-- HU001 ---------------------------------------------------------------------------------------------------------

CREATE TABLE contratos (
    id SERIAL PRIMARY KEY,
    no_contrato VARCHAR(50) UNIQUE NOT NULL,
    objeto TEXT NOT NULL,
    monto DECIMAL(15, 2) NOT NULL,
    plazo_ejecucion_dias INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_termino DATE NOT NULL,
    datos_contratista VARCHAR(255) NOT NULL,
    ubicacion_obra VARCHAR(255) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- HU002 ------------------------------------------

CREATE TABLE bitacoras (
    id SERIAL PRIMARY KEY,
    contrato_id INT UNIQUE NOT NULL,
    usuario_id INT NOT NULL,
    fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estatus VARCHAR(20) DEFAULT 'Abierta',
    
    CONSTRAINT fk_bitacora_contrato FOREIGN KEY (contrato_id) REFERENCES contratos(id) ON DELETE RESTRICT,
    CONSTRAINT fk_bitacora_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE RESTRICT
);

-- HU003 -------------------------------------------

CREATE TABLE notas_bitacora (
    id SERIAL PRIMARY KEY,
    bitacora_id INT NOT NULL,
    autor_id INT NOT NULL,
    folio_nota INT NOT NULL,
    tipo_nota VARCHAR(20) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    firma_nota1 VARCHAR(255) NOT NULL, 
    firma_nota2 VARCHAR(255),          
    firma_nota3 VARCHAR(255),
    
    CONSTRAINT fk_nota_bitacora FOREIGN KEY (bitacora_id) REFERENCES bitacoras(id) ON DELETE RESTRICT,
    CONSTRAINT fk_nota_autor FOREIGN KEY (autor_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    
    CONSTRAINT uq_folio_por_bitacora UNIQUE (bitacora_id, folio_nota),
    CONSTRAINT chk_tipo_nota CHECK (tipo_nota IN ('Apertura', 'Instrucción', 'Respuesta', 'Acuerdo', 'Observación'))
);

-- HU004 ---------------------------------------------


-- es consulta -------------------------------------------

-- HU005 ------------ AUN NO ESTA LISTA -------------------------------------

CREATE TABLE documentos_contrato (
    id SERIAL PRIMARY KEY,
    contrato_id INT NOT NULL,
    tipo_documento VARCHAR(50) NOT NULL,
    nombre_archivo VARCHAR(255) NOT NULL,
    ruta_archivo VARCHAR(500) NOT NULL, 
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_doc_contrato FOREIGN KEY (contrato_id) REFERENCES contratos(id) ON DELETE RESTRICT,
    CONSTRAINT chk_tipo_doc CHECK (
        tipo_documento IN (
            'Catálogo de conceptos', 
            'Programa de Obra', 
            'Fianzas', 
            'Garantías', 
            'Información Jurídica', 
            'Contrato digitalizado'
        )
    )
);

-- HU006 -------------------------------------------------------------

