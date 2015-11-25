--
-- Script de creation des triggers
-- Auteurs
-- Code permanent: MARA22078909
-- Code permanent:
--
SET ECHO ON

CREATE OR REPLACE TRIGGER I1
  BEFORE INSERT ON Employe
  FOR EACH ROW
  BEGIN
    IF(:NEW.NAS = 111111111)
      Raise.Application.Error('Age doit etre plus grand ou egal a 16 ans.')
    END IF;
  END;
/
SET ECHO OFF
