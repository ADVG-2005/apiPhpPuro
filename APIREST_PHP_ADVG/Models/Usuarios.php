<?php
require_once 'config/database.php';

class Usuarios {
    private $conn;
    private $table = 'usuarios';

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Obtener todos los usuarios
    public function getAll() {
        $query = 'SELECT * FROM ' . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Obtener un usuario por identificación
    public function getOne($identificacion) {
        $query = 'SELECT * FROM ' . $this->table . ' WHERE identificacion = ?';
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$identificacion]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Crear un nuevo usuario
    public function create($data) {
        $query = 'INSERT INTO ' . $this->table . ' (identificacion, nombre, apellidos, fechaNacimiento, telefono, correoElectronico, passwordHash, admin) 
                  VALUES (:identificacion, :nombre, :apellidos, :fechaNacimiento, :telefono, :correoElectronico, :passwordHash, :admin)';
        
        $stmt = $this->conn->prepare($query);

        // Hashear la contraseña antes de guardarla
        $passwordHash = password_hash($data['password'], PASSWORD_DEFAULT);

        return $stmt->execute([
            ':identificacion' => $data['identificacion'],
            ':nombre' => $data['nombre'],
            ':apellidos' => $data['apellidos'],
            ':fechaNacimiento' => $data['fechaNacimiento'],
            ':telefono' => $data['telefono'],
            ':correoElectronico' => $data['correoElectronico'],
            ':passwordHash' => $passwordHash,
            ':admin' => $data['admin']
        ]);
    }

    // Actualizar un usuario
    public function update($identificacion, $data) {
        $setClause = [];
        $params = [];

        foreach ($data as $key => $value) {
            if ($key === "password") {
                $value = password_hash($value, PASSWORD_DEFAULT);
                $setClause[] = "passwordHash = :passwordHash";
                $params[":passwordHash"] = $value;
            } else {
                $setClause[] = "$key = :$key";
                $params[":$key"] = $value;
            }
        }

        $params[":identificacion"] = $identificacion;
        $query = 'UPDATE ' . $this->table . ' SET ' . implode(', ', $setClause) . ' WHERE identificacion = :identificacion';
        $stmt = $this->conn->prepare($query);
        return $stmt->execute($params);
    }

    // Eliminar un usuario
    public function delete($identificacion) {
        $query = 'DELETE FROM ' . $this->table . ' WHERE identificacion = ?';
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$identificacion]);
    }

    public function login($identificacion, $password) {
        $query = 'SELECT * FROM ' . $this->table . ' WHERE identificacion = :identificacion';
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':identificacion', $identificacion, PDO::PARAM_INT);
        $stmt->execute();

        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);

        // Verificar si el usuario existe y si la contraseña es correcta
        if ($usuario && password_verify($password, $usuario['passwordHash'])) {
            return $usuario; // Retornar los datos del usuario
        } else {
            return false; // Credenciales incorrectas
        }
    }
    
}
?>
