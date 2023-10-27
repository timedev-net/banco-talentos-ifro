<?php

namespace App\External\Usuario;

// use App\Modules\BaseController;

use App\Core\Usuario\IUsuarioModel;
use App\Core\Usuario\Usuario;
use CodeIgniter\Model;

class UsuarioRepository extends Model implements IUsuarioModel
{

    protected $table = 'public.migrations';
    // protected IUsuarioModel $user;

    public function __construct() {
        parent::__construct();
        $this->db = db_connect();
    }

    public function getAllUser(): array
    {
        // $db = db_connect();
        
        
        // $this->db->from($table);
        $query = $this->db->query('select 1');
        // $query = $this->db->get();
        // $query2 = $query->result();

        // dd($query);

        return ["Aqui é a model"];
    }

    
    public function getOneUser(int $usuario_id): Usuario {
        $query = $this->db->query('select 1');
        // $query = $this->db->get();
        // $query2 = $query->result();
        // dd($query);

        return new Usuario($usuario_id, "", "");
    }

    public function createUser($usuario) {
        $this->db->query('select 1');
    }

    public function updateUser($usuario) {
        $this->db->query('select 1');
    }

    public function deleteUser($usuario_id): void {
        $this->db->query('select 1');
    }
}
