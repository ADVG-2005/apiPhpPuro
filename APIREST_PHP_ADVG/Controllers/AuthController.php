<?php
require_once __DIR__.'/../Models/Usuarios.php';
require 'vendor/autoload.php'; // Asegúrate de incluir JWT

use Firebase\JWT\JWT;

class AuthController {
    private $model;
    private $secretKey = "miclavesecreta"; // Clave para firmar el JWT

    public function __construct() {
        $this->model = new Usuarios();
    }

    public function handleRequest($method) {
        switch ($method) {
            case 'POST':
                $data = json_decode(file_get_contents('php://input'), true);

                if (!empty($data['identificacion']) && !empty($data['password'])) {
                    $usuario = $this->model->login($data['identificacion'], $data['password']);

                    if ($usuario) {
                        // Generar JWT con datos del usuario
                        $payload = [
                            "sub" => $usuario['identificacion'],
                            "correoElectronico" => $usuario['correoElectronico'],
                            "iat" => time(),
                            "exp" => time() + (60 * 60) // Expira en 1 hora
                        ];

                        $token = JWT::encode($payload, $this->secretKey, 'HS256');

                        // Respuesta exitosa con el token
                        header("HTTP/1.1 200 OK");
                        header("Content-Type: application/json");
                        echo json_encode([
                            "msg" => "Login successful",
                            "token" => $token,
                            "user" => [
                                "id" => $usuario['identificacion'],
                                "correoElectronico" => $usuario['correoElectronico']
                            ]
                        ]);
                    } else {
                        // Credenciales incorrectas
                        header("HTTP/1.1 401 Unauthorized");
                        header("Content-Type: application/json");
                        echo json_encode(["msg" => "Invalid identificacion or password"]);
                    }
                } else {
                    // Datos incompletos
                    header("HTTP/1.1 400 Bad Request");
                    header("Content-Type: application/json");
                    echo json_encode(["msg" => "Missing identificacion or password"]);
                }
                break;

            default:
                header("HTTP/1.1 405 Method Not Allowed");
                echo json_encode(["msg" => "Method not allowed"]);
                break;
        }
    }
}
?>
