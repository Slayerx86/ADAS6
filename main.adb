with Ada.Text_Io;
use Ada.Text_Io;

with Date, Kit, Employe, Societe, Audit;
use Date, Kit, Employe, Societe, Audit;

procedure Main is

   D        : R_Date   := (1, 4, 2019);
   Compteur : Positive := 14;

   Kit     : P_Kit         := null;
   Emp     : P_Employe     := null;
   Societe : P_Societe     := null;
   Audit   : T_Liste_Audit;

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

            when '2' =>
               Depart_Employe(Emp);

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
               Nouveau_Kit(Kit, D);

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
         Put_Line("2 => Listes des audits");
         Put_Line("3 => Retour");

         Put("Choix : ");
         Get(Choix);
         Skip_Line;
         New_Line;

         case Choix is

            when '1' =>
               Demande_Audit(Audit, Compteur, D);

            when '2' =>
               Put(Audit);

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
         Put_Line("4 => Resultats des societes");
         Put_Line("5 => Retour");

         Put("Choix : ");
         Get(Choix);
         Skip_Line;
         New_Line;

         case Choix is

            when '4' =>
               Put(Societe);

            when '5' =>
               exit;

            when others =>
               null;

         end case;

      end loop;

   end Menu_5;


   procedure Menu_Principal is

      Choix : Character;

   begin

      loop

         Put("Date du jour : ");
         Put(D);
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
               D := Lendemain(D);
               Peremption_Kit(Kit, D);

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

   Load_Employe(Emp);
   Load_Kit(Kit);
   Load_Societe(Societe);

   Load(Audit, Kit, Emp, Societe);

   Menu_Principal;

   Save_Employe(Emp);
   Save_Kit(Kit);
   Save_Societe(Societe);

   Save(Audit);

end Main;

