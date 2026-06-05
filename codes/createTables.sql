USE db_uea; 

CREATE TABLE IF NOT EXISTS Usuario (
	id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE,
    num_cuen VARCHAR(15) NOT NULL UNIQUE,
    tipo ENUM('estudiante','prefesor','empleado') DEFAULT 'estudiante'
);

CREATE TABLE IF NOT EXISTS Multa (
	id_multa INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    monto DECIMAL(10,2) NOT NULL,
    estatus BOOLEAN DEFAULT FALSE,
    
	-- Columna de Clave Foranea 
	prestamo_id INT,
    
    -- Clave foranea para las prestamo 
    CONSTRAINT fk_multa_prestamo FOREIGN KEY (prestamo_id)
    REFERENCES Prestamo(id_prestamo)
    ON DELETE CASCADE
    
);

CREATE TABLE IF NOT EXISTS Prestamo (
	id_prestamo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fecha_sal DATE NOT NULL,
    fecha_est DATE NOT NULL,
    fecha_dev DATE, 
    
    -- Columnas de Clave Foranea 
    usuario_id INT NOT NULL,
    ejemplar_id INT NOT NULL,
    
    -- Clave foranea para los usuario 
    CONSTRAINT fk_prestamo_usuario FOREIGN KEY (usuario_id)
    REFERENCES Usuario(id_usuario),
    -- Clave foranea para las ejemplar
    CONSTRAINT fk_prestamo_ejemplar FOREIGN KEY (ejemplar_id)
    REFERENCES Ejemplar(id_ejemplar)
);

-- Tabla de LIBRO 
CREATE TABLE IF NOT EXISTS Libro (
	id_libro INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    anio_pub YEAR NOT NULL, 
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) NOT NULL
); 

-- Tabla de AUTOR 
CREATE TABLE IF NOT EXISTS Autor (
	id_autor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL
);


-- Tabla CATEGORIA 
CREATE TABLE IF NOT EXISTS Categoria (
	id_categoria INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Ejemplar (
	id_ejemplar INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    codigo VARCHAR(45) NOT NULL,
    estado ENUM('disponible','prestado','reserva') DEFAULT 'disponible',
    libro_id INT NOT NULL,
    
    -- Clave foranea para los libros
    CONSTRAINT fk_ejemplar_libro FOREIGN KEY (libro_id)
    REFERENCES Libro(id_libro)
    ON DELETE CASCADE
);

-- Tabla intermedia: LIBRO_AUTOR
create table if not exists Libro_Autor (
	libro_id INT NOT NULL,
    autor_id INT NOT NULL,
    
    PRIMARY KEY (libro_id, autor_id),
    
    FOREIGN KEY(libro_id)
		REFERENCES Libro(id_libro)
        ON DELETE CASCADE,
	
    FOREIGN KEY(autor_id) 
		REFERENCES Autor(id_autor)
        ON DELETE CASCADE
);

-- Tabla intermedia: LIBRO_CATEGORIA
create table if not exists Libro_Categoria (
	libro_id INT NOT NULL,
    categoria_id INT NOT NULL,
    
    PRIMARY KEY(libro_id, categoria_id),
    
	FOREIGN KEY (libro_id)
		REFERENCES Libro(id_libro)
        ON DELETE CASCADE,
	FOREIGN KEY (categoria_id)
		REFERENCES Categoria(id_categoria)
        ON DELETE CASCADE
); 