<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "tienda_tick";

$conn = new mysqli($host, $user, $password, $database);

// Stocks cantidad
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT id, stock FROM productos";
    $result = $conn->query($sql);
    $stocks = [];
    
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $stocks[] = [
                "id" => intval($row['id']),
                "stock" => intval($row['stock'])
            ];
        }
        echo json_encode(["status" => "success", "stocks" => $stocks]);
    } else {
        echo json_encode(["status" => "error", "message" => $conn->error]);
    }
    $conn->close();
    exit;
}
// Stocks cantidad

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Fallo de conexión: " . $conn->connect_error]));
}

$inputData = file_get_contents("php://input");
$request = json_decode($inputData, true);

if (!isset($request['productos']) || empty($request['productos'])) {
    echo json_encode(["status" => "error", "message" => "El carrito está vacío."]);
    exit;
}

$conn->begin_transaction();

try {
    foreach ($request['productos'] as $item) {
        $producto_id = intval($item['id']);
        $cantidad = intval($item['cantidad']);

        $stmtCheck = $conn->prepare("SELECT stock, nombre FROM productos WHERE id = ?");
        $stmtCheck->bind_param("i", $producto_id);
        $stmtCheck->execute();
        $result = $stmtCheck->get_result()->fetch_assoc();

        if (!$result) {
            throw new Exception("El producto con ID $producto_id no existe.");
        }

        if ($result['stock'] < $cantidad) {
            throw new Exception("No hay suficiente stock para '" . $result['nombre'] . "'. Disponible: " . $result['stock']);
        }

        $stmtReserva = $conn->prepare("INSERT INTO reservas_pedidos (producto_id, cantidad) VALUES (?, ?)");
        $stmtReserva->bind_param("ii", $producto_id, $cantidad);
        $stmtReserva->execute();

        $stmtStock = $conn->prepare("UPDATE productos SET stock = stock - ? WHERE id = ?");
        $stmtStock->bind_param("ii", $cantidad, $producto_id);
        $stmtStock->execute();
    }

    $conn->commit();
    echo json_encode(["status" => "success", "message" => "Reserva guardada correctamente en la base de datos."]);

} catch (Exception $e) {
    $conn->rollback();
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}

$conn->close();
?>