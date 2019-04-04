with Ada.Text_Io;
use Ada.Text_Io;

package body Societe is

   procedure Put (
         S : in     T_Societe) is
   begin

      Put_Mot(S.Nom);
      Put(' ');
      Put(S.Date);
      Put(' ');
      Put(S.Res);

   end Put;

   procedure Put (
         S : in     P_Societe) is
   begin

      if (S /= null) then
         Put(S.Atr);
         New_Line;
         Put(S.Next);
      else
         New_Line;
      end if;

   end Put;

   procedure Load_Societe (
         Liste :    out P_Societe) is
      File : F_Societe.File_Type;
      S    : T_Societe;
   begin

      Liste := null;

      Open(File, In_File, "societe.arc");

      while (not End_Of_File(File)) loop
         Read(File, S);
         Liste := new R_Societe'(S, Liste);
      end loop;

      Close(File);

   end Load_Societe;


   procedure Save_Societe (
         Liste : P_Societe) is

      File : F_Societe.File_Type;

      procedure Save (
            S : in     P_Societe) is
      begin
         if (S.Next /= null) then
            Save(S.Next);
         end if;
         Write(File, S.Atr);
      end Save;

   begin

      Create(File, Append_File, "societe.arc");
      Save(Liste);
      Close(File);

   end Save_Societe;

   function Find (
         N : T_Mot;
         S : P_Societe)
     return P_Societe is
   begin

      if (S = null) then
         return null;
      elsif (S.Atr.Nom = N) then
         return S;
      else
         return Find(N, S.Next);
      end if;

   end Find;

end Societe;