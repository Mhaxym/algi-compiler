with decls.declaracions_generals, decls.d_descripcio, decls.d_taula_simbols,
decls.d_arbre;
use decls.declaracions_generals, decls.d_descripcio, decls.d_taula_simbols,
decls.d_arbre;

package decls.codi_3_a is
   -- Taula de Variables
   type infoVariable (mode : mode_variable := var) is record
      parametre : boolean; -- Si és paràmetre o variable
      case mode is
         when var =>
            despl : desplaçament;
            ocup  : desplaçament;
            nproc : num_proc;
         when const =>
            val : num_const;
            tsub : tipus_subjacent;
         when others => null;
      end case;
   end record;


   type t_variable is array (num_var'First..num_var'Last) of infoVariable;

   type infoConstant is
      record
         v   : valor;
         nvr : num_var;
      end record;

   type t_constant is array
        (num_const'First..num_const'Last) of infoConstant;

   --Taula de Procediments
   type mode_procediment is (plocal, pextern);
   type infoProcediment (mode : mode_procediment := pextern) is record
      id : id_nom;
      prof : integer;
      ocupVarLoc : desplaçament;
      nparam : integer;
      nproc : num_proc;
      case mode is
         when plocal => et : num_etiq;
         when pextern => null;
      end case;
   end record;

   type t_procediments is array (num_proc'First..num_proc'Last)
     of infoProcediment;

   -- Instruccions necessàries per a la generació del codi de 3 adreçes
   type Instruccions is
     (suma, resta, prod, div, mod3a, and3a, or3a, not3a, menys_u,
      copia, cons_index, ass_index,
      etiq, goto3a, if_menor, if_men_ig, if_dif, if_igual, if_maj_ig, if_maj,
      pmb, rtn, params, paramc, call);
   type instr_3a (tinst : Instruccions := rtn) is record
      case tinst is
         when suma | resta | prod | div | mod3a | and3a | or3a =>
            x, y, z : num_var;
         when menys_u | not3a =>
            xn, yn  : num_var;
         when copia =>
            xCop, yCop : num_var;
         when cons_index =>
            xInd, yInd, zInd : num_var;
         when ass_index =>
            xAssInd, yAssInd, zAssInd : num_var;
         when etiq =>
            e : num_etiq;
         when goto3a =>
            eGoTo : num_etiq;
         when if_menor | if_men_ig | if_dif | if_igual | if_maj_ig | if_maj
            =>
            eIf : num_etiq;
            xIf, yIf : num_var;
         when pmb | rtn | call=>
            np : num_proc;
         when params =>
            xPS : num_var;
         when paramc =>
            xPC, yPC : num_var;
      end case;
   end record;
   type t_c3a is array (num_i3a'first..num_i3a'last) of instr_3a;
end decls.codi_3_a;
