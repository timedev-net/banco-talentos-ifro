<?php

namespace App\Core\Usuario;

class Usuario {

    protected $id;
    protected $username;
    protected $senha;

    public function __construct(int $id, string $username, string $senha) {
        $this->id = $id;
        $this->username = $username;
        $this->senha = $senha;
    }
}