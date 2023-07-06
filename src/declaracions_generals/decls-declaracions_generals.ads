
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Declaracions generals que s'utilitzsaran a qualsevol altre package que les
-- necessiti.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

package decls.declaracions_generals is

   max_id : constant integer := 1021;
   max_str: constant integer := 1024;
   max_car: constant integer := 4096;

   type id_nom is new integer range 0..max_id;
   id_null : constant id_nom :=0;
   type id_str is new integer range 0..max_str;

   subtype etiqueta is string;

   max_var: constant integer:= 1024;
   max_const : constant integer := 1024;
   max_proc: constant integer:= 512;
   max_etiquetes: constant integer:= 2048;
   max_i3a : constant integer:= 4096;

   type num_var is new natural range 0..max_var;
   type num_proc is new natural range 0..max_proc;
   type num_etiq is new natural range 0..max_etiquetes;
   type num_const is new natural range 0..max_const;
   type num_i3a is new natural range 0 ..max_i3a;
   null_var: constant num_var := 0;

   type valor is new integer;
   type desplaçament is new integer;

   type posicio is
    record
         lin : natural;
         col : natural;
      end record;

   type parametre is
      record
         r : num_var;
         d : num_var;
      end record;
   type num_par is new natural range 1..128;
end decls.declaracions_generals;
