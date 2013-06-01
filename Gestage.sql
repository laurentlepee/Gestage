SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `GestionStage`
--

-- --------------------------------------------------------

--
-- Structure de la table `ANCIEN`
--

CREATE TABLE IF NOT EXISTS `ANCIEN` (
  `IDPERSONNE` varchar(10) NOT NULL,
  `IDFILIÈRE` char(32) NOT NULL,
  `IDORGANISATION` varchar(10) DEFAULT NULL,
  `IDOPTION` char(32) NOT NULL,
  `FORMATION_EN_COURS` varchar(255) DEFAULT NULL,
  `ANNÉE_PROMOTION` char(9) DEFAULT NULL,
  PRIMARY KEY (`IDPERSONNE`),
  KEY `I_FK_ANCIEN_FILIÈRE` (`IDFILIÈRE`),
  KEY `I_FK_ANCIEN_ORGANISATION` (`IDORGANISATION`),
  KEY `I_FK_ANCIEN_OPTIONS` (`IDOPTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ANNÉE`
--

CREATE TABLE IF NOT EXISTS `ANNÉE` (
  `ANNÉESCOLAIRE` char(9) NOT NULL,
  PRIMARY KEY (`ANNÉESCOLAIRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `CLASSE`
--

CREATE TABLE IF NOT EXISTS `CLASSE` (
  `IDCLASSE` char(32) NOT NULL,
  `IDFILIÈRE` char(32) NOT NULL,
  PRIMARY KEY (`IDCLASSE`),
  KEY `I_FK_CLASSE_FILIÈRE` (`IDFILIÈRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `CLASSE`
--

INSERT INTO `CLASSE` (`IDCLASSE`, `IDFILIÈRE`) VALUES
('SISR', '1'),
('SLAM', '1'),
('CGO', '2');

-- --------------------------------------------------------

--
-- Structure de la table `CONTACT`
--

CREATE TABLE IF NOT EXISTS `CONTACT` (
  `IDPERSONNE` varchar(10) NOT NULL,
  `IDORGANISATION` varchar(10) NOT NULL,
  PRIMARY KEY (`IDPERSONNE`),
  KEY `I_FK_CONTACT_ORGANISATION` (`IDORGANISATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `FILIÈRE`
--

CREATE TABLE IF NOT EXISTS `FILIÈRE` (
  `IDFILIÈRE` char(32) NOT NULL,
  `FILIÈRE` char(32) NOT NULL,
  PRIMARY KEY (`IDFILIÈRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `FILIÈRE`
--

INSERT INTO `FILIÈRE` (`IDFILIÈRE`, `FILIÈRE`) VALUES
('1', 'Services Informatiques aux Organ'),
('2', 'Comptabilité et gestion des orga');

-- --------------------------------------------------------

--
-- Structure de la table `OPTIONS`
--

CREATE TABLE IF NOT EXISTS `OPTIONS` (
  `IDOPTION` char(32) NOT NULL,
  `OPTIONS` char(32) NOT NULL,
  PRIMARY KEY (`IDOPTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `OPTIONS`
--

INSERT INTO `OPTIONS` (`IDOPTION`, `OPTIONS`) VALUES
('1', 'slam');

-- --------------------------------------------------------

--
-- Structure de la table `ORGANISATION`
--

CREATE TABLE IF NOT EXISTS `ORGANISATION` (
  `IDORGANISATION` varchar(10) NOT NULL,
  `NOM_ORGANISATION` varchar(255) NOT NULL,
  `VILLE_ORGANISATION` varchar(128) NOT NULL,
  `ADRESSE_ORGANISATION` varchar(128) NOT NULL,
  `CP_ORGANISATION` bigint(5) NOT NULL,
  `TEL_ORGANISATION` varchar(10) NOT NULL,
  `FAX_ORGANISATION` varchar(10) DEFAULT NULL,
  `FORMEJURIDIQUE` varchar(10) DEFAULT NULL,
  `MAIL` char(32) DEFAULT NULL,
  PRIMARY KEY (`IDORGANISATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `PERSONNE`
--

CREATE TABLE IF NOT EXISTS `PERSONNE` (
  `IDPERSONNE` varchar(10) NOT NULL,
  `NOM` varchar(30) NOT NULL,
  `NUM_TEL` char(10) DEFAULT NULL,
  `ADRESSE_MAIL` varchar(30) DEFAULT NULL,
  `PRENOM` varchar(20) NOT NULL,
  PRIMARY KEY (`IDPERSONNE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `PERSONNE`
--

INSERT INTO `PERSONNE` (`IDPERSONNE`, `NOM`, `NUM_TEL`, `ADRESSE_MAIL`, `PRENOM`) VALUES
('1', 'test', '0322490920', 'test@test.fr', 'test'),
('2', 'etudiant', '000000', 'etudiant@jol.fr', 'etudiant');

-- --------------------------------------------------------

--
-- Structure de la table `PROMOTION`
--

CREATE TABLE IF NOT EXISTS `PROMOTION` (
  `ANNÉESCOLAIRE` char(9) NOT NULL,
  `IDPERSONNE` varchar(10) NOT NULL,
  `IDCLASSE` char(32) NOT NULL,
  PRIMARY KEY (`ANNÉESCOLAIRE`,`IDPERSONNE`),
  KEY `I_FK_PROMOTION_CLASSE` (`IDCLASSE`),
  KEY `I_FK_PROMOTION_ANNÉE` (`ANNÉESCOLAIRE`),
  KEY `I_FK_PROMOTION_UTILISATEUR` (`IDPERSONNE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `STAGE`
--

CREATE TABLE IF NOT EXISTS `STAGE` (
  `NUM_STAGE` int(3) NOT NULL,
  `IDORGANISATION` varchar(10) NOT NULL,
  `IDRESPONSABLE` varchar(10) NOT NULL,
  `IDMAITRE_STAGE` varchar(10) NOT NULL,
  `IDPROFESSEUR` varchar(10) NOT NULL,
  `IDETUDIANT` varchar(10) NOT NULL,
  `DATEDEBUT` date NOT NULL,
  `DATEFIN` date NOT NULL,
  `DATE_VISITE` char(32) DEFAULT NULL,
  `TACHES_VISITE` char(32) DEFAULT NULL,
  `AVIS_VISITE` char(32) DEFAULT NULL,
  `PARTICIPATIONCCF` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`NUM_STAGE`),
  KEY `I_FK_STAGE_CONTACT` (`IDRESPONSABLE`),
  KEY `I_FK_STAGE_ORGANISATION` (`IDORGANISATION`),
  KEY `I_FK_STAGE_CONTACT1` (`IDMAITRE_STAGE`),
  KEY `I_FK_STAGE_UTILISATEUR` (`IDPROFESSEUR`),
  KEY `I_FK_STAGE_UTILISATEUR1` (`IDETUDIANT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `UTILISATEUR`
--

CREATE TABLE IF NOT EXISTS `UTILISATEUR` (
  `IDPERSONNE` varchar(10) NOT NULL,
  `IDOPTION_ETUDIANT` char(32) DEFAULT NULL,
  `LOGIN` char(32) NOT NULL,
  `MOT_DE_PASSE` char(32) NOT NULL,
  `ROLE` char(15) DEFAULT NULL,
  PRIMARY KEY (`IDPERSONNE`),
  KEY `I_FK_UTILISATEUR_OPTIONS` (`IDOPTION_ETUDIANT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `UTILISATEUR`
--

INSERT INTO `UTILISATEUR` (`IDPERSONNE`, `IDOPTION_ETUDIANT`, `LOGIN`, `MOT_DE_PASSE`, `ROLE`) VALUES
('1', NULL, 'test', 'test', 'admin'),
('2', '1', 'etudiant', 'etudiant', 'etudiant');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `ANCIEN`
--
ALTER TABLE `ANCIEN`
  ADD CONSTRAINT `ANCIEN_ibfk_1` FOREIGN KEY (`IDFILIÈRE`) REFERENCES `FILIÈRE` (`IDFILIÈRE`),
  ADD CONSTRAINT `ANCIEN_ibfk_2` FOREIGN KEY (`IDORGANISATION`) REFERENCES `ORGANISATION` (`IDORGANISATION`),
  ADD CONSTRAINT `ANCIEN_ibfk_3` FOREIGN KEY (`IDOPTION`) REFERENCES `OPTIONS` (`IDOPTION`),
  ADD CONSTRAINT `ANCIEN_ibfk_4` FOREIGN KEY (`IDPERSONNE`) REFERENCES `PERSONNE` (`IDPERSONNE`);

--
-- Contraintes pour la table `CLASSE`
--
ALTER TABLE `CLASSE`
  ADD CONSTRAINT `CLASSE_ibfk_1` FOREIGN KEY (`IDFILIÈRE`) REFERENCES `FILIÈRE` (`IDFILIÈRE`);

--
-- Contraintes pour la table `CONTACT`
--
ALTER TABLE `CONTACT`
  ADD CONSTRAINT `CONTACT_ibfk_1` FOREIGN KEY (`IDORGANISATION`) REFERENCES `ORGANISATION` (`IDORGANISATION`),
  ADD CONSTRAINT `CONTACT_ibfk_2` FOREIGN KEY (`IDPERSONNE`) REFERENCES `PERSONNE` (`IDPERSONNE`);

--
-- Contraintes pour la table `PROMOTION`
--
ALTER TABLE `PROMOTION`
  ADD CONSTRAINT `PROMOTION_ibfk_1` FOREIGN KEY (`IDCLASSE`) REFERENCES `CLASSE` (`IDCLASSE`),
  ADD CONSTRAINT `PROMOTION_ibfk_2` FOREIGN KEY (`ANNÉESCOLAIRE`) REFERENCES `ANNÉE` (`ANNÉESCOLAIRE`),
  ADD CONSTRAINT `PROMOTION_ibfk_3` FOREIGN KEY (`IDPERSONNE`) REFERENCES `UTILISATEUR` (`IDPERSONNE`);

--
-- Contraintes pour la table `STAGE`
--
ALTER TABLE `STAGE`
  ADD CONSTRAINT `STAGE_ibfk_1` FOREIGN KEY (`IDRESPONSABLE`) REFERENCES `CONTACT` (`IDPERSONNE`),
  ADD CONSTRAINT `STAGE_ibfk_2` FOREIGN KEY (`IDORGANISATION`) REFERENCES `ORGANISATION` (`IDORGANISATION`),
  ADD CONSTRAINT `STAGE_ibfk_3` FOREIGN KEY (`IDMAITRE_STAGE`) REFERENCES `CONTACT` (`IDPERSONNE`),
  ADD CONSTRAINT `STAGE_ibfk_4` FOREIGN KEY (`IDPROFESSEUR`) REFERENCES `UTILISATEUR` (`IDPERSONNE`),
  ADD CONSTRAINT `STAGE_ibfk_5` FOREIGN KEY (`IDETUDIANT`) REFERENCES `UTILISATEUR` (`IDPERSONNE`);

--
-- Contraintes pour la table `UTILISATEUR`
--
ALTER TABLE `UTILISATEUR`
  ADD CONSTRAINT `UTILISATEUR_ibfk_1` FOREIGN KEY (`IDOPTION_ETUDIANT`) REFERENCES `OPTIONS` (`IDOPTION`),
  ADD CONSTRAINT `UTILISATEUR_ibfk_2` FOREIGN KEY (`IDPERSONNE`) REFERENCES `PERSONNE` (`IDPERSONNE`);