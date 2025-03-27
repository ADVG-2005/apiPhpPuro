<?php

require_once 'models/HumedadTerreno.php';

class HumedadTerrenoController {
    private $model;

    public function __construct() {
        $this->model = new HumedadTerreno();
    }

    public function handleRequest($method, $id = null) {
        switch ($method) {
            case 'GET':
                echo json_encode($id ? $this->model->getOne($id) : $this->model->getAll());
                break;
            case 'POST':
                $data = json_decode(file_get_contents('php://input'), true);
                echo json_encode($this->model->create($data));
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