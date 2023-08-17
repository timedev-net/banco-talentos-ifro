<?php

namespace App\Modules\Home;

use App\Modules\BaseController;

class HomeController extends BaseController
{
    public function index(): string
    {
        // dd('teste');
        $teste = new HomeModel();
        $teste2 = $teste->getAll();
        d($teste2);
        return view('Home/HomeViews/index');
    }
}
