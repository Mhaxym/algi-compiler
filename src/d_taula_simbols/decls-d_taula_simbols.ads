with decls.d_descripcio; use decls.d_descripcio;
with decls.declaracions_generals; use decls.declaracions_generals;
with decls.d_taula_noms; use decls.d_taula_noms;

package decls.d_taula_simbols is

   type t_simbols is limited private;

   -- Algoritmes generals de la taula de símbols
   procedure tbuida (ts : out t_simbols);
   procedure posa
     (ts : in out t_simbols; id: in id_nom; d: in descripcio; e: out boolean);
   function consulta
     (ts: in out t_simbols; id : in  id_nom) return descripcio;

   -- Algoritmes per a la gestió de records
   procedure posaCamp
     (ts: in out t_simbols; idr, idc : id_nom;
      dc: in descripcio; e : out boolean);
   procedure consultaCamp
     (ts : in t_simbols; idr, idc :in id_nom; dc : out descripcio);
   procedure actualitzaCamp
     (ts: in out t_simbols; id: in id_nom; dc: in descripcio);

   -- Algoritmes per a la gestió de arrays
   type iterador_Array is private;

   procedure posaIndex
     (ts: in out t_simbols; ida: in id_nom; dind: in descripcio);
   procedure primerArray
     (ts: in out t_simbols; ida: id_nom; it: out iterador_Array);
   procedure succArray
     (ts: in out t_simbols; it: in out iterador_Array);
   function es_ValidArray
     (it: in iterador_Array) return boolean;
   procedure consultaArray
     (ts: in out t_simbols; it: in iterador_Array; dind: out descripcio);

   -- Algoritmes per a la gestió de procediments
   type iterador_Proc is private;
   procedure posaArgument
     (ts :in out t_simbols; idarg, idproc: in id_nom;
      darg: in descripcio; e: out boolean);
   procedure primerProc
     (ts: in t_simbols; idproc: in id_nom; it : out iterador_Proc);
   procedure succProc
     (ts: in t_simbols; it: in out iterador_Proc);
   function es_ValidProc
     (it: in iterador_Proc) return boolean;
   procedure consultaProc
     (ts: in t_simbols; it: in iterador_Proc;
      idarg: out id_nom; darg: out descripcio);

   -- Algoritmes per al control de la profunditat
   type profunditat is private;
   type iExpansio is private;

   procedure entraBloc(ts: in out t_simbols);
   procedure surtBloc(ts: in out t_simbols);

   -- Algoritmes per a fer proves
   procedure infoTD
     (ts: in t_simbols; i: in integer; d : out descripcio_tipus;
      prof: out integer; succ: out integer);
   procedure infoTE
     (ts: in t_simbols; i: in integer; idExp: out id_nom; prof: out integer;
      d: out descripcio_tipus; succ: out integer);
   procedure infoTA (ts: in t_simbols; i: in integer; a: out integer);
   function consProf(ts: in t_simbols) return integer;
   function consProfGlobal(ts: in t_simbols) return integer;

   mal_us, conflicte : exception;

private

   type iExpansio is new integer range 0..max_id;
   type profunditat is new integer range -1..100;

   type bloc_tdesc is
      record
         np: profunditat;
         d : descripcio;
         p : iExpansio; -- Punter al següent bloc
      end record;

   type bloc_texp is
      record
         id: id_nom;
         np: profunditat;
         d : descripcio;
         scc: iExpansio;
      end record;

   type t_descripcio is array (id_nom) of bloc_tdesc;
   type t_expansio is array (iExpansio) of bloc_texp;
   type t_ambit is array (profunditat) of iExpansio;

   type t_simbols is
      record
      np: profunditat;
      td: t_descripcio;
      te: t_expansio;
      ta: t_ambit;
   end record;

   type iterador_Array is
      record
      itArr :iExpansio;
   end record;

   type iterador_Proc is
      record
      itProc : iExpansio;
   end record;

end decls.d_taula_simbols;
