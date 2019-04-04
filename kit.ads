with Ada.Unchecked_Deallocation, Ada.Sequential_Io;

with Types_Enum, Date;
use Types_Enum, Date;

package Kit is

   type T_Kit is
      record
         Id          : Positive;
         Nature      : T_Nature;
         Peremption  : R_Date;
         Utilisation : Natural;
         Utilise     : Boolean;
      end record;

   type R_Kit;
   type P_Kit is access R_Kit;
   type R_Kit is
      record
         Atr  : T_Kit;
         Next : P_Kit;
      end record;

   procedure Del is
   new Ada.Unchecked_Deallocation (
      R_Kit,
      P_Kit);

   package File_Kit is new Ada.Sequential_Io(T_Kit);
   use File_Kit;

   -- saisie affichage

   procedure Put (
         K : in     P_Kit);

   procedure Put_All (
         K : in     P_Kit);

   -- publique

   procedure Nouveau_Kit (
         K : in out P_Kit;
         D : in     R_Date);

   procedure Stock_Kit (
         K : in     P_Kit);

   procedure Peremption_Kit (
         K : in out P_Kit;
         D : in     R_Date);

   procedure Load_Kit (
         Kit :    out P_Kit);

   procedure Save_Kit (
         Kit : in     P_Kit);

   function Find (
         Id  : Positive;
         Kit : P_Kit)
     return P_Kit;

end Kit;      

