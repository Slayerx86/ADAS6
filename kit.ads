with Ada.Unchecked_Deallocation;

with Types_Enum, Date;
use Types_Enum, Date;

package Kit is

   type R_Kit;
   type P_Kit is access R_Kit;
   type R_Kit is
      record
         Id          : Positive;
         Nature      : T_Nature;
         Peremption  : R_Date;
         Utilisation : Natural;
         Utilise     : Boolean;
         Next        : P_Kit;
      end record;

   procedure Del is
   new Ada.Unchecked_Deallocation (
      R_Kit,
      P_Kit);

   procedure Put (
         K : in     P_Kit);

   procedure Put_All (
         K : in     P_Kit);

   procedure New_Kit (
         K   : in out P_Kit;
         Id  : in     Positive;
         Nat : in     T_Nature;
         Per : in     R_Date);

   procedure Del_Kit (
         K : in out P_Kit);

   function Is_Kit_In (
         K  : in     P_Kit;
         Id : in     Positive)
     return Boolean;

   --------------------------------

   procedure Nouveau_Kit (
         K : in out P_Kit;
         D : in     R_Date);

   procedure Stock_Kit (
         K : in     P_Kit);

end Kit;
