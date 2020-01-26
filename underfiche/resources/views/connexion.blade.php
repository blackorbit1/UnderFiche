@extends('base')


@section('page')


    <div class="cadre cadre_connexion">
        <h1>Connexion</h1>
        <form action="" method="get">
            <div>
                <input type="text" name="pseudo" placeholder="Identifiant" required>
            </div>

            <div>
                <input type="password" name="password" placeholder="Mot de passe" required>
            </div>

            <div>
                <input type="submit" value="Connexion">
            </div>
        </form>
    </div>


@endsection
