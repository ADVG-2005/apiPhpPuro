<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header ("Access-Control-Allow-Origin: *");
header ("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE");
header ("Content-Type: application/json; charset=UTF-8");

$request = explode('/',trim($_SERVER["REQUEST_URI"]));
$controller = ucfirst(strtolower($request[2]))."Controller" ?? '';

$method = $_SERVER['REQUEST_METHOD'];
$id = $request[3] ?? null;

$dir = __DIR__."\\Controllers\\".$controller.".php";

if(file_exists($dir)){
    require_once $dir;
    $claseController = new $controller();
    $claseController->handleRequest($method,$id);
}
else{
    die("Not found");
}

?>
