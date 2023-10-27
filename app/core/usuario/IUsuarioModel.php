<?php 

namespace App\Core\Usuario;

interface IUsuarioModel
{
    public function getAllUser(): array;
    public function getOneUser(int $usuario_id): Usuario;
    public function createUser($usuario);
    public function updateUser($usuario);
    public function deleteUser($usuario_id): void;
}