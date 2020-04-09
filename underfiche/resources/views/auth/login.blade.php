@extends('layouts.app')

@section('content')

<table class="conteneur_connexion_inscription">
    <tr>
        <td> <!-- ZONE DE CONNEXION -->

            <div class="cadre cadre_connexion">
                <h1>Connexion</h1>
                <form action="{{ route('login') }}" method="POST">

                    <div>
                        <input type="email" name="email" placeholder="Email" @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>
                        @error('email')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>

                    <div>
                        <input type="password" name="password" placeholder="Mot de passe" @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">
                        @error('password')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>

                    <div>
                        <input class="form-check-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                        <label class="form-check-label" for="remember">Se souvenir de moi</label>
                    </div>

                    <br>

                    <div>
                        <input type="submit" value="Connexion">
                    </div>
                </form>
            </div>

        </td>
        <td> <!-- ZONE D'INSCRIPTION' -->

            <div class="cadre cadre_inscription">
                <h1>Inscription</h1>
                <p class="texte_inscription">
                    Vous <strong style="color:red">devez</strong> vous inscrire avec l'addresse mail de l'université, un mail de confirmation vous y sera envoyé pour etre sur que vous êtes bien étudiant / prof.
                </p>
                <form action="{{ route('register') }}" method="POST">

                    <div>
                        <input type="email" name="email" placeholder="Email de l'université" @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>
                        @error('email')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>

                    <div>
                        <input type="password" name="password" placeholder="Mot de passe" @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">
                    </div>

                    <div>
                        <input type="password" name="password_confirmation" placeholder="Mot de passe (confirmation)" @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">
                        @error('password')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                    </div>

                    <br>


                    <div>
                        <input type="submit" value="Inscription">
                    </div>
                </form>
            </div>

        </td>
    </tr>
</table>





@endsection
