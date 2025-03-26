<?php

require_once 'models/Desechos.php';

class DesechosController {
    private $model;

    public function __construct() {
        $this->model = new Desechos();
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