with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

package body Employe is

   ------------------------ saisie affichage ----------------------------

   procedure Put (
         E : in     P_Employe) is
   begin

      if (E /= null) then

         Put_Mot(E.Atr.Prenom);
         Put(' ');
         Put_Mot(E.Atr.Nom);
         New_Line;

         Put("Qualite : ");
         Put(E.Atr.Qualite);
         New_Line;

         Put("Nombre d'interventions : ");
         Put(E.Atr.Nb_Intervention, 0);
         New_Line;

         Put("Temps en activite (jours) : ");
         Put(E.Atr.Temps_Intervention, 0);
         New_Line;

         Put("Status : ");
         Put(E.Atr.Status);
         New_Line;

         if (E.Atr.Status = Inactif) then
            Put("En conge pour ");
            Put(E.Atr.Conge, 0);
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


   ------------------------- prive -------------------------------------


   procedure New_Employe (
         E : in out P_Employe;
         N,
         P : in     String;
         Q : in     T_Qualite) is
      Employe : T_Employe;
   begin

      Employe := (To_Capitalise(To_Tmot(N)), To_Capitalise(To_Tmot(P)), Q, 0, 0, 0, Actif_Disponible);
      E := new R_Employe'(Employe, E);

   end;


   procedure Del_Employe (
         Liste : in out P_Employe;
         E     : in     P_Employe) is
      Next : P_Employe;
   begin

      if (Liste /= null) then

         if (Liste = E) then
            Next := Liste.Next;
            Del(Liste);
            Liste := Next;
         else
            Del_Employe(Liste.Next, E);
         end if;

      end if;

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

         if (E.Atr.Nom = N and E.Atr.Prenom = P) then
            return True;
         else
            return Is_Employe_In(E.Next, N, P);
         end if;

      end if;

   end;


   function Get_Employe (
         E : P_Employe;
         N : Positive)
     return P_Employe is

      Emp : P_Employe := E;

   begin

      if (E = null) then

         return null;

      elsif (N = 1) then

         return E;

      else

         for I in 2..N loop
            Emp := Emp.Next;
            if (Emp = null) then
               return null;
            end if;
         end loop;

         return Emp;

      end if;

   end Get_Employe;


   function Is_Employe_Libre (
         E : in     P_Employe)
     return Boolean is
   begin

      if (E = null) then

         return False;

      else

         if (E.Atr.Status = Actif_Disponible) then
            return True;
         else
            return False;
         end if;

      end if;

   end;


   function Is_Equipe_Employe_Libre (
         E : in     P_Employe)
     return Boolean is
   begin

      if (E = null) then

         return False;

      else

         if (E.Atr.Status = Actif_Disponible) then
            return True;
         else
            return Is_Equipe_Employe_Libre(E.Next);
         end if;

      end if;

   end;


   ------------------------- publique ------------------------------


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


   procedure Depart_Employe (
         E : in out P_Employe) is

      Emp : P_Employe;
      I   : Integer;

   begin


      if (not Is_Equipe_Employe_Libre(E)) then

         Put_Line("Aucun employe ne peut partir");
         New_Line;

      else

         loop
            loop

               I := 1;
               Emp := E;
               Put_Line("Liste des employes disponibles");
               Put_Line("0 => annuler");

               while (Emp /= null) loop

                  if (Is_Employe_Libre(Emp)) then
                     Put(I, 0);
                     Put(" => ");
                     Put_Mot(Emp.Atr.Prenom);
                     Put(' ');
                     Put_Mot(Emp.Atr.Nom);
                     New_Line;
                  end if;

                  Emp := Emp.Next;
                  I := I +1;

               end loop;

               begin
                  Put("Choix : ");
                  Get(I);
                  Skip_Line;
                  New_Line;
               exception
                  when others =>
                     Skip_Line;
                     New_Line;
                     I := -1;
               end;

               exit when (I > -1);
               Put_Line("Index invalide");
               New_Line;

            end loop;


            if (I = 0) then

               Put_Line("Annulation de depart");
               New_Line;
               exit;

            else
               Emp := Get_Employe(E, I);
               if ( not Is_Employe_Libre(Emp) ) then

                  Put_Line("Index invalide");
                  New_Line;

               else

                  Put("Depart de ");
                  Put_Mot(Emp.Atr.Prenom);
                  Put(' ');
                  Put_Mot(Emp.Atr.Nom);
                  New_Line;
                  New_Line;
                  Del_Employe(E, Emp);
                  exit;

               end if;

            end if;

         end loop;

      end if;

   end Depart_Employe;


   procedure Consultation_Employe (
         E : in     P_Employe) is
   begin

      if (E = null) then
         Put_Line("Il n'y a pas d'employe recrute.");
         New_Line;
      else
         Put_All(E);
      end if;

   end Consultation_Employe;


   procedure Load_Employe (
         Emp :    out P_Employe) is
      File : File_Employe.File_Type;
      E    : T_Employe;
   begin

      Open(File, In_File, "employe.arc");

      while (not End_Of_File(File)) loop
         Read(File, E);
         Emp := new R_Employe'(E, Emp);
      end loop;

      Close(File);

   end Load_Employe;


   procedure Save_Employe (
         Emp : in     P_Employe) is
      File : File_Employe.File_Type;

      procedure Save (
            Emp : in     P_Employe) is
      begin
         if (Emp.Next /= null) then
            Save(Emp.Next);
         end if;
         Write(File, Emp.Atr);
      end Save;

   begin

      Create(File, Append_File, "employe.arc");
      Save(Emp);
      Close(File);

   end Save_Employe;

   function Find (
         N,
         P   : T_Mot;
         Emp : P_Employe)
     return P_Employe is
   begin

      if (Emp = null) then
         return null;
      elsif (Emp.Atr.Nom = N and Emp.Atr.Prenom = P) then
         return Emp;
      else
         return Find(N,P,Emp.Next);
      end if;

   end Find;

end Employe;
