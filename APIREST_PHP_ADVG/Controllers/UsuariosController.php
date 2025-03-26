<?php
require_once __DIR__.'/../Models/Usuarios.php';

class UsuariosController {
    private $model;

    public function __construct() {
        $this->model = new Usuarios();
    }

    public function handleRequest($method, $id = null) {
        switch ($method) {
            case 'GET':
                if ($id) {
                    $usuario = $this->model->getOne($id);
                    echo json_encode($usuario ?: ["msg" => "User not found"]);
                } else {
                    echo json_encode($this->model->getAll());
                }
                break;

            case 'POST':
                $data = json_decode(file_get_contents('php://input'), true);
                if ($this->isValidData($data, true)) {
                    $result = $this->model->create($data);
                    echo json_encode(["msg" => $result ? "User created successfully" : "Failed to create user"]);
                } else {
                    echo json_encode(["msg" => "Invalid data"]);
                }
                break;

            case 'PUT':
                if (!$id) {
                    echo json_encode(["msg" => "Missing user ID"]);
                    break;
                }

                $data = json_decode(file_get_contents('php://input'), true);
                if ($this->isValidData($data)) {
                    $result = $this->model->update($id, $data);
                    echo json_encode(["msg" => $result ? "User updated successfully" : "Failed to update user"]);
                } else {
                    echo json_encode(["msg" => "Invalid data"]);
                }
                break;

            case 'DELETE':
                if (!$id) {
                    echo json_encode(["msg" => "Missing user ID"]);
                    break;
                }
                $result = $this->model->delete($id);
                echo json_encode(["msg" => $result ? "User deleted successfully" : "Failed to delete user"]);
                break;

            default:
                echo json_encode(["msg" => "Method not allowed"]);
                break;
        }
    }

    // Validación básica de datos
    private function isValidData($data, $isNew = false) {
        $requiredFields = ["nombre", "apellidos", "fechaNacimiento", "telefono", "correoElectronico", "admin"];
        if ($isNew) {
            $requiredFields[] = "identificacion";
            $requiredFields[] = "password";
        }
        
        foreach ($requiredFields as $field) {
            if (!isset($data[$field])) {
                return false;
            }
        }
        return true;
    }
}
?>
