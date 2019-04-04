with Ada.Unchecked_Deallocation, Ada.Sequential_Io;

with Types_Enum;
use Types_Enum;

package Employe is

   type T_Employe is
      record
         Nom,
         Prenom             : T_Mot     := (others => ' ');
         Qualite            : T_Qualite;
         Nb_Intervention,
         Temps_Intervention,
         Conge              : Natural;
         Status             : T_Status;
      end record;

   type R_Employe;
   type P_Employe is access R_Employe;
   type R_Employe is
      record
         Atr  : T_Employe;
         Next : P_Employe;
      end record;

   procedure Del is
   new Ada.Unchecked_Deallocation (
      R_Employe,
      P_Employe);

   package File_Employe is new Ada.Sequential_Io(T_Employe);
   use File_Employe;

   -- saisie affichage

   procedure Put (
         E : in     P_Employe);

   procedure Put_All (
         E : in     P_Employe);

   -- publique

   procedure Nouveau_Employe (
         E : in out P_Employe);

   procedure Depart_Employe (
         E : in out P_Employe);

   procedure Consultation_Employe (
         E : in     P_Employe);

   procedure Load_Employe (
         Emp :    out P_Employe);

   procedure Save_Employe (
         Emp : in     P_Employe);

   function Find (
         N,
         P   : T_Mot;
         Emp : P_Employe)
     return P_Employe;

end Employe;
