CREATE USER admin WITH PASSWORD '1234';
CREATE DATABASE plataforma_fepi WITH OWNER admin;

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre_actor VARCHAR(50) UNIQUE NOT NULL
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

-- HU006 -------------------------------------------------
-- Al ser una historia de consulta, se crea una VISTA basada en la tabla 'documentos_contrato' de la HU005.
-- Esto cumple con el criterio de mostrar un listado claro asociado al contrato para su descarga.

CREATE OR REPLACE VIEW v_consulta_documentacion_contractual AS
SELECT 
    d.id AS documento_id,
    c.id AS contrato_id,
    c.no_contrato,
    c.objeto AS objeto_contrato,
    d.tipo_documento,
    d.nombre_archivo,
    d.ruta_archivo,
    d.fecha_carga
FROM documentos_contrato d
INNER JOIN contratos c ON d.contrato_id = c.id;


-- HU007 -------------------------------------------------

-- 1. Tabla principal para la Carátula / Cabecera de la Estimación
CREATE TABLE estimaciones (
    id SERIAL PRIMARY KEY,
    contrato_id INT NOT NULL,
    numero_estimacion INT NOT NULL,               -- Ejemplo: Estimación No. 1, 2, 3...
    fecha_inicio_periodo DATE NOT NULL,          -- Fecha de inicio del periodo estimativo
    fecha_fin_periodo DATE NOT NULL,             -- Fecha de fin del periodo estimativo
    monto_estimado DECIMAL(15, 2) NOT NULL,      -- Monto económico acumulado en el periodo (sin IVA)
    usuario_registra_id INT NOT NULL,            -- ID del Superintendente que la integra
    estatus_revision VARCHAR(20) DEFAULT 'Pendiente', -- Estado inicial para la HU008 (Pendiente, Aceptada, Rechazada)
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_estimacion_contrato FOREIGN KEY (contrato_id) REFERENCES contratos(id) ON DELETE RESTRICT,
    CONSTRAINT fk_estimacion_usuario FOREIGN KEY (usuario_registra_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    
    -- Evita que se duplique el número de estimación para un mismo contrato
    CONSTRAINT uq_num_estimacion_por_contrato UNIQUE (contrato_id, numero_estimacion),
    -- Validación lógica de fechas del periodo
    CONSTRAINT chk_fechas_periodo CHECK (fecha_fin_periodo >= fecha_inicio_periodo),
    -- Validación para el flujo posterior de la HU008
    CONSTRAINT chk_estatus_revision CHECK (estatus_revision IN ('Pendiente', 'Aceptada', 'Rechazada'))
);

-- 2. Tabla para los Documentos de Soporte y Evidencias de la Estimación
-- Alberga: Números generadores, Registro fotográfico y Notas de soporte en archivos adjuntos.
CREATE TABLE soporte_estimaciones (
    id SERIAL PRIMARY KEY,
    estimacion_id INT NOT NULL,
    tipo_soporte VARCHAR(50) NOT NULL,            -- Tipo de archivo adjunto
    nombre_archivo VARCHAR(255) NOT NULL,
    ruta_archivo VARCHAR(500) NOT NULL,           -- Ubicación física del archivo en el servidor/storage
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_soporte_estimacion FOREIGN KEY (estimacion_id) REFERENCES estimaciones(id) ON DELETE CASCADE,
    CONSTRAINT chk_tipo_soporte CHECK (
        tipo_soporte IN (
            'Números generadores', 
            'Registro fotográfico', 
            'Notas de soporte'
        )
    )
);