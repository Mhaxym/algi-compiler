with decls.d_descripcio, decls.declaracions_generals;
use decls.declaracions_generals, decls.d_descripcio;

package decls.d_arbre is
   type tipusnode is
     (nd_null, nd_arrel,
      nd_id, nd_literal, nd_valor,
      nd_decl_prog, nd_arguments, nd_parametres, nd_args, nd_d_arg,
      nd_mode_parametre, nd_declaracions, nd_declaracio, nd_declara_variable,
      nd_l_ids, nd_declara_constant, nd_declara_tipus,
      nd_declara_subrang, nd_declara_array, nd_declara_record,
      nd_declaracio_camps, nd_declaracio_camp,
      nd_sents, nd_sent, nd_sent_rep, nd_sent_cond, nd_sent_assig,
      nd_sent_crida,
      nd_referencia, nd_opcions, nd_opcio, nd_l_exps,
      nd_e_op, nd_e_ref, nd_e_op_rel, nd_e_lit);

   type node;
   type pnode is access node;
   procedure recorregut (p: in pnode; profAct: in integer);
   subtype atribut is pnode;
   type mode_variable is (var, const);
   type operacio is (r_mes, r_menys, r_multiplicacio, r_divisio, r_mod,
                     r_and, r_or, r_diferent, r_relacional, r_menys_un,
                     r_not, r_nula);
   type relacional is (r_igual, r_menor, r_major, r_menor_igual, r_major_igual);
   type node (tnd: tipusnode) is
      record
         case tnd is
            when nd_null =>
               null;
            when nd_id =>
               id_id: id_nom;
               id_pos: posicio;
            when nd_literal =>
               lit_val:   valor;
               lit_pos:   posicio;
               lit_tipus: tipus_subjacent;

            when nd_valor =>
               v_lit:     pnode;
               v_lit_neg: pnode;
               v_id:      pnode;
               v_id_neg:  pnode;

            when nd_arrel =>
               arr: pnode;

            when nd_decl_prog =>
               decl_pargs:    pnode;
               decl_pdecls:   pnode;
               decl_psents:   pnode;
               decl_pidf:     pnode;

            when nd_arguments =>
               arguments_id_proc: pnode;
               arguments_params:  pnode;

            when nd_parametres =>
               parametres_args: pnode;

            when nd_args =>
               args_args:  pnode;
               args_d_arg: pnode;

            when nd_d_arg =>
               arg_id :        pnode;
               mode_parametre: pnode;
               arg_tipus:      pnode;

            when nd_mode_parametre =>
               tipus_mode: mode_argument;

            when nd_declaracions =>
               declaracions_declaracions: pnode;
               declaracions_declaracio:   pnode;

            when nd_declaracio =>
               declaracio : pnode;

            when nd_declara_variable =>
               decl_var_l_ids: pnode;
               decl_var_id:    pnode;

            when nd_l_ids =>
               l_ids: pnode;
               id:    pnode;

            when nd_declara_constant =>
               decl_const_l_ids: pnode;
               decl_const_tipus: pnode;
               valor:            pnode;

            when nd_declara_tipus =>
               decl_t : pnode;

            when nd_declara_subrang =>
               decl_subrang_id1:    pnode;
               decl_subrang_id2:    pnode;
               vinf:                pnode;
               vsup:                pnode;

            when nd_declara_array =>
               decl_array_id1:   pnode;
               decl_array_l_ids: pnode;
               decl_array_id2:   pnode;

            when nd_declara_record =>
               decl_record_id:         pnode;
               decl_record_decl_camps: pnode;

            when nd_declaracio_camps =>
               decl_camps: pnode;
               decl_camp:  pnode;

            when nd_declaracio_camp =>
               decl_camp_id1: pnode;
               decl_camp_id2: pnode;

            when nd_sents =>
               sents: pnode;
               sent:  pnode;

            when nd_sent =>
               sent_gen : pnode;

            when nd_sent_rep =>
               sent_rep_e:     pnode;
               sent_rep_sents: pnode;

            when nd_sent_cond =>
               sent_cond_e:      pnode;
               sent_cond_sents: pnode;
               sent_cond_esents: pnode;

            when nd_sent_assig =>
               ref:        pnode;
               e:          pnode;

            when nd_referencia =>
               ref_id:      pnode;
               ref_opcions: pnode;

            when nd_opcions =>
               opcions_opcions: pnode;
               opcions_opcio:   pnode;

            when nd_opcio =>
               camp_opcio:     pnode;

            when nd_l_exps =>
               l_exps_l_exps: pnode;
               l_exps_e:      pnode;

            when nd_sent_crida =>
               sent_crida_referencia: pnode;

            when nd_e_op =>
               pee: pnode;
               op:  operacio;
               oprel : pnode;
               ped: pnode;

            when nd_e_op_rel =>
               op_rel : relacional;
               posrel: posicio;

            when nd_e_ref | nd_e_lit =>
               reflit : pnode;

         end case;
      end record;
end decls.d_arbre;
