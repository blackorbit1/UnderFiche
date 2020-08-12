-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 26, 2020 at 11:45 PM
-- Server version: 5.6.34-log
-- PHP Version: 7.1.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `underfiche`
--

-- --------------------------------------------------------

--
-- Table structure for table `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1 = matiere / 2 = catégorie bibliotheque / 3 = scolarite / 4 = informations generales',
  `discord_id_serveur` int(11) NOT NULL,
  `discord_nom_id_room` varchar(250) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'forme : "s1_algav 5645478874"',
  `date_ajout` datetime NOT NULL,
  `date_modification` datetime DEFAULT NULL,
  `date_suppression` datetime DEFAULT NULL,
  `id_ajouteur` int(11) NOT NULL,
  `id_modifieur` int(11) DEFAULT NULL,
  `id_personnages` int(11) NOT NULL COMMENT 'personnes pouvant modifier la categorie. Forme : "254 32 58884" pour 3 personnes',
  `nom_court` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'pour la bande de gauche',
  `nom_long` varchar(250) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'pour la page de la categorie',
  `code` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'ex : MLK5U1O',
  `semestre` tinyint(11) NOT NULL,
  `supprime` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = oui',
  `texte_replie` text COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'texte dont seules les 3 premieres lignes sont affichées',
  `texte_deplie` text COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'texte affiché dans sa totalité',
  `affichage_texte_replie` tinyint(1) NOT NULL DEFAULT '0',
  `affichage_texte_deplie` tinyint(1) NOT NULL DEFAULT '0',
  `nb_vues` int(11) NOT NULL DEFAULT '0',
  `lien` text COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'lien moodle / lien site prof',
  `affichage_lien` tinyint(1) NOT NULL COMMENT '1 = oui'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cat_niv`
--

CREATE TABLE `cat_niv` (
  `id` int(11) NOT NULL,
  `id_categorie` int(11) NOT NULL,
  `id_niveau` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci COMMENT='association n n categorie/niveau';

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `id` int(11) NOT NULL,
  `nom` int(11) NOT NULL,
  `date_creation` datetime NOT NULL,
  `date_modification` datetime DEFAULT NULL,
  `date_suppression` datetime DEFAULT NULL,
  `id_ajouteur` int(11) NOT NULL COMMENT 'id de l''user l''ayant ajouté',
  `id_proprietaire` int(11) NOT NULL COMMENT 'id du proprietaire du document',
  `commentaire_admin` text COLLATE utf8_general_mysql500_ci,
  `langue` varchar(5) COLLATE utf8_general_mysql500_ci NOT NULL DEFAULT 'fr',
  `type` int(11) NOT NULL COMMENT 'td / tp / fiche / cours / annexe / correction pur / logiciel / informations / tuto / exemple travail / autre',
  `corrige` tinyint(1) NOT NULL,
  `visibilite` smallint(6) NOT NULL DEFAULT '1' COMMENT '1 = visible / 2 = retrait prof / 3 = affichage periodique / 4 = non validé / 5 = supprime',
  `informations` text COLLATE utf8_general_mysql500_ci NOT NULL,
  `informations_active` tinyint(1) NOT NULL DEFAULT '0',
  `mots_cles` text COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'recherche via LIKE, forme : "keyword1 keyword2" insensible à la casse',
  `aperçu` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'url image (thumbnail)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci COMMENT='Les (fichiers / matiere) sont séparés des documents';

-- --------------------------------------------------------

--
-- Table structure for table `doc_cat`
--

CREATE TABLE `doc_cat` (
  `id` int(11) NOT NULL,
  `id_document` int(11) NOT NULL,
  `id_categorie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci COMMENT='association n n document/categorie';

-- --------------------------------------------------------

--
-- Table structure for table `fichier`
--

CREATE TABLE `fichier` (
  `id` int(11) NOT NULL,
  `id_document` int(11) NOT NULL COMMENT 'attribut critique',
  `nom` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'ex : TD 11 correction',
  `lien_fichier` int(100) NOT NULL COMMENT 'ex : [http://site.fr/]?files/6f5e6r5fer.pdf',
  `ancien_nom_fichier` varchar(250) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'ex : td_11_cor_2020.pdf',
  `extension_fichier` varchar(10) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'ex : pdf',
  `date_ajout` datetime NOT NULL,
  `date_modification` datetime DEFAULT NULL,
  `date_suppression` datetime DEFAULT NULL,
  `visibilite` int(11) NOT NULL COMMENT '1 = visible / 2 = retrait prof / 3 = affichage periodique / 4 = non validé / 5 = supprime',
  `id_ajouteur` int(11) NOT NULL,
  `id_proprietaire` int(11) NOT NULL,
  `nb_vues` int(11) NOT NULL DEFAULT '0',
  `commentaire_admin` text COLLATE utf8_general_mysql500_ci NOT NULL,
  `ip_ajouteur` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL,
  `externe` tinyint(1) NOT NULL COMMENT '1 si stocké sur un site externe',
  `contenu` text COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'tout le texte contenu dans le fichier --> Pour la fonction de recherche'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1 = administration / 2 = moderation / 3 = erreurs graves / 4 = erreurs mineurs / 5 = activité autre',
  `date` datetime NOT NULL,
  `IP` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL,
  `navigateur` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL,
  `id_user` int(11) NOT NULL COMMENT '0 = non connecte',
  `action` text COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'requete sql permettant l''annulation de l''action',
  `type_element_concerne` int(11) NOT NULL COMMENT '1 = user / 2 = niveau / 3 = categorie / 4 = document / 5 = fichier / 6 = publication',
  `id_element_concerne` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1 = message discord categorie / 2 = commentaire publication / 3 ? = commentaire categorie',
  `id_entite_associee` int(11) NOT NULL COMMENT 'critique',
  `id_auteur` int(11) NOT NULL,
  `date_ajout` datetime NOT NULL,
  `date_modification` datetime DEFAULT NULL,
  `date_suppression` datetime DEFAULT NULL,
  `id_interfereur` int(11) DEFAULT NULL COMMENT 'derniere personne ayant modifie / supprime le msg',
  `visibilite` int(11) NOT NULL COMMENT '1 = visible / 2 = retrait prof / 3 = caché / 4 = supprime',
  `en_reponse_a` int(11) DEFAULT NULL COMMENT 'id d''un message',
  `contenu` text COLLATE utf8_general_mysql500_ci NOT NULL,
  `contenu_original` text COLLATE utf8_general_mysql500_ci NOT NULL,
  `signale` tinyint(1) NOT NULL,
  `id_signaleur` int(11) NOT NULL DEFAULT '0' COMMENT 'si + de 0 ET signale = 0, permet de voir quels fichiers avaient été signalés et par qui'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `niveau`
--

CREATE TABLE `niveau` (
  `id` int(11) NOT NULL,
  `nom_court` varchar(20) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'ex : L2 INFO / M1 DAC',
  `nom_level` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'ex : Licence pro / Master',
  `nom_specialite` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'ex : Informatique / STL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publication`
--

CREATE TABLE `publication` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1 = news générale / 2 = news univ / 3 = news niveau / 4 = news categorie / 5 = avis recherche',
  `id_entite_associe` int(11) NOT NULL COMMENT 'si 1 : 0 / si 2 : id unniv / si 3 : id niveau / si 4 : id catégorie / si 5 : id catégorie',
  `importance` int(11) NOT NULL COMMENT '1 = urgent / 2 = attention / 3 = normal / 4 = obsolète',
  `date_ajout` datetime NOT NULL,
  `date_modification` datetime DEFAULT NULL,
  `date_suppression` datetime DEFAULT NULL,
  `visibilite` int(11) NOT NULL COMMENT '1 = visible / 2 = retrait prof / 3 = affichage periodique / 4 = caché / 5 = supprime',
  `debut_periodicite` int(11) DEFAULT NULL COMMENT 'timestamp en sec',
  `duree_periodicite` int(11) DEFAULT NULL COMMENT 'en sec',
  `intervale_periodicite` int(11) DEFAULT NULL COMMENT 'en sec',
  `id_ajouteur` int(11) NOT NULL,
  `id_modifieur` int(11) DEFAULT NULL,
  `id_proprietaire` int(11) NOT NULL COMMENT 'ex : transmission d''une annonce de la scolarité',
  `titre` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL,
  `contenu` text COLLATE utf8_general_mysql500_ci NOT NULL,
  `contenu_precedent` text COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'pour permettre l''annulation d''une modification',
  `lien` int(11) NOT NULL COMMENT 'si transmission d''un contenu en ligne',
  `afficher_lien` tinyint(1) NOT NULL DEFAULT '0',
  `commentable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'ex: redif rss d''un post FB -> il faut aller sur le vrai post pour commenter'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `serveur_discord`
--

CREATE TABLE `serveur_discord` (
  `id` int(11) NOT NULL,
  `nom_court` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL,
  `nom_long` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL,
  `external_id` varchar(250) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'id reconnue par discord'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `universite`
--

CREATE TABLE `universite` (
  `id` int(11) NOT NULL,
  `nom_court` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL,
  `nom_long` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL,
  `lien` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'lien vers le site de l''université',
  `logo` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL COMMENT 'lien vers le logo',
  `informations` text COLLATE utf8_general_mysql500_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `date_creation` datetime NOT NULL,
  `discord_id` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL,
  `discord_pseudo` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL,
  `pseudo` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL,
  `discord_etat` int(11) NOT NULL,
  `mail` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL,
  `description` text COLLATE utf8_general_mysql500_ci,
  `avatar` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL DEFAULT 'default' COMMENT 'default = l avatar par defaut',
  `id_etu` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL,
  `droit` int(11) NOT NULL DEFAULT '5' COMMENT '1 = super admin / 2 = admin / 3 = modo / 4 = prof / 5 = user',
  `nb_connexion` int(11) NOT NULL DEFAULT '0',
  `derniere_connexion` datetime NOT NULL,
  `niveau` int(11) NOT NULL DEFAULT '1' COMMENT '1 = inconnu',
  `supprime` tinyint(1) NOT NULL DEFAULT '0',
  `mail_contact` varchar(200) COLLATE utf8_general_mysql500_ci DEFAULT NULL COMMENT 'si un prof veut montrer son mail de contact',
  `github` varchar(255) COLLATE utf8_general_mysql500_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8_general_mysql500_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cat_niv`
--
ALTER TABLE `cat_niv`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doc_cat`
--
ALTER TABLE `doc_cat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fichier`
--
ALTER TABLE `fichier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `niveau`
--
ALTER TABLE `niveau`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `publication`
--
ALTER TABLE `publication`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `serveur_discord`
--
ALTER TABLE `serveur_discord`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `universite`
--
ALTER TABLE `universite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cat_niv`
--
ALTER TABLE `cat_niv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `doc_cat`
--
ALTER TABLE `doc_cat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `fichier`
--
ALTER TABLE `fichier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `niveau`
--
ALTER TABLE `niveau`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `publication`
--
ALTER TABLE `publication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `serveur_discord`
--
ALTER TABLE `serveur_discord`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `universite`
--
ALTER TABLE `universite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
