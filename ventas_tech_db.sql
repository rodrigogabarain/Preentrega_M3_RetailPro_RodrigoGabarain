-- DROP TABLES en orden inverso
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS territorios;
DROP TABLE IF EXISTS categorias;

-- Tabla categorias
CREATE TABLE categorias (
  id_categoria INT PRIMARY KEY,
  nombre_categoria VARCHAR(50) NOT NULL,
  descripcion VARCHAR(200)
);

-- Tabla clientes
CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY,
  nombre_razon_social VARCHAR(100) NOT NULL,
  telefono VARCHAR(20),
  email VARCHAR(100) UNIQUE,
  ciudad VARCHAR(100),
  segmento VARCHAR(50),
  fecha_registro DATE NOT NULL
);

-- Tabla territorios
CREATE TABLE territorios (
  id_territorio INT PRIMARY KEY,
  provincia_estado VARCHAR(100),
  pais VARCHAR(100),
  region VARCHAR(50)
);

-- Tabla productos
CREATE TABLE productos (
  id_producto INT PRIMARY KEY,
  modelo_producto VARCHAR(100) NOT NULL,
  marca VARCHAR(50),
  costo_unitario DECIMAL(10,2) NOT NULL,
  precio_lista DECIMAL(10,2) NOT NULL,
  id_categoria INT NOT NULL,
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria)
    REFERENCES categorias(id_categoria)
);

-- Tabla ventas
CREATE TABLE ventas (
  id_venta INT PRIMARY KEY,
  fecha_venta DATE NOT NULL,
  id_cliente INT NOT NULL,
  id_producto INT NOT NULL,
  id_territorio INT NOT NULL,
  canal VARCHAR(50),
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  descuento DECIMAL(5,2),
  total_venta DECIMAL(12,2),
  CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
  CONSTRAINT fk_venta_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
  CONSTRAINT fk_venta_territorio FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

-- INSERTS mínimos de prueba
INSERT INTO categorias VALUES (1, 'Notebook', 'Portátiles y laptops');
INSERT INTO categorias VALUES (2, 'Celulares', 'Smartphones y accesorios');
INSERT INTO categorias VALUES (3, 'Tablets', 'Dispositivos móviles intermedios');

INSERT INTO clientes VALUES (1, 'Empresa Alfa', '1111-2222', 'alfa@mail.com', 'Buenos Aires', 'Corporativo', '2024-01-10');
INSERT INTO clientes VALUES (2, 'Cliente Beta', '3333-4444', 'beta@mail.com', 'Córdoba', 'Minorista', '2024-02-05');
INSERT INTO clientes VALUES (3, 'Cliente Gamma', '5555-6666', 'gamma@mail.com', 'Rosario', 'Particular', '2024-03-01');

INSERT INTO territorios VALUES (1, 'Buenos Aires', 'Argentina', 'Litoral');
INSERT INTO territorios VALUES (2, 'Córdoba', 'Argentina', 'Centro');
INSERT INTO territorios VALUES (3, 'Santa Fe', 'Argentina', 'Litoral');

INSERT INTO productos VALUES (1, 'Notebook A', 'MarcaX', 800.00, 1200.00, 1);
INSERT INTO productos VALUES (2, 'Smartphone X', 'MarcaY', 300.00, 600.00, 2);
INSERT INTO productos VALUES (3, 'Tablet Q', 'MarcaZ', 200.00, 400.00, 3);
INSERT INTO productos VALUES (4, 'Laptop Z', 'MarcaX', 900.00, 1500.00, 1);
INSERT INTO productos VALUES (5, 'Celular W', 'MarcaY', 250.00, 500.00, 2);

INSERT INTO ventas VALUES (1,  '2026-03-05', 1, 1, 1, 'Online', 2, 1200.00, 0, 2400.00);
INSERT INTO ventas VALUES (2,  '2026-03-06', 2, 2, 2, 'Tienda', 3, 600.00, 0, 1800.00);
INSERT INTO ventas VALUES (3,  '2026-03-07', 3, 3, 3, 'Online', 1, 400.00, 0, 400.00);
INSERT INTO ventas VALUES (4,  '2026-03-08', 1, 4, 1, 'Distribuidor', 1, 1500.00, 0, 1500.00);
INSERT INTO ventas VALUES (5,  '2026-03-09', 2, 5, 2, 'Tienda', 2, 500.00, 0, 1000.00);
INSERT INTO ventas VALUES (6,  '2026-03-10', 3, 1, 3, 'Online', 1, 1200.00, 0, 1200.00);
INSERT INTO ventas VALUES (7,  '2026-03-11', 1, 2, 1, 'Online', 2, 600.00, 0, 1200.00);
INSERT INTO ventas VALUES (8,  '2026-03-12', 2, 3, 2, 'Tienda', 1, 400.00, 0, 400.00);
INSERT INTO ventas VALUES (9,  '2026-03-13', 3, 4, 3, 'Distribuidor', 1, 1500.00, 0, 1500.00);
INSERT INTO ventas VALUES (10, '2026  -03-14', 1, 5, 1, 'Online', 1, 500.00, 0, 500.00);
