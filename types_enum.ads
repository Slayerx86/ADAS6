package Types_Enum is


   function To_Capitalise (
         S : String)
     return String;

   ---------------------------------------

   subtype T_Mot is String(1..30);

   procedure Put_Mot (
         M : in     T_Mot);

   function To_Tmot (
         S : String)
     return T_Mot;

   ---------------------------------------

   subtype T_Duree is Integer range 1..10;

   procedure Get_Duree (
         Duree : in out T_Duree);

   ---------------------------------------

   type T_Nature is
         (Veterinaire,
          Phyto_Sanitaire,
          Microbiologique,
          Analyse_De_Composition);

   procedure Put (
         T : in     T_Nature);

   procedure Get (
         T : in out T_Nature);

   ---------------------------------------

   type T_Qualite is
         (Technicien,
          Ingenieur);

   procedure Put (
         T : in     T_Qualite);

   procedure Get (
         T : in out T_Qualite);

   ---------------------------------------

   type T_Status is
         (Actif_Disponible,
          Actif_Indisponible,
          Inactif);

   procedure Put (
         T : in     T_Status);

   procedure Get (
         T : in out T_Status);

   ---------------------------------------

   type T_Resultat is
         (Positif,
          Negatif,
          Problematique);

   procedure Put (
         T : in     T_Resultat);

   procedure Get (
         T : in out T_Resultat);

end Types_Enum;

