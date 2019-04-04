with Types_Enum, Kit, Employe, Societe, Audit;
use Types_Enum, Kit, Employe, Societe, Audit;

package body Donnees is

   procedure Set_Employe is
      Employe : T_Employe;
      Liste   : P_Employe;
   begin

      Liste := null;

      Employe := (To_Tmot("Trouvetout"), To_Tmot("Marc"), Ingenieur, 0, 0, 0, Actif_Disponible);
      Liste := new R_Employe'(Employe, Liste);

      Employe := (To_Tmot("Autop"), To_Tmot("Juliette"), Ingenieur, 0, 0, 0, Actif_Disponible);
      Liste := new R_Employe'(Employe, Liste);

      Employe := (To_Tmot("Sansoucis"), To_Tmot("Marie"), Technicien, 1, 7, 0, Actif_Indisponible);
      Liste := new R_Employe'(Employe, Liste);

      Employe := (To_Tmot("Toutvabien"), To_Tmot("Lucette"), Technicien, 1, 8, 3, Inactif);
      Liste := new R_Employe'(Employe, Liste);

      Employe := (To_Tmot("Tropfort"), To_Tmot("Greg"), Technicien, 3, 12, 0, Actif_Indisponible);
      Liste := new R_Employe'(Employe, Liste);

      Save_Employe(Liste);

   end Set_Employe;


   procedure Set_Kit (
         Ddj : in     R_Date) is
      Kit   : T_Kit;
      Liste : P_Kit;
   begin

      Liste := null;

      Kit := (2014, Veterinaire, Ddj+3, 1, False);
      Liste := new R_Kit'(Kit, Liste);

      Kit := (21412, Veterinaire, Ddj**1, 0, False);
      Liste := new R_Kit'(Kit, Liste);

      Kit := (1917, Phyto_Sanitaire, Ddj**2, 2, True);
      Liste := new R_Kit'(Kit, Liste);

      Kit := (21328, Microbiologique, Ddj*2, 2, True);
      Liste := new R_Kit'(Kit, Liste);

      Save_Kit(Liste);

   end Set_Kit;


   procedure Set_Societe (
         Ddj : in     R_Date) is
      Societe : T_Societe;
      Liste   : P_Societe;
   begin

      Liste := null;

      Societe := (To_Tmot("Belles Vaches"), (1,1,1970), Positif);
      Liste := new R_Societe'(Societe, Liste);

      Societe := (To_Tmot("JeCultive"), Ddj*(-1), Problematique);
      Liste := new R_Societe'(Societe, Liste);

      Societe := (To_Tmot("Mange Tout"), (1,1,1970), Positif);
      Liste := new R_Societe'(Societe, Liste);

      Societe := (To_Tmot("Petits chiens"), (12,10,2016), Positif);
      Liste := new R_Societe'(Societe, Liste);

      Societe := (To_Tmot("Soigne tout"), (22,12,2018), Positif);
      Liste := new R_Societe'(Societe, Liste);

      Societe := (To_Tmot("Supermedoc"), (15,6,2018), Positif);
      Liste := new R_Societe'(Societe, Liste);

      Societe := (To_Tmot("Toutvert"), (10,4,2017), Negatif);
      Liste := new R_Societe'(Societe, Liste);

      Save_Societe(Liste);

   end Set_Societe;


   procedure Set_Audit (
         Ddj : in     R_Date) is
      Liste         : T_Liste_Audit;
      Audit_Attente : T_Audit_Attente;
      Audit_Ec      : T_Audit_En_Cours;
      Audit_H       : T_Audit_Historique;
   begin

      Liste.Attente := null;

      Audit_Attente := (8, 5, Ddj-3, False, Ingenieur, To_Tmot("SoigneTout"), Microbiologique);
      Liste.Attente := new R_Audit_Attente'(Audit_Attente, Liste.Attente);

      Audit_Attente := (9, 2, Ddj-2, False, Technicien, To_Tmot("Jolis Poulets"), Veterinaire);
      Liste.Attente := new R_Audit_Attente'(Audit_Attente, Liste.Attente);

      Audit_Attente := (10, 1, Ddj-2, False, Technicien, To_Tmot("Toutvert"), Phyto_Sanitaire);
      Liste.Attente := new R_Audit_Attente'(Audit_Attente, Liste.Attente);

      --

      Liste.Attente_Urgent := null;

      Audit_Attente := (11, 2, Ddj-3, True, Technicien, To_Tmot("Mangetout"), Analyse_De_Composition);
      Liste.Attente_Urgent := new R_Audit_Attente'(Audit_Attente, Liste.Attente_Urgent);

      Audit_Attente := (12, 2, Ddj-2, True, Ingenieur, To_Tmot("Belles Vaches"), Veterinaire);
      Liste.Attente_Urgent := new R_Audit_Attente'(Audit_Attente, Liste.Attente_Urgent);

      Audit_Attente := (13, 4, Ddj-2, True, Ingenieur, To_Tmot("Mes petits legumes"), Phyto_Sanitaire);
      Liste.Attente_Urgent := new R_Audit_Attente'(Audit_Attente, Liste.Attente_Urgent);

      --

      Liste.En_Cours := null;

      Audit_Ec := (6, 6, Ddj-4, Ddj+1, null, null, null);
      Liste.En_Cours := new R_Audit_En_Cours'(Audit_Ec, Liste.En_Cours);

      Audit_Ec := (7, 5, Ddj-4, Ddj, null, null, null);
      Liste.En_Cours := new R_Audit_En_Cours'(Audit_Ec, Liste.En_Cours);

      --

      Liste.Historique := null;

      --

      Save(Liste);

   end Set_Audit;


   procedure Set_Infos is
      Info : P_Infos;
      I    : T_Infos;
   begin

      I := (21328, To_Tmot("Tropfort"), To_Tmot("Greg"), To_Tmot("Supermedoc"));
      Info := new R_Infos'(I,Info);

      I := (1917, To_Tmot("Sansoucis"), To_Tmot("Marie"), To_Tmot("JeCultive"));
      Info := new R_Infos'(I,Info);

      Save_Infos(Info);

   end Set_Infos;


end Donnees;

