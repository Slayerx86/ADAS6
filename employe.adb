with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

package body Employe is

   procedure Put (
         E : in     P_Employe) is
   begin

      if (E /= null) then

         Put_Mot(E.Prenom);
         Put(' ');
         Put_Mot(E.Nom);
         New_Line;

         Put("Qualite : ");
         Put(E.Qualite);
         New_Line;

         Put("Nombre d'interventions : ");
         Put(E.Intervention, 0);
         New_Line;

         Put("Status : ");
         Put(E.Status);
         New_Line;

         if (E.Status = Inactif) then
            Put("En conge pour ");
            Put(E.Conge, 0);
            Put_Line(" jour(s)");
         end if;

      end if;

   end Put;


   procedure Put_All (
         E : in     P_Employe) is
   begin

      if (E /= null) then
         Put(E);
         New_Line;
         Put_All(E.Next);
      end if;

   end Put_All;


   procedure New_Employe (
         E : in out P_Employe;
         N,
         P : in     String;
         Q : in     T_Qualite) is
   begin

      E := new R_Employe'(To_Capitalise(To_Tmot(N)), To_Capitalise(To_Tmot(P)), Q, 0, 0, Actif_Disponible, E);

   end;


   procedure Del_Employe (
         E : in out P_Employe) is

      Tete : P_Employe := E.Next;

   begin

      Del(E);
      E := Tete;

   end;


   function Is_Employe_In (
         E : in     P_Employe;
         N,
         P : in     T_Mot)
     return Boolean is
   begin

      if (E = null) then

         return False;

      else

         if (E.Nom = N and E.Prenom = P) then
            return True;
         else
            return Is_Employe_In(E.Next, N, P);
         end if;

      end if;

   end;



   ----------------------------------------


   procedure Nouveau_Employe (
         E : in out P_Employe) is

      N,
      P : T_Mot     := (others => ' ');
      Q : T_Qualite;
      K : Integer;


   begin

      Put("Saisir le nom : ");
      Get_Line(N, K);
      if (K >= T_Mot'Length) then
         Skip_Line;
      end if;
      New_Line;

      Put("Saisir le prenom : ");
      Get_Line(P, K);
      if (K >= T_Mot'Length) then
         Skip_Line;
      end if;
      New_Line;

      if (Is_Employe_In(E, To_Capitalise(N), To_Capitalise(P))) then
         Put_Line("Cet employe a deja ete recrute. Recrutement impossible.");
      else
         Get(Q);
         New_Employe(E, N, P, Q);
      end if;
      New_Line;

   end Nouveau_Employe;


   procedure Consultation_Employe (
         E : in     P_Employe) is
   begin

      if (E = null) then
         Put_Line("Il n'y a pas de d'employe recrute.");
         New_Line;
      else
         Put_All(E);
      end if;

   end Consultation_Employe;

end Employe;
