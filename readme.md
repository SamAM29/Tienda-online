# Tienda Online Tick! 🛒

Una aplicación web Full-Stack de e-commerce diseñada para gestionar un catálogo de productos, un carrito de compras dinámico y un sistema de reservas conectado directamente a WhatsApp.

## 🚀 Características Principales

* **Catálogo Dinámico:** Visualización de productos con botón de "Cargar más".
* **Carrito de Compras:** Agrega, elimina y calcula el total de los productos en tiempo real.
* **Inventario en Tiempo Real:** El stock de los productos se lee directamente desde la base de datos y se actualiza al instante en la interfaz al agregar items al carrito.
* **Checkout por WhatsApp:** Al finalizar la compra, el sistema genera un mensaje automático con los detalles del pedido y redirige al usuario a WhatsApp.
* **Gestión de Base de Datos:** Validación de stock en el servidor (Backend) para evitar compras de productos agotados, guardando un registro de cada reserva.

## 💻 Tecnologías Utilizadas

* **Frontend:** HTML5, CSS3, JavaScript (Vanilla).
* **Backend:** PHP.
* **Base de Datos:** MySQL.
* **Entorno Local:** XAMPP (Apache & MySQL).

## ⚙️ Instalación y Uso (Entorno Local)

Para correr este proyecto en tu computadora, sigue estos pasos:

1.  Descarga e instala [XAMPP](https://www.apachefriends.org/es/download.html) versión 8.1.25.
2.  Clona o descarga este repositorio y coloca la carpeta del proyecto dentro de la ruta `C:\xampp\htdocs\` (en Windows).
3.  Abre el Panel de Control de XAMPP y enciende los módulos **Apache** y **MySQL**.
4.  Abre tu navegador y ve a `http://localhost/phpmyadmin/`.
5.  Importa el archivo `database.sql` incluido en este proyecto para crear las tablas y los productos iniciales.(Se creara una base datos llamada tienda_tick).
6.  Abre una nueva pestaña en el navegador y escribe la siguiente ruta: `http://localhost/Pagina%20Web/Index.html.`.
7. **¡Importante para las reservas!** Para que el sistema cancele las compras no pagadas y devuelva el stock automáticamente después de 2 horas, debes activar el programador de eventos de MySQL. Ve a la pestaña **SQL** en phpMyAdmin y ejecuta este comando:`SET GLOBAL event_scheduler = ON;`, Luego ejecuta el siguiente codigo:

`DELIMITER $$

    DROP EVENT IF EXISTS restaurar_stock_expirado$$

    CREATE EVENT restaurar_stock_expirado
    ON SCHEDULE EVERY 1 MINUTE
    DO
    BEGIN
    UPDATE productos p
    JOIN reservas_pedidos r ON p.id = r.producto_id
    SET p.stock = p.stock + r.cantidad
    WHERE r.fecha_reserva < NOW() - INTERVAL 2 HOUR;
    
    DELETE FROM reservas_pedidos 
    WHERE fecha_reserva < NOW() - INTERVAL 2 HOUR;

END$$

DELIMITER ;`


## 📂 Estructura del Proyecto

* `Index.html` - Estructura principal de la tienda y el carrito.
* `styles.css` - Estilos visuales y diseño responsive.
* `script.js` - Lógica del Frontend (carrito, stocks visuales, checkout).
* `guardar_reserva.php` - Lógica del Backend (conexión a BD, validación de inventario y registro de pedidos).
* `database.sql` - Script de creación y poblado de la base de datos.