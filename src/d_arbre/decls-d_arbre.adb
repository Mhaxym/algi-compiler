with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
package body decls.d_arbre is

   procedure recorregut (p:in pnode; profAct: in integer) is
      tnd : tipusnode renames p.tnd;
      i: integer := 0;
      prof : integer;
   begin
      if (p /= null) then
         for i in 0..profAct loop
            Put(" ");
         end loop;
         prof := profAct + 1;
         case (tnd) is
         when nd_decl_prog =>
            put_Line("nd_decl_prog");
            recorregut(p.decl_pargs, prof);
            recorregut(p.decl_pdecls, prof);
            recorregut(p.decl_psents, prof);
            recorregut(p.decl_pidf, prof);

         when nd_null =>
            put_Line("nd_null");

         when nd_id =>
            put_Line("nd_id");

         when nd_literal =>
            put_Line("nd_literal");

         when nd_valor =>
            put_Line("nd_valor");
            if (p.v_lit /= null) then
               recorregut(p.v_lit, prof);
            end if;
            if p.v_lit_neg /= null then
               recorregut(p.v_lit_neg, prof);
            end if;
            if p.v_id /= null then
               recorregut(p.v_id, prof);
            end if;
            if p.v_id_neg /= null then
               recorregut(p.v_id_neg, prof);
            end if;

         when nd_arrel =>
            put_Line("nd_arrel");
            recorregut(p.arr, prof);

         when nd_arguments =>
            put_Line("nd_arguments");
            recorregut(p.arguments_id_proc, prof);
            if p.arguments_params /= null then
               recorregut(p.arguments_params, prof);
            end if;

         when nd_parametres =>
            put_Line("nd_parametres");
            recorregut(p.parametres_args, prof);

         when nd_args =>
            put_Line("nd_args");
            if p.args_args /= null then
               recorregut(p.args_args, prof);
            end if;
            recorregut(p.args_d_arg, prof);

         when nd_d_arg =>
            put_Line("nd_d_arg");
            recorregut(p.arg_id, prof);
            recorregut(p.mode_parametre, prof);
            recorregut(p.arg_tipus, prof);

         when nd_mode_parametre =>
            Put_Line("nd_mode_parametre");

         when nd_declaracions =>
            put_Line("nd_declaracions");
            if p.declaracions_declaracions /= null then
               recorregut(p.declaracions_declaracions, prof);
            end if;
            if p.declaracions_declaracio /= null then
               recorregut(p.declaracions_declaracio, prof);
            end if;
         when nd_declaracio =>
            put_Line("nd_declaracio");
            recorregut(p.declaracio, prof);

         when nd_declara_variable =>
            put_Line("nd_declara_variable");
            recorregut(p.decl_var_l_ids, prof);
            recorregut(p.decl_var_id, prof);

         when nd_l_ids =>
            put_Line("nd_l_ids");
            if (p.l_ids /= null) then
               recorregut(p.l_ids, prof);
            end if;
            recorregut(p.id, prof);

         when nd_declara_constant =>
            put_Line("nd_declara_constant");
            recorregut(p.decl_const_l_ids, prof);
            recorregut(p.decl_const_tipus, prof);
            recorregut(p.valor, prof);

         when nd_declara_tipus =>
            put_Line("nd_declara_tipus");
            recorregut(p.decl_t, prof);

         when nd_declara_subrang =>
            put_Line("nd_declara_subrang");
            recorregut(p.decl_subrang_id1, prof);
            recorregut(p.decl_subrang_id2, prof);
            recorregut(p.vinf, prof);
            recorregut(p.vsup, prof);

         when nd_declara_array =>
            put_Line("nd_declara_array");
            recorregut(p.decl_array_id1, prof);
            recorregut(p.decl_array_l_ids, prof);
            recorregut(p.decl_array_id2, prof);

         when nd_declara_record =>
            put_Line("decl_record");
            recorregut(p.decl_record_id, prof);
            recorregut(p.decl_record_decl_camps, prof);

         when nd_declaracio_camps =>
            put_Line("nd_declaracio_camps");
            if p.decl_camps /= null then
               recorregut(p.decl_camps, prof);
            end if;
            recorregut(p.decl_camp, prof);

         when nd_declaracio_camp =>
            put_Line("nd_declaracio_camp");
            recorregut(p.decl_camp_id1, prof);
            recorregut(p.decl_camp_id2, prof);

         when nd_sents =>
            put_Line("nd_sents");
            if p.sents /= null then
               recorregut(p.sents, prof);
            end if;
            if p.sent /= null then
               recorregut(p.sent, prof);
            end if;
         when nd_sent =>
            put_Line("nd_sent");
            recorregut(p.sent_gen, prof);

         when nd_sent_rep =>
            put_Line("nd_sent_rep");
            recorregut(p.sent_rep_e, prof);
            recorregut(p.sent_rep_sents, prof);

         when nd_sent_cond =>
            put_Line("nd_sent_cond");
            recorregut(p.sent_cond_e, prof);
            recorregut(p.sent_cond_sents, prof);
            if p.sent_cond_esents /= null then
               recorregut(p.sent_cond_esents, prof);
            end if;

         when nd_sent_assig =>
            put_Line("nd_sent_assig");
            recorregut(p.ref, prof);
            recorregut(p.e, prof);

         when nd_referencia =>
            put_Line("nd_referencia");
            recorregut(p.ref_id, prof);
            recorregut(p.ref_opcions, prof);

         when nd_opcions =>
            put_Line("nd_opcions");
            if p.opcions_opcions /= null then
               recorregut(p.opcions_opcions, prof);
            end if;
            if p.opcions_opcio /= null then
               recorregut(p.opcions_opcio, prof);
            end if;

         when nd_opcio =>
            put_Line("nd_opcio");
            recorregut(p.camp_opcio, prof);

         when nd_l_exps =>
            put_Line("nd_l_exps");
            if p.l_exps_l_exps /= null then
               recorregut(p.l_exps_l_exps, prof);
            end if;
            recorregut(p.l_exps_e, prof);

         when nd_sent_crida =>
            put_Line("nd_sent_crida");
            recorregut(p.sent_crida_referencia, prof);

         when nd_e_op =>
            put_Line("nd_e_op");
            if p.pee /= null then
               recorregut(p.pee, prof);
            end if;
            if p.ped /= null then
               recorregut(p.ped, prof);
            end if;
            if p.oprel /= null then
               recorregut(p.oprel, prof);
            end if;

         when nd_e_op_rel =>
            put_Line("nd_e_op_rel");

         when nd_e_ref | nd_e_lit =>
            recorregut(p.reflit, prof);

         end case;
      end if;
   end recorregut;
end decls.d_arbre;
