<?php
session_start();
define('USER','root');
define('MDP', 'd072812198788lv');
define('DSN', 'mysql:host=localhost;dbname=gestage');

function connecter() {
    try {
        $connexion = new PDO(DSN, USER, MDP);
//        $sql ="SET NAMES latin1_german1_ci";
        $sql ="SET NAMES utf8";
        $stmt = $connexion->query($sql);
        //echo "connexion réussie";
    } catch (PDOException $e) {
        echo "Erreur ! : " . $e->getMessage() . "<br />";
        $connexion = null;
    }
    return $connexion;
}

function typeUtilisateur($conn, $login){  
    $role= "SELECT ROLE FROM UTILISATEUR WHERE LOGIN='".$login."'";
    $stmt = $conn->query($role);
    $row= $stmt->fetch();
    if ($row['ROLE']){
        $_SESSION['role']=$row['ROLE'];
    }
    return $stmt->fetchAll(PDO::FETCH_ASSOC); 
}

function connexion($conn, $login, $mdp){
    $sql= "SELECT COUNT(*) nbRes FROM UTILISATEUR WHERE LOGIN='".$login."' AND MOT_DE_PASSE='".$mdp."'";
    $stmt = $conn->query($sql);
    $row= $stmt->fetch();
    if ($row['nbRes'] == 1){
        $_SESSION['login']=$login;
        header('Location: index.php?action=accueil');
    }else{
        header('Location: index.php?action=erreur');
    }
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// deconnexion util
function deconnexion($conn){
    session_unset();
    session_destroy();
    header('Location: index.php');    
}

function coordonneesUtilisateur(){

    $connexion = mysql_connect('localhost', 'root', 'd072812198788lv');

    mysql_select_db('gestage', $connexion) or die("Impossible d'ouvrir la base");

    $login=$_SESSION['login'];
    $sql= "SELECT NOM, NUM_TEL, ADRESSE_MAIL, PRENOM FROM UTILISATEUR INNER JOIN PERSONNE ON UTILISATEUR.IDPERSONNE = PERSONNE.IDPERSONNE WHERE LOGIN ='$login'";
    $resultat= mysql_query($sql,$connexion);
    while ($ligne=mysql_fetch_assoc($resultat))  {
        $Retour["nom"] = $ligne['NOM'];
        $Retour["prenom"] = $ligne['PRENOM'];
        $Retour["tel"]= $ligne['NUM_TEL'];
        $Retour["mail"]= $ligne['ADRESSE_MAIL'];
    }
    return $Retour;
}
function coordonneesOrganisation($nom){

    $connexion = mysql_connect('localhost', 'root', 'd072812198788lv');

    mysql_select_db('gestage', $connexion) or die("Impossible d'ouvrir la base");

    
    $sql= "SELECT NOM_ORGANISATION, VILLE_ORGANISATION, ADRESSE_ORGANISATION, CP_ORGANISATION, TEL_ORGANISATION, MAIL FROM ORGANISATION WHERE NOM_ORGANISATION ='$nom'";
    $resultat= mysql_query($sql,$connexion);
        while ($ligne=mysql_fetch_assoc($resultat))  {
        $Retour["NOM_ORGANISATION"] = $ligne['NOM_ORGANISATION'];
        $Retour["VILLE_ORGANISATION"] = $ligne['VILLE_ORGANISATION'];
        $Retour["ADRESSE_ORGANISATION"]= $ligne['ADRESSE_ORGANISATION'];
        $Retour["CP_ORGANISATION"]= $ligne['CP_ORGANISATION'];
        $Retour["TEL_ORGANISATION"]= $ligne['TEL_ORGANISATION'];
        $Retour["MAIL"]= $ligne['MAIL'];
    }
        return $Retour;

}

function majCoordonneesUtilisateur($nom,$prenom,$tel,$email){
    // On recupere l'identifiant de session
    $login=$_SESSION['login'];
    // On se connecte a la base de données
    $connexion = mysql_connect('localhost', 'root', 'd072812198788lv');    
    mysql_select_db('gestage', $connexion) or die("Impossible d'ouvrir la base");
    // La requete recupere le numero identifiant de l'utilisateur
    $sql= "SELECT IDPERSONNE FROM UTILISATEUR WHERE LOGIN ='$login'";
    $resultat= mysql_query($sql,$connexion);
    // On stock le resultat dans la variable $id 
    while ($li=mysql_fetch_assoc($resultat))  {
        $id=$li['IDPERSONNE'];
    }
    // On met a jour les informations sur la personne grace a son identifiant
    $sql= "UPDATE PERSONNE
           SET NOM='$nom', PRENOM='$prenom', NUM_TEL='$tel',ADRESSE_MAIL='$email'
           WHERE IDPERSONNE='$id'";
    mysql_query($sql,$connexion);
    
}

function RenseignerStage($Org,$Etudiant,$Professeur, $MaitreStage, $DateDeb, $Datefin, $DateAvis, $Avisvisite){
$connexion = mysql_connect('localhost', 'root', 'd072812198788lv');
mysql_select_db('gestage', $connexion) or die("Impossible d'ouvrir la base");

$sql= "INSERT INTO STAGE VALUES ('$Org','$Etudiant','$Professeur', '$MaitreStage','$DateDeb','$Datefin','$DateAvis', '$Avisvisite')";
$resultat= mysql_query($sql,$connexion);
 while ($ligne=mysql_fetch_assoc($resultat))  {
	$Retour["IDORGANISATION"] = $ligne['IDORGANISATION'];
	$Retour["IDETUDIANT"] = $ligne['IDETUDIANT'];
	$Retour["IDPROFESSEUR"]= $ligne['IDPROFESSEUR'];
    $Retour["IDMAITRE_STAGE"]= $ligne['IDMAITRE_STAGE'];
    $Retour["DATEDEBUT"]= $ligne['DATEDEBUT'];
    $Retour["DATEFIN"]= $ligne['DATEFIN'];
    $Retour["DATE_VISITE"]= $ligne['DATE_VISITE'];
    $Retour["AVIS_VISITE"]= $ligne['AVIS_VISITE'];		
 }
     return $Retour;

}

function RenseignerStageMaj(){

    $connexion = mysql_connect('localhost', 'root', 'd072812198788lv');

    mysql_select_db('gestage', $connexion) or die("Impossible d'ouvrir la base");

    
    $sql= "SELECT IDORGANISATION, IDETUDIANT, IDPROFESSEUR, IDMAITRE_STAGE, DATEDEBUT, DATEFIN, DATE_VISITE, AVIS_VISITE WHERE IDORGANISATION ='$nom'";
    $resultat= mysql_query($sql,$connexion);
        while ($ligne=mysql_fetch_assoc($resultat))  {
        $Retour["IDORGANISATION"] = $ligne['IDORGANISATION'];
        $Retour["IDETUDIANT"] = $ligne['IDETUDIANT'];
        $Retour["IDPROFESSEUR"]= $ligne['IDPROFESSEUR'];
        $Retour["IDMAITRE_STAGE"]= $ligne['IDMAITRE_STAGE'];
        $Retour["DATEDEBUT"]= $ligne['DATEDEBUT'];
        $Retour["DATEFIN"]= $ligne['DATEFIN'];
        $Retour["DATE_VISITE"]= $ligne['DATE_VISITE'];
        $Retour["AVIS_VISITE"]= $ligne['AVIS_VISITE'];		
    }
        return $Retour;

}
?>
