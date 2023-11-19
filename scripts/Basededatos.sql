
CREATE DATABASE IF NOT EXISTS adw_proyecto;
 use adw_proyecto;
-- Crear tabla DIM_PRODUCTO
 CREATE TABLE DIM_PRODUCTO (
    producto_id INT (50) NOT NULL UNIQUE,
    nombre VARCHAR(255) ,
    numero_producto VARCHAR(50) ,
    descripcion TEXT ,
    peso INT(10),
    sub_category VARCHAR(255) ,
    category VARCHAR(255) 
);

-- Crear tabla DIM_FECHA
CREATE TABLE DIM_FECHA (
    fecha DATE NOT NULL UNIQUE,
    dia INT(2) ,
    mes INT(2) ,
    ano INT(2) ,
    dias_semana VARCHAR(255)
);

-- Crear tabla DIM_CLIENTE
CREATE TABLE DIM_CLIENTE (
    cliente_id INT(50) NOT NULL UNIQUE,
    nombre VARCHAR(255) ,
    direccion TEXT ,
    cedula VARCHAR(50) UNIQUE,
    ciudad VARCHAR(255) ,
    pais VARCHAR(255) NOT NULL,
    continente VARCHAR(255) NOT NULL,
    rango_de_edad VARCHAR(50) ,
    genero VARCHAR(50) ,
    ocupacion VARCHAR(255) 
);

-- Crear tabla DIM_TIENDA
CREATE TABLE DIM_TIENDA (
    tienda_id INT(50) NOT NULL UNIQUE,
    nombre VARCHAR(255),
    direccion TEXT ,
    barrio VARCHAR(255) ,
    ciudad VARCHAR(255) ,
    pais VARCHAR(255) NOT NULL,
    continente VARCHAR(255) NOT NULL,
    tamano INT(10) ,
    rango_empleados VARCHAR(255) 
);

-- Crear tabla FACT_VENTAS
CREATE TABLE FACT_VENTAS (
    ventas_id INT(50) NOT NULL,
    detalle_venta_id int NOT null,
    valor INT(50) NOT NULL,
    costo INT(50) ,
    descuento INT(50) ,
    tasa_de_retorno NUMERIC(50), 
    dias_entrega INT(10), 
    producto_id INT(100) NOT NULL,
    fecha DATE NOT NULL,
    tienda_id INT(100) NOT NULL,
    cliente_id INT(100) NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES DIM_PRODUCTO(producto_id),
    FOREIGN KEY (fecha) REFERENCES DIM_FECHA(fecha),
    FOREIGN KEY (tienda_id) REFERENCES DIM_TIENDA(tienda_id),
    FOREIGN KEY (cliente_id) REFERENCES DIM_CLIENTE(cliente_id)
);
