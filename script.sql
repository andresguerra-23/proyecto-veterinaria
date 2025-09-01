CREATE DATABASE IF NOT EXISTS veterinaria_proyect;
USE veterinaria_proyect;

-- =====================
-- TABLA USUARIO
-- =====================
CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    rol ENUM('admin','veterinario','asistente') DEFAULT 'asistente'
);

-- =====================
-- TABLA VETERINARIO
-- =====================
CREATE TABLE Veterinario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    cedula_profesional VARCHAR(50),
    especialidad VARCHAR(100),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id) ON DELETE CASCADE
);

-- =====================
-- TABLA CLIENTE
-- =====================
CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cedula VARCHAR(50) UNIQUE,
    direccion VARCHAR(150),
    telefono VARCHAR(50),
    correo VARCHAR(100)
);

-- =====================
-- TABLA MASCOTA
-- =====================
CREATE TABLE Mascota (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especie ENUM('Canino','Felino'),
    raza VARCHAR(100),
    edad_anios INT,
    sexo ENUM('M','H'),
    estado_reproductivo VARCHAR(50),
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id) ON DELETE CASCADE
);

-- =====================
-- TABLA CITA
-- =====================
CREATE TABLE Cita (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    motivo VARCHAR(255),
    estado ENUM('Creada','Pendiente','Atendida','Cancelada') DEFAULT 'Creada',
    mascota_id INT NOT NULL,
    veterinario_id INT NOT NULL,
    FOREIGN KEY (mascota_id) REFERENCES Mascota(id) ON DELETE CASCADE,
    FOREIGN KEY (veterinario_id) REFERENCES Veterinario(id) ON DELETE CASCADE
);

-- =====================
-- TABLA DIAGNOSTICO
-- =====================
CREATE TABLE Diagnostico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cita_id INT NOT NULL,
    enfermedad ENUM('Parvovirosis','Moquillo','Leucemia Felina','Panleucopenia','Inmunodeficiencia'),
    descripcion TEXT,
    tratamiento TEXT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cita_id) REFERENCES Cita(id) ON DELETE CASCADE
);

-- =====================
-- TABLA HISTORIAL MEDICO
-- =====================
CREATE TABLE HistorialMedico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mascota_id INT NOT NULL,
    diagnostico_id INT NOT NULL,
    observaciones TEXT,
    proxima_cita DATE,
    FOREIGN KEY (mascota_id) REFERENCES Mascota(id) ON DELETE CASCADE,
    FOREIGN KEY (diagnostico_id) REFERENCES Diagnostico(id) ON DELETE CASCADE
);
