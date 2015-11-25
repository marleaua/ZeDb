--
-- Script de creation des tables
-- Auteurs
-- Code permanent: MARA22078909
-- Code permanent:
-- 
--
SET ECHO ON

DROP TABLE Mesure;
DROP TABLE Individu;
DROP TABLE Espece;
DROP TABLE Choix;
DROP TABLE Surveillance;
DROP TABLE Lotissement;
DROP TABLE Zone0;
DROP TABLE Salaire;
DROP TABLE Employe;

SET ECHO ON

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD' ;

CREATE TABLE Employe(
  CodeEmploye character(3),
  NAS integer NOT NULL,
  Nom varchar(30) NOT NULL,
  Prenom varchar(30) NOT NULL,
  NomJeuneFille varchar(30),
  DateNaissance date NOT NULL,
  Adresse varchar(50) NOT NULL,
  Telephone integer NOT NULL,
  Fonction varchar(30),
  Service varchar(20),
  Taux integer,
  Grade varchar(2),
  CONSTRAINT Employe_PK PRIMARY KEY (CodeEmploye),
  CONSTRAINT EmployeNAS_Uni UNIQUE(NAS),
  CONSTRAINT NAS_Verif CHECK(NAS >= 100000000 AND NAS <= 999999999),
  --CONSTRAINT DateNaissance_Verif CHECK( (SYSDATE - DateNaissance) >= (16 * 365)),
  CONSTRAINT Telephone_Verif CHECK(Telephone >= 1000000000 AND Telephone <= 9999999999),
  CONSTRAINT Service_Verif CHECK(Service IN ('administratif', 'surveillance', 'medical')),
  CONSTRAINT Taux_Verif CHECK( (Service IN ('surveillance') AND Taux IS NOT NULL) OR (Service NOT IN ('surveillance') AND Taux IS NULL) ),
  CONSTRAINT Grade_Verif CHECK( (Service IN ('surveillance') AND GRADE IS NOT NULL AND Grade IN ('G1', 'G2', 'G3', 'G4', 'G5')) OR (Service NOT IN ('surveillance') AND Grade IS NULL ))
);

CREATE TABLE Salaire(
  CodeEmploye character(3),
  Mois integer,
  Salaire integer,
  CONSTRAINT Salaire_PK PRIMARY KEY (CodeEmploye, Mois),
  CONSTRAINT SalaireCodeEmploye_FK FOREIGN KEY (CodeEmploye)
  REFERENCES Employe(CodeEmploye),
  CONSTRAINT SalaireMois_Verif CHECK( Mois >= 1 AND Mois <= 12)
);

CREATE TABLE Zone0(
  CodeZone integer,
  NomZone varchar(20),
  ChefZone character(3),
  CONSTRAINT Zone0_PK PRIMARY KEY (CodeZone),
  CONSTRAINT Zone0ChefZone_FK FOREIGN KEY (ChefZone)
  REFERENCES Employe(CodeEmploye)
);

CREATE TABLE Lotissement(
  CodeZone integer,
  CodeLotissement integer,
  NomLotissement varchar(20),
  CONSTRAINT Lotissement_PK PRIMARY KEY (CodeZone, CodeLotissement),
  CONSTRAINT LotissementCodeZone_FK FOREIGN KEY (CodeZone)
  REFERENCES Zone0(CodeZone)
);

CREATE TABLE Surveillance(
  CodeEmploye character(3),
  CodeZone integer,
  CodeLotissement integer,
  Jour varchar(8),
  Heure integer,
  CONSTRAINT Surv_PK PRIMARY KEY (CodeEmploye, CodeZone, CodeLotissement, Jour, Heure), --A VERIFIER POUR LE FOREIGN KEY
  CONSTRAINT SurvCodeEmploye_FK FOREIGN KEY (CodeEmploye)
  REFERENCES Employe(CodeEmploye),
  CONSTRAINT SurvCodeZoneCodeLotissement_FK FOREIGN KEY (CodeZone, CodeLotissement)
  REFERENCES Lotissement(CodeZone, CodeLotissement)
);


CREATE TABLE Choix(
  CodeEmploye character(3),
  CodeZone integer,
  Affinite integer,
  CONSTRAINT Choix_PK PRIMARY KEY (CodeEmploye, CodeZone),
  CONSTRAINT ChoixCodeEmploye_FK FOREIGN KEY (CodeEmploye)
  REFERENCES Employe(CodeEmploye),
  CONSTRAINT ChoixCodeZone_FK FOREIGN KEY (CodeZone)
  REFERENCES Zone0(CodeZone)
);

CREATE TABLE Espece(
  CodeEspece integer,
  NomEspece varchar(30),
  Nombre integer,
  CodeZone integer,
  CodeLotissement integer,
  CONSTRAINT Esp_PK PRIMARY KEY (CodeEspece),
  CONSTRAINT EspCodeZoneCodeLotissement_FK FOREIGN KEY (CodeZone, CodeLotissement)
  REFERENCES    Lotissement(CodeZone, CodeLotissement)
);

CREATE TABLE Individu(
  CodeIndividu integer,
  NomIndividu varchar(20),
  CodeEspece integer,
  Sang varchar(3), --VERIFIER CE QUI EST DESIRE
  DateNaissance date,
  DateDeces date,
  Pere integer,
  Mere integer,
  CONSTRAINT Individu_PK PRIMARY KEY (CodeIndividu),
  CONSTRAINT IndividuCodeEspece_FK FOREIGN KEY (CodeEspece)
  REFERENCES Espece(CodeEspece),
  CONSTRAINT IndividuMere_FK FOREIGN KEY (Mere)
  REFERENCES Individu(CodeIndividu),
  CONSTRAINT IndividuPere_FK FOREIGN KEY (Pere)
  REFERENCES Individu(CodeIndividu)
);

CREATE TABLE Mesure(
  CodeIndividu integer,
  DateMesure date,
  Poids integer,
  Taille integer,
  CONSTRAINT Mesure_PK PRIMARY KEY (CodeIndividu, DateMesure),
  CONSTRAINT MesureCodeIndividu_FK FOREIGN KEY (CodeIndividu)
  REFERENCES Individu(CodeIndividu)
);

SET ECHO OFF


