<!DOCTYPE html>

<html lang="fr">
    <head>
        <meta charset="utf-8">

        <title>{{ $titre_page }}</title>
        <meta name="description" content="{{ $description_page }}">

        <link rel="stylesheet" href="css/style.css">

    </head>

    <body>
        <script src="js/scripts.js"></script>
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>-->

        @yield('content')

    </body>
</html>
