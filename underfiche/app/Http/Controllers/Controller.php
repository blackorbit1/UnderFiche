<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class Controller extends BaseController
{
    // Ajout de cette variable afin que tous les controlleurs puisse acceder à leur header respectif facilement
    public $header = [
        "connexion" => ["titre_page" => "Connexion", "description_page" => "Ceci est la page de connexion"]
    ];



    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
}
