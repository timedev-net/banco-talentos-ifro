<?php

namespace App\Core\Usuario;
use App\Core\Usuario\IUsuarioModel;

class UsuarioService {

    protected $model;

    public function __construct(IUsuarioModel $model) {
        $this->model = $model;
    }

    public function buscaTodosUsuarios() {
        return $this->model->getAllUser();
    }
}