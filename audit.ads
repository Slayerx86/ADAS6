with Date, Types_Enum, Kit, Employe, Societe;
use Date, Types_Enum, Kit, Employe, Societe;

with Ada.Sequential_Io;

package Audit is

   ------------------------ audit attente ----------------------------

   type T_Audit_Attente is
      record
         Id      : Positive;
         Duree   : T_Duree;
         Debut   : R_Date;
         Urgent  : Boolean;
         Qualite : T_Qualite;
         Societe : T_Mot     := (others => ' ');
         Kit     : T_Nature;
      end record;

   type R_Audit_Attente;
   type P_Audit_Attente is access R_Audit_Attente;
   type R_Audit_Attente is
      record
         Atr  : T_Audit_Attente;
         Next : P_Audit_Attente;
      end record;

   package File_Attente is new Ada.Sequential_Io(T_Audit_Attente);
   use File_Attente;

   ----------------------- audit en cours ----------------------------

   type T_Audit_En_Cours is
      record
         Id      : Positive;
         Duree   : T_Duree;
         Debut,
         Fin     : R_Date;
         Kit     : P_Kit;
         Employe : P_Employe;
         Societe : P_Societe;
      end record;

   type R_Audit_En_Cours;
   type P_Audit_En_Cours is access R_Audit_En_Cours;
   type R_Audit_En_Cours is
      record
         Atr  : T_Audit_En_Cours;
         Next : P_Audit_En_Cours;
      end record;

   package File_En_Cours is new Ada.Sequential_Io(T_Audit_En_Cours);
   use File_En_Cours;

   procedure Load_En_Cours (
         Audit :    out P_Audit_En_Cours);

   procedure Save_En_Cours (
         Audit : in     P_Audit_En_Cours);


   type T_Infos is
      record
         Id : Positive;
         En,
         Ep,
         Sn : T_Mot    := (others => ' ');
      end record;

   type R_Infos;
   type P_Infos is access R_Infos;
   type R_Infos is
      record
         Atr  : T_Infos;
         Next : P_Infos;
      end record;

   package File_Info is new Ada.Sequential_Io(T_Infos);
   use File_Info;

   procedure Load_Infos (
         Info :    out P_Infos);

   procedure Save_Infos (
         Info : in     P_Infos);

   ----------------------- historique ---------------------------


   type T_Audit_Historique is
      record
         Id             : Positive;
         Duree          : T_Duree;
         Fin            : R_Date;
         Res            : T_Resultat;
         Type_Kit       : T_Nature;
         Id_Kit         : Positive;
         Nom_Employe,
         Prenom_Employe : T_Mot;
      end record;

   type R_Audit_Historique;
   type P_Audit_Historique is access R_Audit_Historique;
   type R_Audit_Historique is
      record
         Atr  : T_Audit_Historique;
         Next : P_Audit_Historique;
      end record;


   ------------------------------------------------------------

   type T_Liste_Audit is
      record
         Attente,
         Attente_Urgent : P_Audit_Attente    := null;
         En_Cours       : P_Audit_En_Cours   := null;
         Historique     : P_Audit_Historique := null;
      end record;

   procedure Put (
         Liste : in     T_Liste_Audit);

   procedure Load (
         Liste :    out T_Liste_Audit;
         K     : in     P_Kit;
         Emp   : in     P_Employe;
         S     : in     P_Societe);

   procedure Save (
         Liste : in     T_Liste_Audit);

   ---------------------  publique  ------------------------


   procedure Demande_Audit (
         Liste : in out T_Liste_Audit;
         Id    : in out Integer;
         D     : in     R_Date);


end Audit;
