package Date is

   subtype Int31 is Integer range 1..31;
   subtype Int12 is Integer range 1..12;
   type R_Date is
      record
         J : Int31;
         M : Int12;
         A : Positive;
      end record;

   procedure Put (
         D : R_Date);

   procedure Get (
         Date : in out R_Date);

   function Is_Date_Valide (
         Date : R_Date)
     return Boolean;

   function Anterieur (
         D1,
         D2 : R_Date)
     return Boolean;

   function Lendemain (
         Ref : R_Date)
     return R_Date;

   --   function Jour_Suivant (
   --         Ref,
   --         Duree : R_Date)
   --     return R_Date;

   function "+" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date;

   function "-" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date;

   function "*" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date;

   function "**" (
         Ref   : R_Date;
         Duree : Integer)
     return R_Date;

end Date;
