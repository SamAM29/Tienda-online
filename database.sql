Create database if not exists tienda_tick;
USE tienda_tick;

Create table if not exists productos (
    id int AUTO_INCREMENT primary key,
    nombre Varchar(100) not null,
    precio int not null,
    stock int not null,
    descripción text
);

insert into productos (nombre, precio, stock, descripción) values
('Camiseta Arena esencial', 35000, 30, 'Camisa sencilla de cuello redondo de color beige arena'),
('Camisa Ébano Versátil', 50000, 25, 'Camisa básica de cuello redondo con camisa de manga corta con botones y cuello sport, colores negro y blanco'),
('Camisa Resort Grafito', 65000, 25, 'Camisa manga corta con cuello camp de colores blanco y gris oscuro'),
('Gorra Blanco Esencial', 25000, 10, 'Gorra blanca tipo béisbol lisa'),
('Gorra Ónix Atemporal', 25000, 12, 'Gorra negra tipo béisbol lisa'),
('Vino Chic Set', 175000, 14, 'Conjunto de blusa satinada vino manga larga y pantalón palazzo negro tiro alto con bolso bandolera negro con cadena dorada'),
('Brown Aesthetic Set', 135000, 12, 'Conjunto de camisa oversize a rayas café, con un top corto negro y Pantalón wide leg negro'),
('Set Casual Día', 160000, 16, 'Conjunto de camiseta crop fruncida blanca y jean wide leg azul oscuro con camisa oversize a rayas azul/blanco'),
('Fresh White & Blue', 160000, 18, 'Conjunto de camisa oversize rayado, top corto y pantalón palazzo, colores blanco y azul'),
('Chocolate Elegance', 200000, 20, 'Conjunto de blazer/chaqueta oversize, Top crop sin mangas, pantalón palazzo y Stilettos nude charol de colores de Chpcolate/marrón, crema/marfil y beige'),
('Vintage Champagne', 95000, 40, 'Vestido midi color champagne/beige claro estilo vintage/retro'),
('White Fairy Dream', 115000, 38, 'Vestido midi blanco off-shoulder con volantes'),
('Rouge Vintage', 95000, 40, 'Vestido midi color vino/borgoña estilo vintage/retro'),
('Rose Lace Dream', 95000, 35, 'Vestido de fiesta hi-low con encaje color rosa palo/blush'),
('Converse Chuck Taylor All Star High Top', 220000, 20, 'Converse Chuck Taylor All Star High Top de color negro y blanco'),
('Chain Platform Hi', 100000, 30, 'Tenis bota con plataforma chunky de color negro con blanco'),
('Adidas Superstar Originalsi', 280000, 32, 'Adidas Superstar Originalsi de color blanco con rayas negras'),
('White Grey Classic Low', 80000, 32, 'Tenis casuales bajos sin marca de color blanco con gris'),
('Classic Black Notebook', 70000, 20, 'Libreta/cuaderno tipo Moleskine de color negro'),
('Blue Spiral Classic', 20000, 20, 'Cuaderno argollado/espiral azul marino'),
('Pink Bow Journal', 20000, 15, 'Cuaderno argollado estético Coquette y bolígrafo aesthetic.');

Create table if not exists reservas_perdidos (
    id int AUTO_INCREMENT primary key,
    producto_id int,
    cantidad int not null,
    fecha_reserva datetime default current_timestamp,
    estado varchar(20) default 'reservado'
    foreign key (producto_id) references producto(id)
)