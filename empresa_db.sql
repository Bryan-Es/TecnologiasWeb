-- ============================================================
--  Script de Base de Datos - TecnologiasWeb
--  Proyecto: Gestion de Empresa (Departamentos y Empleados)
--  BD: MySQL | Servidor: Railway
--  Autor: Bryan Esparza
-- ============================================================

-- Crear y seleccionar la base de datos
CREATE DATABASE IF NOT EXISTS railway CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE railway;

-- ============================================================
-- TABLA: departamento
-- ============================================================
CREATE TABLE IF NOT EXISTS departamento (
    id_departamento    INT          NOT NULL AUTO_INCREMENT,
    nombre_departamento VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_departamento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- TABLA: empleados
-- ============================================================
CREATE TABLE IF NOT EXISTS empleados (
    id_empleado     INT          NOT NULL AUTO_INCREMENT,
    nombre_empleado VARCHAR(100) NOT NULL,
    id_departamento INT,
    PRIMARY KEY (id_empleado),
    CONSTRAINT fk_empleados_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES departamento (id_departamento)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- DATOS DE PRUEBA
-- ============================================================
INSERT INTO departamento (nombre_departamento) VALUES
    ('Informatica'),
    ('Finanzas'),
    ('Recursos Humanos');

INSERT INTO empleados (nombre_empleado, id_departamento) VALUES
    ('Juan Perez',    1),
    ('Maria Lopez',   2),
    ('Carlos Gomez',  3),
    ('Ana Martinez',  1);
