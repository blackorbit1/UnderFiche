<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ConnexionController extends Controller
{
    public function getConnexionPage(){
        return view("connexion")->with($this->header["connexion"]);
    }
}
