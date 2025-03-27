<?php

require_once 'Models/Especie.php';

class EspecieController {
    private $especie;

    public function __construct() {
        $this->especie = new Especie();
    }

    public function handleRequest($method, $id) {
        switch ($method) {
            case 'GET':
                echo json_encode($id ? $this->especie->getOne($id) : $this->especie->getAll());
                break;
            case 'POST':
                $data = json_decode(file_get_contents("php://input"), true);
                echo json_encode($this->especie->create($data));
                break;
            case 'PUT':
                $data = json_decode(file_get_contents("php://input"), true);
                echo json_encode($this->especie->update($id, $data));
                break;
            case 'PATCH':
                $data = json_decode(file_get_contents("php://input"), true);
                echo json_encode($this->especie->update($id, $data));
                break;
            case 'DELETE':
                echo json_encode($this->especie->delete($id));
                break;
            default:
                echo json_encode(["message" => "Método no permitido"]);
                break;
        }
    }
}