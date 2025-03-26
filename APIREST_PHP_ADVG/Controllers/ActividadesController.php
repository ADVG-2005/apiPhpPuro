<?php

require_once __DIR__.'/../Models/Actividades.php';

class ActividadesController {
    private $model;

    public function __construct() {
        $this->model = new Actividades();
    }

    public function handleRequest($method, $id = null) {
        switch ($method) {
            case 'GET':
                echo json_encode($id ? $this->model->getOne($id) : $this->model->getAll());
                break;
            case 'POST':
                $data = json_decode(file_get_contents('php://input'), true);
        
                if (!empty($data)) {
                     $result = $this->model->create($data);
        
                    header("HTTP/1.1 201 Created"); // Código 201 para indicar creación exitosa
                    header("Content-Type: application/json");
                    echo json_encode([
                        "msg" => "Created successfully",
                    ]);
                } else {
                    header("HTTP/1.1 400 Bad Request");
                    header("Content-Type: application/json");
                    echo json_encode(["msg" => "Invalid data"]);
                }
            break;
            case 'PUT':
                $data = json_decode(file_get_contents('php://input'), true);
                echo json_encode($this->model->update($id, $data));
                break;
            case 'PATCH':
                $data = json_decode(file_get_contents('php://input'), true);
                echo json_encode($this->model->update($id, $data));
                break;
            case 'DELETE':
                echo json_encode($this->model->delete($id));
                break;
            default:
                echo json_encode(["message" => "Método no permitido"]);
                break;
        }
    }
}

?>