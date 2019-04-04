with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

package body Kit is


   --------------------------------   saisie affichage   --------------------------------


   procedure Put (
         K : in     P_Kit) is
   begin

      if (K /= null) then

         Put("Kit ");
         Put(K.Atr.Nature);
         Put(' ');
         Put(K.Atr.Id, 0);
         New_Line;

         Put("Nombre d'utilisation : ");
         Put(K.Atr.Utilisation, 0);
         New_Line;

         Put("Date de peremption : ");
         Put(K.Atr.Peremption);
         New_Line;

         Put("Etat : ");
         if (K.Atr.Utilise) then
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


   --------------------------------   prive   --------------------------------


   procedure New_Kit (
         K   : in out P_Kit;
         Id  : in     Positive;
         Nat : in     T_Nature;
         Per : in     R_Date) is
      Kit : T_Kit;
   begin

      Kit := (Id, Nat, Per, 0, False);
      K := new R_Kit'(Kit, K);

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

         if (K.Atr.Id = Id) then
            return True;
         else
            return Is_Kit_In(K.Next, Id);
         end if;

      end if;

   end;


   --------------------------------   publique   --------------------------------


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

   end Nouveau_Kit;


   procedure Stock_Kit (
         K : in     P_Kit) is
   begin

      if (K = null) then
         Put_Line("Il n'y a pas de kit en stock");
         New_Line;
      else
         Put_All(K);
      end if;

   end Stock_Kit;


   procedure Peremption_Kit (
         K : in out P_Kit;
         D : in     R_Date) is
   begin

      if (K /= null) then

         if (Anterieur(K.Atr.Peremption, D)) then

            Put("Suppression du kit ");
            Put(K.Atr.Id, 0);
            New_Line;

            Del_Kit(K);
            Peremption_Kit(K, D);

         else

            Peremption_Kit(K.Next, D);

         end if;

      end if;

   end Peremption_Kit;


   procedure Load_Kit (
         Kit :    out P_Kit) is
      File : File_Kit.File_Type;
      K    : T_Kit;
   begin

      Open(File, In_File, "kit.arc");

      while (not End_Of_File(File)) loop
         Read(File, K);
         Kit := new R_Kit'(K, Kit);
      end loop;

      Close(File);

   end Load_Kit;


   procedure Save_Kit (
         Kit : in     P_Kit) is
      File : File_Kit.File_Type;

      procedure Save (
            Kit : in     P_Kit) is
      begin
         if (Kit.Next /= null) then
            Save(Kit.Next);
         end if;
         Write(File, Kit.Atr);
      end Save;

   begin

      Create(File, Append_File, "kit.arc");
      Save(Kit);
      Close(File);

   end Save_Kit;

   function Find (
         Id  : Positive;
         Kit : P_Kit)
     return P_Kit is
   begin
      
      if (Kit = null) then
         return null;
      elsif (Kit.Atr.Id = Id) then
         return Kit;
      else
         return Find(Id,Kit.Next);
      end if;

   end Find;

end Kit;
