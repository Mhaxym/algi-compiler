
with decls.declaracions_generals; use decls.declaracions_generals;
with Ada.Containers; use Ada.Containers;

package decls.d_taula_noms is
   type taula_noms is limited private;

   -- Taula Noms
   procedure tbuida (tn : out taula_noms);
   procedure posa
     (tn : in out taula_noms; nom : in string; id : out id_nom);
   function consulta
     (tn : in taula_noms; id : in id_nom) return string;

   -- Taula Strings
   procedure posa_str
     (tn : in out taula_noms; s : in string; id: out id_str);
   function consulta_str
     (tn : in taula_noms; id : in id_str) return string;

   -- Excepcions
   desbordament_capacitat : exception;
   mal_us: exception;

private

   b : constant Ada.Containers.Hash_Type := Ada.Containers.Hash_Type(max_id);
   subtype indexTD is Ada.Containers.Hash_Type range 0..b-1;

   type element_tid is
      record
         ic : natural; -- Punter a l'array de noms.
         sh : id_nom;  -- Següent de hashing.
      end record;

   type t_disp is array (indexTD) of id_nom;
   type t_ident is array (id_nom) of element_tid;
   type t_str is array (id_str) of natural;
   subtype t_caracter is string(1..max_car);

   type taula_noms is
      record

         -- Taula identificadors
         td : t_disp;
         nid: id_nom;
         tid: t_ident;

         -- Taula caràcters
         tc : t_caracter;
         nc : natural;

         -- Taula strings
         tstr:t_str;
         nstr:id_str;
         nombre_strings: natural;
      end record;
end decls.d_taula_noms;
