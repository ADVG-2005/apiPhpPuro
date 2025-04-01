<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE");
header("Content-Type: application/json; charset=UTF-8");

require 'vendor/autoload.php'; 
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

$secretKey = "miclavesecreta";

$request = explode('/', trim($_SERVER["REQUEST_URI"]));
$controller = ucfirst(strtolower($request[1])) . "Controller" ?? ''; //definir la posicion que llevara el endpoint en la uri 
$method = $_SERVER['REQUEST_METHOD'];
$id = $request[2] ?? null; // definir la posicion que llevara el id en la uri 

if ($request[1] == "authController") {
    require 'Controllers/authController.php';
    exit;
}
if ($request[1] == "usuariosController"){
    require 'Controller/usuariosController.php';
    exit;
}

$dir = __DIR__ . "/Controllers/" . $controller . ".php";

if (file_exists($dir)) {

    // Excluir authController  de la protección con JWT
    if (
        !($controller === "AuthController") &&
    // Excluir metodo POST dentro de usuariosController para realizar un registro y poder realizar el inicio de sesion 
        !($controller === "UsuariosController" && $method === "POST")
    ) {
        $headers = getallheaders();
        if (!isset($headers['Authorization'])) {
            http_response_code(401);
            echo json_encode(["error" => "No token provided"]);
            exit;
        }
    
        $token = str_replace('Bearer ', '', $headers['Authorization']);
    
        try {
            $decoded = JWT::decode($token, new Key($secretKey, 'HS256'));
            $_SESSION['user'] = $decoded;
        } catch (Exception $e) {
            http_response_code(401);
            echo json_encode(["error" => "Invalid token"]);
            exit;
        }
    }
    

    require_once $dir;
    $claseController = new $controller();
    $claseController->handleRequest($method, $id);
} else {
    http_response_code(404);
    echo json_encode(["error" => "Not found"]);
}
