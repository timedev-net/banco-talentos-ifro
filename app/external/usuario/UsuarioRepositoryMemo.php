<?php

namespace App\External\Usuario;

use App\Core\Usuario\IUsuarioModel;
use App\Core\Usuario\Usuario;

class UsuarioRepositoryMemo implements IUsuarioModel
{

    protected $users = [];
    // protected IUsuarioModel $user;

    public function getAllUser(): array
    {
        return $this->users;
    }

    public function getOneUser(int $usuario_id): Usuario {
        return new Usuario($usuario_id, "", "");
    }

    public function createUser($usuario) {
        array_push($this->users, $usuario);
    }

    public function updateUser($usuario) {
        array_push($this->users, $usuario);
    }

    public function deleteUser($usuario_id): void {
        array_push($this->users, $usuario_id);
    }
}
