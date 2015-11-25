--
-- Script de remplissage
-- Auteurs
-- Code permanent:
-- Code permanent:
--
SET LINESIZE 160
SET ECHO ON

INSERT INTO Employe
VALUES(
'ALX',
123456789,
'Alex',
'Marleau',
NULL,
'1989-12-21',
'1878 rue Toutcourt Montreal QC DUY YTY',
1234567890,
'secretaire',
'administratif',
NULL,
NULL
);

INSERT INTO Employe
VALUES(
'ALE',
123456780,
'Alex',
'Marleau',
NULL,
'1989-12-21',
'1878 rue Toutcourt Montreal QC DUY YTY',
1234567890,
'secretaire',
'surveillance',
100,
'G1'
);


SET ECHO OFF
SET PAGESIZE 30
