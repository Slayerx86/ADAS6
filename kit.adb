with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

package body Kit is

   procedure Put (
         K : in     P_Kit) is
   begin

      if (K /= null) then

         Put("Kit ");
         Put(K.Nature);
         Put(' ');
         Put(K.Id, 0);
         New_Line;

         Put("Nombre d'utilisation : ");
         Put(K.Utilisation, 0);
         New_Line;

         Put("Date de peremption : ");
         Put(K.Peremption);
         New_Line;

         Put("Etat : ");
         if (K.Utilise) then
            Put_Line("en cours d'utilisation");
         else
            Put_Line("disponible");
         end if;

      end if;

   end Put;


   procedure Put_All (
         K : in     P_Kit) is
   begin

      if (K /= null) then
         Put(K);
         New_Line;
         Put_All(K.Next);
      end if;

   end Put_All;


   procedure New_Kit (
         K   : in out P_Kit;
         Id  : in     Positive;
         Nat : in     T_Nature;
         Per : in     R_Date) is
   begin

      K := new R_Kit'(Id, Nat, Per, 0, False, K);

   end;


   procedure Del_Kit (
         K : in out P_Kit) is

      Tete : P_Kit := K.Next;

   begin

      Del(K);
      K := Tete;

   end;


   function Is_Kit_In (
         K  : in     P_Kit;
         Id : in     Positive)
     return Boolean is
   begin

      if (K = null) then

         return False;

      else

         if (K.Id = Id) then
            return True;
         else
            return Is_Kit_In(K.Next, Id);
         end if;

      end if;

   end;


   --------------------------------


   procedure Nouveau_Kit (
         K : in out P_Kit;
         D : in     R_Date) is

      Nat : T_Nature;
      Id  : Positive;
      Per : R_Date;

   begin

      loop
         Put("Saisir le numero : ");
         begin
            Get(Id);
            Skip_Line;
            exit;
         exception
            when others =>
               Skip_Line;
               Put("L'identifiant est un entier positif. ");
         end;
      end loop;
      New_Line;


      if (Is_Kit_In(K, Id)) then

         Put_Line("Ce numero de kit existe deja. Impossible d'ajouter.");
         New_Line;

      else

         Put_Line("Saisir la nature : ");
         Get(Nat);
         New_Line;

         Put("Saisir la date de peremption : ");
         Get(Per);
         New_Line;

         if (Anterieur(Per, D)) then
            Put_Line("La date de peremption est anterieure a la date du jour. Impossible d'ajouter.");
            New_Line;
         else
            New_Kit(K, Id, Nat, Per);
         end if;

      end if;

   end Nouveau_kit;


   procedure Stock_Kit (
         K : in     P_Kit) is
   begin

      if (K = null) then
         Put_Line("Il n'y a pas de kit en stock");
         New_Line;
      else
         Put_All(K);
      end if;

   end Stock_kit;


end Kit;
