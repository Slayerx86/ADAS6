with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

with Date, Types_Enum, Kit, Employe;
use Date, Types_Enum, Kit, Employe;

procedure Main is


   --   type R_Societe;
   --   type P_Societe is access R_Societe;
   --   type R_Societe is
   --      record
   --         Nom  : T_Mot;
   --         Date : R_Date;
   --         Res  : T_Resultat;
   --         Next : P_Societe;
   --      end record;


   --   type R_Audit_Attente;
   --   type P_Audit_Attente is access R_Audit_Attente;
   --   type R_Audit_Attente is
   --      record
   --         Id      : Positive;
   --         Duree   : T_Duree;
   --         Debut   : R_Date;
   --         Urgent  : Boolean;
   --         Qualite : T_Qualite;
   --         Societe : T_Mot;
   --         Kit     : T_Nature;
   --         Next    : P_Audit_Attente;
   --      end record;

   --   type R_Audit_En_Cours;
   --   type P_Audit_En_Cours is access R_Audit_En_Cours;
   --   type R_Audit_En_Cours is
   --      record
   --         Id      : Positive;
   --         Duree   : T_Duree;
   --         Debut,
   --         Fin     : R_Date;
   --         Kit     : P_Kit;
   --         Employe : P_Employe;
   --         Societe : P_Societe;
   --         Next    : P_Audit_En_Cours;
   --      end record;


   --   type R_Audit_Historique;
   --   type P_Audit_Historique is access R_Audit_Historique;
   --   type R_Audit_Historique is
   --      record
   --         Id       : Positive;
   --         Duree    : T_Duree;
   --         Fin      : R_Date;
   --         Res      : T_Resultat;
   --         Type_Kit : T_Nature;
   --         Id_Kit   : Positive;
   --         Employe  : T_Mot;
   --         Next     : P_Audit_Historique;
   --      end record;


   Da : R_Date := (1, 3, 2019);

   --   N : T_Nature;
   --   Q : T_Qualite;
   --   S : T_Status;
   --   R : T_Resultat;
   Kit : P_Kit     := null;
   Emp : P_Employe := null;

   procedure Menu_1 is

      Choix : Character;

   begin

      loop

         Put_Line("1 => Recrutement");
         Put_Line("2 => Depart");
         Put_Line("3 => Informations des employes");
         Put_Line("4 => Retour");

         Put("Choix : ");
         Get(Choix);
         Skip_Line;
         New_Line;

         case Choix is

            when '1' =>
               Nouveau_Employe(Emp);

            when '3' =>
               Consultation_Employe(Emp);

            when '4' =>
               exit;

            when others =>
               null;

         end case;

      end loop;

   end Menu_1;


   procedure Menu_2 is

      Choix : Character;

   begin

      loop

         Put_Line("1 => Nouveau kit");
         Put_Line("2 => Kits en stock");
         Put_Line("3 => Retour");

         Put("Choix : ");
         Get(Choix);
         Skip_Line;
         New_Line;

         case Choix is

            when '1' =>
               Nouveau_Kit(Kit, Da);

            when '2' =>
               Stock_Kit(Kit);

            when '3' =>
               exit;

            when others =>
               null;

         end case;

      end loop;

   end Menu_2;


   procedure Menu_3 is

      Choix : Character;

   begin

      loop

         Put_Line("1 => Demande");
         Put_Line("2 => Listes d'attentes");
         Put_Line("3 => Retour");

         Put("Choix : ");
         Get(Choix);
         Skip_Line;
         New_Line;

         case Choix is

            when '3' =>
               exit;

            when others =>
               null;

         end case;

      end loop;

   end Menu_3;


   procedure Menu_5 is

      Choix : Character;

   begin

      loop

         Put_Line("1 => Audits par employe");
         Put_Line("2 => Audits par societe");
         Put_Line("3 => Audits par date");
         Put_Line("4 => Retour");

         Put("Choix : ");
         Get(Choix);
         Skip_Line;
         New_Line;

         case Choix is

            when '4' =>
               exit;

            when others =>
               null;

         end case;

      end loop;

      New_Line;

   end Menu_5;


   procedure Menu_Principal is

      Choix : Character;

   begin

      loop

         Put("Date du jour : ");
         Put(Da);
         New_Line;
         New_Line;

         Put_Line("1 => Gestion du personnel");
         Put_Line("2 => Gestion des kits");
         Put_Line("3 => Gestion des audits");
         Put_Line("4 => Passage au lendemain");
         Put_Line("5 => Consultation des archives");
         Put_Line("6 => Fermeture de l'application");

         Put("Choix : ");
         Get(Choix);
         Skip_Line;
         New_Line;

         case Choix is

            when '1' =>
               Menu_1;

            when '2' =>
               Menu_2;

            when '3' =>
               Menu_3;

            when '4' =>
               Da := Lendemain(Da);

            when '5' =>
               Menu_5;

            when '6' =>
               exit;

            when others =>
               null;

         end case;

      end loop;

   end Menu_Principal;

begin

   --   Get(Da);
   --   Put(Da);

   --   Get(N);
   --   Put(N);
   --   New_Line;

   --   Get(Q);
   --   Put(Q);
   --   New_Line;

   --   Get(S);
   --   Put(S);
   --   New_Line;

   --   Get(R);
   --   Put(R);
   --   New_Line;

   Menu_Principal;

end Main;

