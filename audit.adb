with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

package body Audit is

   -------------------------- audit attente -----------------------------


   procedure Put (
         Audit : in     T_Audit_Attente) is
   begin

      Put("Audit numero ");
      Put(Audit.Id, 0);
      New_Line;

      Put("Societe : ");
      Put(Audit.Societe);
      New_Line;

      Put("Duree : ");
      Put(Audit.Duree, 0);
      New_Line;

      Put("Date de la demande : ");
      Put(Audit.Debut);
      New_Line;

      Put("Type d'audit : ");
      Put(Audit.Kit);
      New_Line;

      Put("Personnel requis : ");
      Put(Audit.Qualite);
      New_Line;

      if (Audit.Urgent) then
         Put_Line("Priorite : Urgent");
      else
         Put_Line("Priorite : Routine");
      end if;

   end Put;


   procedure Put (
         Audit : in     P_Audit_Attente) is
   begin

      if (Audit /= null) then
         Put(Audit.Atr);
         New_Line;
         Put(Audit.Next);
      end if;

   end Put;


   procedure New_Audit_Attente (
         Liste : in out T_Liste_Audit;
         Audit : in     T_Audit_Attente) is

   begin

      if (Audit.Urgent) then
         Liste.Attente_Urgent := new R_Audit_Attente'(Audit, Liste.Attente_Urgent);
      else
         Liste.Attente := new R_Audit_Attente'(Audit, Liste.Attente);
      end if;

   end New_Audit_Attente;


   procedure Load_Attente (
         Audit    :    out P_Audit_Attente;
         Filename : in     String) is
      File : File_Attente.File_Type;
      A    : T_Audit_Attente;
   begin

      Audit := null;

      Open(File, In_File, Filename);

      while (not End_Of_File(File)) loop
         Read(File, A);
         Audit := new R_Audit_Attente'(A, Audit);
      end loop;

      Close(File);

   end Load_Attente;


   procedure Save_Attente (
         Audit    : in     P_Audit_Attente;
         Filename : in     String) is
      File : File_Attente.File_Type;

      procedure Save (
            Audit : in     P_Audit_Attente) is
      begin
         if (Audit.Next /= null) then
            Save(Audit.Next);
         end if;
         Write(File, Audit.Atr);
      end Save;

   begin

      Create(File, Append_File, Filename);
      Save(Audit);
      Close(File);

   end Save_Attente;


   ------------------------------ audit en cours -----------------------------------

   procedure Put (
         Audit : in     T_Audit_En_Cours) is
   begin

      Put("Audit numero ");
      Put(Audit.Id, 0);
      New_Line;

      Put("Societe : ");
      Put(Audit.Societe.Atr.Nom);
      New_Line;

      Put("Duree : ");
      Put(Audit.Duree, 0);
      New_Line;

      Put("Date de debut : ");
      Put(Audit.Debut);
      New_Line;

      Put("Date de fin : ");
      Put(Audit.Fin);
      New_Line;

      Put("Type d'audit : ");
      Put(Audit.Kit.Atr.Nature);
      New_Line;

      Put("Employe : ");
      Put_Mot(Audit.Employe.Atr.Prenom);
      Put(' ');
      Put_Mot(Audit.Employe.Atr.Nom);
      New_Line;

   end Put;


   procedure Put (
         Audit : in     P_Audit_En_Cours) is
   begin

      if (Audit /= null) then
         Put(Audit.Atr);
         New_Line;
         Put(Audit.Next);
      end if;

   end Put;

   procedure Load_En_Cours (
         Audit :    out P_Audit_En_Cours) is
      File : File_En_Cours.File_Type;
      A    : T_Audit_En_Cours;
   begin

      Audit := null;

      Open(File, In_File, "en_cours.arc");

      while (not End_Of_File(File)) loop
         Read(File, A);
         Audit := new R_Audit_En_Cours'(A, Audit);
      end loop;

      Close(File);

   end Load_En_Cours;


   procedure Save_En_Cours (
         Audit : in     P_Audit_En_Cours) is
      File : File_En_Cours.File_Type;

      procedure Save (
            Audit : in     P_Audit_En_Cours) is
      begin
         if (Audit.Next /= null) then
            Save(Audit.Next);
         end if;
         Write(File, Audit.Atr);
      end Save;

   begin

      Create(File, Append_File, "en_cours.arc");
      Save(Audit);
      Close(File);

   end Save_En_Cours;


   function Get_Infos (
         Audit : P_Audit_En_Cours)
     return P_Infos is
      I    : T_Infos;
      Info : P_Infos          := null;
      A    : P_Audit_En_Cours := Audit;
   begin

      while (A /= null) loop
         I := (A.Atr.Kit.Atr.Id, A.Atr.Employe.Atr.Nom, A.Atr.Employe.Atr.Prenom, A.Atr.Societe.Atr.Nom);
         Info := new R_Infos'(I, Info);
         A := A.Next;
      end loop;
      return Info;

   end Get_Infos;


   procedure Link_Infos (
         Audit : in out P_Audit_En_Cours;
         Infos : in     P_Infos;
         K     : in     P_Kit;
         Emp   : in     P_Employe;
         S     : in     P_Societe) is
   begin

      if (Audit /= null) then
         Audit.Atr.Kit := Find(Infos.Atr.Id, K);
         Audit.Atr.Employe := Find(Infos.Atr.En, Infos.Atr.Ep, Emp);
         Audit.Atr.Societe := Find(Infos.Atr.Sn, S);
         Link_Infos(Audit.Next, Infos.Next, K, Emp, S);
      end if;

   end Link_Infos;


   procedure Load_Infos (
         Info :    out P_Infos) is
      File : File_Info.File_Type;
      I    : T_Infos;
   begin

      Info := null;

      Open(File, In_File, "link.arc");

      while (not End_Of_File(File)) loop
         Read(File, I);
         Info := new R_Infos'(I, Info);
      end loop;

      Close(File);

   end Load_Infos;


   procedure Save_Infos (
         Info : in     P_Infos) is
      File : File_Info.File_Type;

      procedure Save (
            Info : in     P_Infos) is
      begin
         if (Info.Next /= null) then
            Save(Info.Next);
         end if;
         Write(File, Info.Atr);
      end Save;

   begin

      Create(File, Append_File, "link.arc");
      Save(Info);
      Close(File);

   end Save_Infos;


   ------------------------------- audit historique ------------------------------------------


   ------------------------------- publique ------------------------------------------

   procedure Demande_Audit (
         Liste : in out T_Liste_Audit;
         Id    : in out Integer;
         D     : in     R_Date) is

      Audit : T_Audit_Attente;
      Choix : Character;
      K     : Integer;

   begin

      Audit.Id := Id;
      Audit.Debut := D;

      loop
         Put("Saisir le nom de la societe : ");
         Get_Line(Audit.Societe, K);
         exit when (K > 0);
      end loop;
      Audit.Societe := To_Capitalise(Audit.Societe);

      Put("Saisir la duree souhaitee en jours");
      Get_Duree(Audit.Duree);

      Put_Line("Type d'audit :");
      Get(Audit.Kit);

      Put_Line("Personnel requis :");
      Get(Audit.Qualite);

      loop
         Put("Audit urgent (o/n) : ");
         Get(Choix);
         Skip_Line;
         exit when (Choix = 'o' or Choix = 'n');
      end loop;
      if (Choix = 'o') then
         Audit.Urgent := True;
      else
         Audit.Urgent := False;
      end if;

      New_Line;
      Put_Line("Synthese : ");
      Put(Audit);
      New_Line;

      loop
         Put("Valider la demande (o/n) : ");
         Get(Choix);
         Skip_Line;
         exit when (Choix = 'o' or Choix = 'n');
      end loop;
      New_Line;

      if (Choix = 'o') then
         New_Audit_Attente(Liste, Audit);
         Put_Line("Demande validee");
      else
         Put_Line("Annulation de demande");
      end if;
      New_Line;

   end Demande_Audit;


   procedure Put (
         Liste : in     T_Liste_Audit) is
      Vide : Boolean := True;
   begin

      if (Liste.Attente /= null) then
         Put_Line("Audit(s) en attente");
         Put(Liste.Attente);
         Vide := False;
      end if;

      if (Liste.Attente_Urgent /= null) then
         Put_Line("Audit(s) urgent(s) en attente");
         Put(Liste.Attente_Urgent);
         Vide := False;
      end if;

      if (Liste.En_Cours /= null) then
         Put(Liste.En_Cours);
         Vide := False;
      end if;

      if (Vide) then
         Put_Line("Aucun audit en attente ou en cours");
         New_Line;
      end if;

   end Put;


   procedure Load (
         Liste :    out T_Liste_Audit;
         K     : in     P_Kit;
         Emp   : in     P_Employe;
         S     : in     P_Societe) is
      Infos : P_Infos := null;
   begin

      Load_Attente(Liste.Attente, "attente.arc");
      Load_Attente(Liste.Attente_Urgent, "attente_urgent.arc");
      Load_En_Cours(Liste.En_Cours);

      Load_Infos(Infos);
      Link_Infos(Liste.En_Cours, Infos, K, Emp, S);

   end Load;


   procedure Save (
         Liste : in     T_Liste_Audit) is
      Infos : P_Infos := null;
   begin

      Save_Attente(Liste.Attente, "attente.arc");
      Save_Attente(Liste.Attente_Urgent, "attente_urgent.arc");
      Save_En_Cours(Liste.En_Cours);

      Infos := Get_Infos(Liste.En_Cours);
      Save_Infos(Infos);

   end Save;


end Audit;
