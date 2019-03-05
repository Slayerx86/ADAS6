with Ada.Unchecked_Deallocation;

with Types_Enum, Date;
use Types_Enum, Date;

package Employe is

   type R_Employe;
   type P_Employe is access R_Employe;
   type R_Employe is
      record
         Nom,
         Prenom       : T_Mot;
         Qualite      : T_Qualite;
         Intervention : Natural;
         Conge        : Natural;
         Status       : T_Status;
         Next         : P_Employe;
      end record;

   procedure Del is
   new Ada.Unchecked_Deallocation (
      R_Employe,
      P_Employe);

   procedure Put (
         E : in     P_Employe);

   procedure Put_All (
         E : in     P_Employe);

   procedure New_Employe (
         E : in out P_Employe;
         N,
         P : in     String;
         Q : in     T_Qualite);

   procedure Del_Employe (
         E : in out P_Employe);

   function Is_Employe_In (
         E : in     P_Employe;
         N,
         P : in     T_Mot)
     return Boolean;

   ----------------------------------------

   procedure Nouveau_Employe (
         E : in out P_Employe);

   procedure Consultation_Employe (
         E : in P_Employe);

end Employe;
