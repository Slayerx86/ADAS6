with Date, Donnees;
use Date, Donnees;

procedure Boot is
   D : R_Date := (1, 3, 2019);
begin

   Set_Employe;
   Set_Kit(D);
   Set_Societe(D);

   Set_Audit(D);
   Set_Infos;

end Boot;
