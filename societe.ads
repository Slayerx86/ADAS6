with Date, Types_Enum;
use Date, Types_Enum;

with Ada.Sequential_Io;

package Societe is

   type T_Societe is
      record
         Nom  : T_Mot;
         Date : R_Date;
         Res  : T_Resultat;
      end record;

   type R_Societe;
   type P_Societe is access R_Societe;
   type R_Societe is
      record
         Atr  : T_Societe;
         Next : P_Societe;
      end record;

   package F_Societe is new Ada.Sequential_Io(T_Societe);
   use F_Societe;


   -- publique

   procedure Put (
         S : in     T_Societe);

   procedure Put (
         S : in     P_Societe);

   procedure Load_Societe (
         Liste :    out P_Societe);

   procedure Save_Societe (
         Liste : in     P_Societe);

   function Find (
         N : T_Mot;
         S : P_Societe)
     return P_Societe;

end Societe;
