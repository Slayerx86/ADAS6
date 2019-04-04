with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

package body Date is


   procedure Put (
         D : R_Date) is
   begin

      Put(D.J, 0);
      Put('/');
      Put(D.M, 0);
      Put('/');
      Put(D.A, 0);

   end Put;


   procedure Get (
         Date : in out R_Date) is

      S : String (1 .. 10);
      K : Integer;

   begin

      loop

         Date := (30,2,1);
         Get_Line(S, K);

         begin

            if (S(2) = '/') then
               if (S(4) = '/') then
                  Date.J := Integer'Value(S(1..1));
                  Date.M := Integer'Value(S(3..3));
                  Date.A := Integer'Value(S(5..K));
               elsif (S(5) = '/') then
                  Date.J := Integer'Value(S(1..1));
                  Date.M := Integer'Value(S(3..4));
                  Date.A := Integer'Value(S(6..K));
               end if;
            elsif (S(3) = '/') then
               if (S(5) = '/') then
                  Date.J := Integer'Value(S(1..2));
                  Date.M := Integer'Value(S(4..4));
                  Date.A := Integer'Value(S(6..K));
               elsif (S(6) = '/') then
                  Date.J := Integer'Value(S(1..2));
                  Date.M := Integer'Value(S(4..5));
                  Date.A := Integer'Value(S(7..K));
               end if;
            end if;

            if (Is_Date_Valide(Date)) then
               exit;
            else
               Put("Date non valide. Resaisir : ");
            end if;

         exception
            when others =>
               Put("Date non valide. Resaisir : ");

         end;

      end loop;

   end Get;


   function Bissextile (
         A : Positive)
     return Boolean is
   begin
      if ( (A mod 4 = 0 and A mod 100 /= 0) or A mod 400 = 0) then
         return True;
      else
         return False;
      end if;
   end Bissextile;


   function Is_Date_Valide (
         Date : R_Date)
     return Boolean is
   begin

      case Date.M is

         when 2 =>
            if (Date.J <= 28) then
               return True;
            elsif (Date.J = 29 and then Bissextile(Date.A)) then
               return True;
            else
               return False;
            end if;

         when 4|6|9|11 =>
            if (Date.J <= 30) then
               return True;
            else
               return False;
            end if;

         when others =>
            return True;

      end case;

   end Is_Date_Valide;


   function Anterieur (
         D1,
         D2 : R_Date)
     return Boolean is
   begin

      if (D1.A < D2.A) then

         return True;

      elsif (D1.A > D2.A) then

         return False;

      else

         if (D1.M < D2.M) then

            return True;

         elsif (D1.M > D2.M) then

            return False;

         else

            if (D1.J < D2.J) then
               return True;
            else
               return False;
            end if;

         end if;

      end if;

   end Anterieur;


   function Lendemain (
         Ref : R_Date)
     return R_Date is

   begin

      case Ref.M is

         when 2 =>
            if (Ref.J = 28) then
               if (Bissextile(Ref.A)) then
                  return (29, 2, Ref.A);
               else
                  return (1, 3, Ref.A);
               end if;
            elsif (Ref.J > 28) then
               return (1, 3, Ref.A);
            else
               return (Ref.J+1, Ref.M, Ref.A);
            end if;

         when 12 =>
            if (Ref.J = 31) then
               return (1, 1, Ref.A+1);
            else
               return (Ref.J+1, Ref.M, Ref.A);
            end if;

         when 4|6|9|11 =>
            if (Ref.J = 30) then
               return (1, Ref.M+1, Ref.A);
            else
               return (Ref.J+1, Ref.M, Ref.A);
            end if;

         when others =>
            if (Ref.J = 31) then
               return (1, Ref.M+1, Ref.A);
            else
               return (Ref.J+1, Ref.M, Ref.A);
            end if;

      end case;

   end Lendemain;


   function "+" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date is

      D : R_Date := Ref;

   begin

      for I in 1..Duree loop
         D := Lendemain(D);
      end loop;

      return D;

   end "+";


   function "-" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date is

      D : R_Date := Ref;

   begin

      for I in 1..Duree loop

         case D.J is

            when 1 =>
               case D.M is
                  when 1 =>
                     D.M := 12;
                     D.A := D.A - 1;
                  when others =>
                     D.M := D.M - 1;
               end case;
               D.J := 31;
               while (not Is_Date_Valide(D)) loop
                  D.J := D.J - 1;
               end loop;

            when others =>
               D.J := D.J - 1;

         end case;

      end loop;

      return D;

   end "-";


   function "*" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date is

      D : R_Date := Ref;

   begin

      if (Duree = 0) then

         return D;

      elsif (Duree > 0) then

         for I in 1..Duree loop
            case D.M is
               when 12 =>
                  D.M := 1;
                  D.A := D.A + 1;
               when others =>
                  D.M := D.M + 1;
            end case;
         end loop;

      else

         for I in 1..-Duree loop
            case D.M is
               when 1 =>
                  D.M := 12;
                  D.A := D.A - 1;
               when others =>
                  D.M := D.M - 1;
            end case;
         end loop;

      end if;

      if (not Is_Date_Valide(D)) then
         D := Lendemain(D);
      end if;

      return D;

   end "*";


   function "**" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date is

      D : R_Date := Ref;

   begin

      D.A := D.A + Duree;

      return D;

   end "**";


end Date;
