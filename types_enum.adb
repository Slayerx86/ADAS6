with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

with Ada.Characters.Handling;
use Ada.Characters.Handling;

package body Types_Enum is


   function To_Capitalise (
         S : String)
     return String is

      Res : String := To_Lower (S);

   begin

      Res(1) := To_Upper(Res(1));
      return Res;

   end To_Capitalise;


   ---------------------------------------


   procedure Put_Mot (
         M : in     T_Mot) is

      N : Integer;

   begin
      for I in reverse 1..M'Last loop
         if (M(I) /= ' ') then
            N := I;
            exit;
         end if;
      end loop;

      for I in 1..N loop
         Put(M(I));
      end loop;

   end;


   function To_Tmot (
         S : String)
     return T_Mot is

      Res : T_Mot   := (others => ' ');
      N   : Integer := Integer'Min (S'Length, 30);

   begin

      for I in 1..N loop
         Res(I) := S(I);
      end loop;

      return Res;

   end To_Tmot;


   ---------------------------------------


   procedure Get_Duree (
         Duree : in out T_Duree) is

      D : Integer := 0;

   begin

      while (D not in 1..10) loop
         Put(" (de 1 a 10) : ");
         begin
            Get(D);
            Skip_Line;
         exception
            when others =>
               Skip_Line;
               D := 0;
         end;
      end loop;

      Duree := D;

   end;


   ---------------------------------------


   procedure Put (
         T : in     T_Nature) is
   begin
      Put(To_Capitalise(T_Nature'Image(T)));
   end;


   procedure Get (
         T : in out T_Nature) is

      Choix     : Natural;
      Index_Min : Integer := T_Nature'Pos (T_Nature'First);
      Index_Max : Integer := T_Nature'Pos (T_Nature'Last);

   begin

      for N in T_Nature loop
         Put(T_Nature'Pos(N), Width=>0);
         Put(" => ");
         Put(N);
         New_Line;
      end loop;

      loop

         Put("Choix : ");
         begin
            Get(Choix);
            Skip_Line;
            exit when (Choix in Index_Min..Index_Max);
         exception
            when others =>
               Skip_Line;
         end;

         Put_Line("Choix incorrect. Veuillez saisir un index propose");

      end loop;

      T := T_Nature'Val(Choix);

   end Get;


   ---------------------------------------


   procedure Put (
         T : in     T_Qualite) is
   begin
      Put(To_Capitalise(T_Qualite'Image(T)));
   end;


   procedure Get (
         T : in out T_Qualite) is

      Choix     : Natural;
      Index_Min : Integer := T_Qualite'Pos (T_Qualite'First);
      Index_Max : Integer := T_Qualite'Pos (T_Qualite'Last);

   begin

      for N in T_Qualite loop
         Put(T_Qualite'Pos(N), Width=>0);
         Put(" => ");
         Put(N);
         New_Line;
      end loop;

      loop

         Put("Choix : ");
         begin
            Get(Choix);
            Skip_Line;
            exit when (Choix in Index_Min..Index_Max);
         exception
            when others =>
               Skip_Line;
         end;

         Put_Line("Choix incorrect. Veuillez saisir un index propose");

      end loop;

      T := T_Qualite'Val(Choix);

   end Get;


   ---------------------------------------


   procedure Put (
         T : in     T_Status) is
   begin
      Put(To_Capitalise(T_Status'Image(T)));
   end;


   procedure Get (
         T : in out T_Status) is

      Choix     : Natural;
      Index_Min : Integer := T_Status'Pos (T_Status'First);
      Index_Max : Integer := T_Status'Pos (T_Status'Last);

   begin

      for N in T_Status loop
         Put(T_Status'Pos(N), Width=>0);
         Put(" => ");
         Put(N);
         New_Line;
      end loop;

      loop

         Put("Choix : ");
         begin
            Get(Choix);
            Skip_Line;
            exit when (Choix in Index_Min..Index_Max);
         exception
            when others =>
               Skip_Line;
         end;

         Put_Line("Choix incorrect. Veuillez saisir un index propose");

      end loop;

      T := T_Status'Val(Choix);

   end Get;


   ---------------------------------------


   procedure Put (
         T : in     T_Resultat) is
   begin
      Put(To_Capitalise(T_Resultat'Image(T)));
   end;


   procedure Get (
         T : in out T_Resultat) is

      Choix     : Natural;
      Index_Min : Integer := T_Resultat'Pos (T_Resultat'First);
      Index_Max : Integer := T_Resultat'Pos (T_Resultat'Last);

   begin

      for N in T_Resultat loop
         Put(T_Resultat'Pos(N), Width=>0);
         Put(" => ");
         Put(N);
         New_Line;
      end loop;

      loop

         Put("Choix : ");
         begin
            Get(Choix);
            Skip_Line;
            exit when (Choix in Index_Min..Index_Max);
         exception
            when others =>
               Skip_Line;
         end;

         Put_Line("Choix incorrect. Veuillez saisir un index propose");

      end loop;

      T := T_Resultat'Val(Choix);

   end Get;


end Types_Enum;
