<?php
require_once 'config/database.php';

class Pasantes {
    private $conn;
    private $table = 'pasantes';

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    public function getAll() {
        $query = 'SELECT * FROM ' . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getOne($id) {
        $query = 'SELECT * FROM ' . $this->table . ' WHERE id = ?';
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function create($data) {
        $columns = implode(',', array_keys($data));
        $placeholders = implode(',', array_fill(0, count($data), '?'));
        $query = 'INSERT INTO ' . $this->table . ' (' . $columns . ') VALUES (' . $placeholders . ')';
        $stmt = $this->conn->prepare($query);
        return $stmt->execute(array_values($data));
    }

    public function update($id, $data) {
        $setClause = implode(',', array_map(fn($key) => "$key = ?", array_keys($data)));
        $query = 'UPDATE ' . $this->table . ' SET ' . $setClause . ' WHERE id = ?';
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([...array_values($data), $id]);
    }

    public function delete($id) {
        $query = 'DELETE FROM ' . $this->table . ' WHERE id = ?';
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$id]);
    }
}
?>