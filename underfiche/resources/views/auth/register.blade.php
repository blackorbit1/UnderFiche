@extends('layouts.app')

@section('content')

    <link rel="stylesheet" href="css/filepond.css">
    <div class="conteneur_connexion_inscription">
        <div class="cadre cadre_inscription">
            <h1>Finalisation</h1>



            <form action="{{ route('register') }}" method="POST">
                <table>
                    <tr>
                        <td class="conteneur_parties_inscription" valign="top"> <!-- ZONE DES INFORMATIONS IMPORTANTES -->
                            <p class="texte_inscription">
                                <strong style="color:red">Informations importantes pour la gestion du site</strong>
                            </p>
                            <div>
                                <input type="text" name="discord" placeholder="pseudodiscord#1234" required autofocus>
                                @error('discord')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>


                            <div>
                                <label for="niveau">Niveau:</label>
                                <select id="niveau">
                                    <option value="L1">L1</option>
                                    <option value="L2">L2</option>
                                    <option value="L3">L3</option>
                                    <option value="M1">M1</option>
                                    <option value="M2">M2</option>
                                    <option value="Doctorant">Doctorant</option>
                                    <option value="Professeur">Professeur</option>
                                    <option value="Administration">Administration</option>
                                </select>
                            </div>


                        </td>
                        <td class="conteneur_parties_inscription" valign="top"> <!-- ZONE DES INFOS MOINS IMPORTANTES -->
                            <p class="texte_inscription">
                                Informations moins importantes
                            </p>
                            <div>
                                <input id="profile_picture" type="file" class="filepond" name="filepond" accept="image/png, image/jpeg, image/gif"/>
                            </div>

                            <div>
                                <input type="number" name="id_etu" placeholder="ID étudiant">
                            </div>

                            <div>
                                <input type="email" name="mail_contact" placeholder="Email de contact">
                            </div>


                        </td>
                    </tr>
                </table>






                <div>
                    <input type="submit" value="Inscription">
                </div>
            </form>
        </div>
    </div>


    <!-- file upload itself is disabled in this pen -->
    <script src="js/filepond.js"></script>
    <script id="rendered-js" >
    /*
    We need to register the required plugins to do image manipulation and previewing.
    */
    FilePond.registerPlugin(
        // encodes the file as base64 data
        FilePondPluginFileEncode,
        // validates files based on input type
        FilePondPluginFileValidateType,
        // corrects mobile image orientation
        FilePondPluginImageExifOrientation,
        // previews the image
        FilePondPluginImagePreview,
        // crops the image to a certain aspect ratio
        FilePondPluginImageCrop,
        // resizes the image to fit a certain size
        FilePondPluginImageResize,
        // applies crop and resize information on the client
        FilePondPluginImageTransform
    );


    // Select the file input and use create() to turn it into a pond
    // in this example we pass properties along with the create method
    // we could have also put these on the file input element itself
    FilePond.create(
    document.querySelector('#profile_picture'), {
        labelIdle: `Glisser / déposer mon image ou <span class="filepond--label-action">importer</span>`,
        imagePreviewHeight: 170,
        imageCropAspectRatio: '1:1',
        imageResizeTargetWidth: 200,
        imageResizeTargetHeight: 200,
        stylePanelLayout: 'compact circle',
        styleLoadIndicatorPosition: 'center bottom',
        styleButtonRemoveItemPosition: 'center bottom'
    });

    </script>







@endsection
