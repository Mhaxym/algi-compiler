with decls.declaracions_generals; use decls.declaracions_generals;

package decls.d_descripcio is

   type descripcio_tipus is
     ( d_var, d_const, d_tipus, d_proc, d_nula, d_camp, d_arg, d_argin,
      d_index);

   type mode_argument is
     (mode_in, mode_out, mode_inout);

   type tipus_subjacent is
     (tsb_bool, tsb_car, tsb_ent, tsb_array, tsb_record, tsb_nul, tsb_proc);

   type descr_tipus(tsb: tipus_subjacent:= tsb_nul) is
    record
      ocup: desplaçament;
      case tsb is
        when tsb_bool | tsb_car | tsb_ent  =>
          linf,lsup: valor;
        when tsb_array =>
            tcomp: id_nom;
            b: valor;
        when tsb_record | tsb_nul | tsb_proc =>
          null;
        end case;
      end record;

   type descripcio(td: descripcio_tipus:= d_nula) is
      record
         case td is
            when d_nula  =>
               null;
            when d_var   =>
               tv: id_nom;
               nv: num_var;
            when d_const =>
               tc: id_nom;
               vc: valor;
               nv_const: num_var;
               tsb_const: tipus_subjacent;
            when d_tipus =>
               dt: descr_tipus;
            when d_proc  =>
               np: num_proc;
            when d_camp  =>
               tcmp: id_nom;
               dcmp: desplaçament;
            when d_arg  =>
               ta: id_nom;
               mode: mode_argument;
            when d_argin =>
               tain: id_nom;
               nain: num_var;
            when d_index =>
               d_index_id : id_nom;
         end case;
      end record;
end decls.d_descripcio;
