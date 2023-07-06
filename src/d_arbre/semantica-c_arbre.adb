with decls.d_taula_noms; use decls.d_taula_noms;
with decls.declaracions_generals, decls.d_descripcio;
use decls.declaracions_generals, decls.d_descripcio;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
package body semantica.c_arbre is

   -- Generam les fulles de l'arbre amb les rutines lèxiques.

   procedure rl_simb (a:out atribut; pos: in posicio) is
   begin
      a:= null;
   end rl_simb;

   procedure rl_identificador
     (a:out atribut; nom: in String; pos: in posicio) is
      id: id_nom;
   begin
      Posa (tnoms, nom, id);
      a:= new node(nd_id);
      a.id_pos:= pos; a.id_id:= id;
   end rl_identificador;

   procedure rl_lit_str
     (a:out atribut; nom: in String; pos: in posicio) is
      id: id_str;
   begin
      Posa_Str (tnoms, nom (nom'first+1..nom'last-1), id);
      a:= new node(nd_literal);
      a.lit_pos:= pos;
      a.lit_val:= valor(id);
      a.lit_tipus:= tsb_nul;
   end rl_lit_str;

   procedure rl_lit_car (a:out atribut; nom: in String; pos: in posicio) is
   begin
      a:= new node(nd_literal);
      a.lit_pos:= pos;
      a.lit_val:= valor(Character'Pos(nom(nom'First+1)));
      a.lit_tipus:= tsb_car;
   end rl_lit_car;

   procedure rl_lit_ent (a:out atribut; nom: in String; pos: in posicio) is
   begin
      a:= new node(nd_literal);
      a.lit_pos:= pos;
      a.lit_val:= valor'Value(nom);
      a.lit_tipus:= tsb_ent;
   end rl_lit_ent;

   procedure rl_op_rel (a: out atribut; rel: in String; pos: in posicio) is
   begin
      a := new node(nd_e_op_rel);
      if rel = "=" then
         a.op_rel := r_igual;
      elsif rel = ">" then
         a.op_rel := r_major;
      elsif rel = "<" then
         a.op_rel := r_menor;
      elsif rel = ">=" then
         a.op_rel := r_major_igual;
      elsif rel = "<=" then
         a.op_rel := r_menor_igual;
      end if;
      a.posrel := pos;
   end rl_op_rel;


   -- Generam els nodes interns de l'arbre amb les rutines sintàctiques

   procedure rs_programa (programa: out atribut; a:in atribut) is
   begin
      programa := new node(nd_arrel);
      programa.arr := a;
      arrel := programa;
   end rs_programa;

   procedure rs_decl_prog
     (proc: out atribut; args: in atribut; decl : in atribut;
      sents : in atribut; idfinal: in atribut) is
   begin
      proc:= new node(nd_decl_prog);
      proc.decl_pargs := args;
      proc.decl_pdecls := decl;
      proc.decl_psents := sents;
      proc.decl_pidf := idfinal;
   end rs_decl_prog;

   procedure rs_nd_arguments (ndarg : out atribut; id_proc : in atribut;
                              param : in atribut) is
   begin
      ndarg := new node(nd_arguments);
      ndarg.arguments_id_proc := id_proc;
      ndarg.arguments_params := param;
   end rs_nd_arguments;

   procedure rs_nd_arguments (ndarg : out atribut; id_proc : in atribut) is
   begin
      ndarg:= new node(nd_arguments);
      ndarg.arguments_id_proc := id_proc;
      ndarg.arguments_params := null;
   end rs_nd_arguments;

   procedure rs_nd_parametres (ndpar : out atribut; args: in atribut) is
   begin
      ndpar := new node(nd_parametres);
      ndpar.parametres_args := args;
   end rs_nd_parametres;

   procedure rs_nd_args
     (ndargs: out atribut; args : in atribut; arg: in atribut) is
   begin
      ndargs := new node(nd_args);
      ndargs.args_args := args;
      ndargs.args_d_arg := arg;
   end rs_nd_args;

   procedure rs_nd_args (ndargs: out atribut; arg: in atribut) is
   begin
      ndargs := new node(nd_args);
      ndargs.args_args := null;
      ndargs.args_d_arg := arg;
   end rs_nd_args;

   procedure rs_nd_d_arg
     (darg : out atribut;arg_id: in atribut;
      mode : in atribut; tip: in atribut)is
   begin
      darg := new node(nd_d_arg);
      darg.arg_id := arg_id;
      darg.mode_parametre := mode;
      darg.arg_tipus := tip;
   end rs_nd_d_arg;

   procedure rs_nd_mode_parametre_in (mod_in: out atribut) is
   begin
      mod_in := new node(nd_mode_parametre);
      mod_in.tipus_mode := mode_in;
   end rs_nd_mode_parametre_in;

   procedure rs_nd_mode_parametre_out (mod_in: out atribut) is
   begin
      mod_in := new node(nd_mode_parametre);
      mod_in.tipus_mode := mode_out;
   end rs_nd_mode_parametre_out;

   procedure rs_nd_mode_parametre_inout (mod_in: out atribut) is
   begin
      mod_in := new node(nd_mode_parametre);
      mod_in.tipus_mode := mode_inout;
   end rs_nd_mode_parametre_inout;

   -- Rutines sintàctiques de les declaracions

   procedure rs_nd_declaracions
     (ndecls : out atribut; decls: in atribut; decl: in atribut) is
   begin
      ndecls := new node(nd_declaracions);
      ndecls.declaracions_declaracions := decls;
      ndecls.declaracions_declaracio := decl;
   end rs_nd_declaracions;

   procedure rs_nd_declaracions (ndecls : out atribut) is
   begin
      ndecls := new node(nd_declaracions);
      ndecls.declaracions_declaracions := null;
      ndecls.declaracions_declaracio := null;
   end rs_nd_declaracions;

   procedure rs_nd_declaracio(ndecl : out atribut; decl_gen : in atribut) is
   begin
      ndecl := new node(nd_declaracio);
      ndecl.declaracio := decl_gen;
   end rs_nd_declaracio;

   procedure rs_nd_declara_variable
     (declvar: out atribut; lids: in atribut; tip: in atribut) is
   begin
      declvar := new node(nd_declara_variable);
      declvar.decl_var_l_ids := lids;
      declvar.decl_var_id := tip;
   end rs_nd_declara_variable;

   procedure rs_nd_l_ids
     (lids: out atribut; lid: in atribut; id: in atribut) is
   begin
      lids := new node(nd_l_ids);
      lids.l_ids := lid;
      lids.id := id;
   end rs_nd_l_ids;

   procedure rs_nd_l_ids (lids: out atribut;id: in atribut) is
   begin
      lids := new node(nd_l_ids);
      lids.l_ids := null;
      lids.id := id;
   end rs_nd_l_ids;

   procedure rs_nd_declara_constant
     (declconst : out atribut; lids: in atribut;
      tip : in atribut; valor: in atribut) is
   begin
      declconst := new node(nd_declara_constant);
      declconst.decl_const_l_ids:= lids;
      declconst.decl_const_tipus:=tip;
      declconst.valor := valor;
   end rs_nd_declara_constant;

   procedure rs_nd_valor_lit (valit: out atribut; lit: in atribut) is
   begin
      valit := new node(nd_valor);
      valit.v_lit := lit;
      valit.v_lit_neg := null;
      valit.v_id := null;
      valit.v_id_neg := null;
   end rs_nd_valor_lit;

   procedure rs_nd_valor_lit_menys (valit: out atribut; litn: in atribut) is
   begin
      valit := new node(nd_valor);
      valit.v_lit := null;
      valit.v_lit_neg := litn;
      valit.v_id := null;
      valit.v_id_neg := null;
   end rs_nd_valor_lit_menys;

   procedure rs_nd_valor_id (valid: out atribut; id: in atribut) is
   begin
      valid := new node(nd_valor);
      valid.v_lit := null;
      valid.v_lit_neg := null;
      valid.v_id := id;
      valid.v_id_neg := null;
   end rs_nd_valor_id;

   procedure rs_nd_valor_id_menys (valid: out atribut; idn: in atribut) is
   begin
      valid := new node(nd_valor);
      valid.v_lit := null;
      valid.v_lit_neg := null;
      valid.v_id := null;
      valid.v_id_neg := idn;
   end rs_nd_valor_id_menys;

   procedure rs_nd_declara_tipus (decltip : out atribut; tipus: in atribut) is
   begin
      decltip := new node(nd_declara_tipus);
      decltip.decl_t := tipus;
   end rs_nd_declara_tipus;

   procedure rs_nd_declara_subrang
     (declrng: out atribut; id1: in atribut; id2: in atribut;
      vinf: in atribut; vsup: in atribut) is
   begin
      declrng := new node(nd_declara_subrang);
      declrng.decl_subrang_id1 := id1;
      declrng.decl_subrang_id2 := id2;
      declrng.vinf := vinf;
      declrng.vsup := vsup;
   end rs_nd_declara_subrang;

   procedure rs_nd_declara_array
     (declarr: out atribut; id1: in atribut;
      lids: in atribut; id2: in atribut) is
   begin
      declarr := new node(nd_declara_array);
      declarr.decl_array_id1 := id1;
      declarr.decl_array_l_ids := lids;
      declarr.decl_array_id2 := id2;
   end rs_nd_declara_array;

   procedure rs_nd_declara_record
     (declrec: out atribut; id: in atribut; decl_camp : in atribut) is
   begin
      declrec := new node(nd_declara_record);
      declrec.decl_record_id := id;
      declrec.decl_record_decl_camps := decl_camp;
   end rs_nd_declara_record;

   procedure rs_nd_declaracio_camps
     (dclcmps: out atribut; cmps: in atribut; cmp: in atribut) is
   begin
      dclcmps := new node(nd_declaracio_camps);
      dclcmps.decl_camps := cmps;
      dclcmps.decl_camp := cmp;
   end rs_nd_declaracio_camps;

   procedure rs_nd_declaracio_camps (dclcmps: out atribut; cmp: in atribut) is
   begin
      dclcmps := new node(nd_declaracio_camps);
      dclcmps.decl_camps := null;
      dclcmps.decl_camp := cmp;
   end rs_nd_declaracio_camps;

   procedure rs_nd_declaracio_camp
     (dclcmp: out atribut; id1: in atribut; id2: in atribut) is
   begin
      dclcmp := new node(nd_declaracio_camp);
      dclcmp.decl_camp_id1 := id1;
      dclcmp.decl_camp_id2 := id2;
   end rs_nd_declaracio_camp;

   -- Rutines sintàctiques de les sentències

   procedure rs_nd_sents
     (ndsent: out atribut; sents: in atribut; sent: in atribut) is
   begin
      ndsent := new node(nd_sents);
      ndsent.sents := sents;
      ndsent.sent := sent;
   end rs_nd_sents;

   procedure rs_nd_sents(ndsent: out atribut) is
   begin
      ndsent := new node(nd_sents);
      ndsent.sents := null;
      ndsent.sent := null;
   end rs_nd_sents;

   procedure rs_nd_sent(dsent: out atribut; sent: in atribut) is
   begin
      dsent := new node(nd_sent);
      dsent.sent_gen := sent;
   end rs_nd_sent;

   procedure rs_nd_sent_rep
     (srep: out atribut; e: in atribut; sents: in atribut) is
   begin
      srep := new node(nd_sent_rep);
      srep.sent_rep_e := e;
      srep.sent_rep_sents := sents;
   end rs_nd_sent_rep;

   procedure rs_nd_sent_cond
     (scond : out atribut; e: in atribut; sent: in atribut) is
   begin
      scond := new node(nd_sent_cond);
      scond.sent_cond_e := e;
      scond.sent_cond_sents := sent;
      scond.sent_cond_esents := null;
   end rs_nd_sent_cond;

   procedure rs_nd_sent_cond
     (scond : out atribut; e: in atribut;
      sent: in atribut; esent: in atribut) is
   begin
      scond := new node(nd_sent_cond);
      scond.sent_cond_e := e;
      scond.sent_cond_sents := sent;
      scond.sent_cond_esents := esent;
   end rs_nd_sent_cond;

   procedure rs_nd_sent_assig
     (sass: out atribut; ref : in atribut; e: in atribut) is
   begin
      sass := new node(nd_sent_assig);
      sass.ref := ref;
      sass.e := e;
   end rs_nd_sent_assig;

   procedure rs_nd_referencia
     (ref : out atribut; id: in atribut; opc: in atribut) is
   begin
      ref := new node(nd_referencia);
      ref.ref_id := id;
      ref.ref_opcions := opc;
   end rs_nd_referencia;

   procedure rs_nd_opcions
     (ndopcs : out atribut; opos: in atribut; op: in atribut) is
   begin
      ndopcs := new node(nd_opcions);
      ndopcs.opcions_opcions := opos;
      ndopcs.opcions_opcio := op;
   end rs_nd_opcions;

   procedure rs_nd_opcions (ndopcs : out atribut) is
   begin
      ndopcs := new node(nd_opcions);
      ndopcs.opcions_opcions := null;
      ndopcs.opcions_opcio := null;
   end rs_nd_opcions;

   procedure rs_nd_opcio(ndopc : out atribut; camp: in atribut) is
   begin
      ndopc := new node(nd_opcio);
      ndopc.camp_opcio := camp;
   end rs_nd_opcio;

   procedure rs_nd_l_exps
     (lexp : out atribut; lexps: in atribut; e: in atribut) is
   begin
      lexp := new node(nd_l_exps);
      lexp.l_exps_l_exps := lexps;
      lexp.l_exps_e := e;
   end rs_nd_l_exps;

   procedure rs_nd_l_exps(lexp : out atribut;e: in atribut) is
   begin
      lexp := new node(nd_l_exps);
      lexp.l_exps_l_exps := null;
      lexp.l_exps_e := e;
   end rs_nd_l_exps;

   procedure rs_nd_sent_crida(scrid : out atribut; ref: in atribut) is
   begin
      scrid := new node(nd_sent_crida);
      scrid.sent_crida_referencia := ref;
   end rs_nd_sent_crida;

   -- Rutines sintàctiques per a l'expressió

   procedure rs_nd_e_op_mes
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_mes;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_mes;

   procedure rs_nd_e_op_menys
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_menys;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_menys;

   procedure rs_nd_e_op_multiplicacio
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_multiplicacio;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_multiplicacio;

   procedure rs_nd_e_op_divisio
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_divisio;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_divisio;

   procedure rs_nd_e_op_mod
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_mod;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_mod;

   procedure rs_nd_e_op_and
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_and;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_and;

   procedure rs_nd_e_op_or
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_or;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_or;

   procedure rs_nd_e_op_diferent
     (eop: out atribut; e1: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_diferent;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_diferent;

   procedure rs_nd_e_op_relacional
     (eop: out atribut; e1: in atribut; rel: in atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_relacional;
      eop.oprel := rel;
      eop.ped := e2;
   end rs_nd_e_op_relacional;

   procedure rs_nd_e_op_munitari (eop: out atribut; e1: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_menys_un;
      eop.oprel := null;
      eop.ped := null;
   end rs_nd_e_op_munitari;

   procedure rs_nd_e_op_expun (eop: out atribut; e1: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := e1;
      eop.op := r_nula;
      eop.oprel := null;
      eop.ped := null;
   end rs_nd_e_op_expun;

   procedure rs_nd_e_op_not (eop: out atribut; e2: in atribut) is
   begin
      eop := new node(nd_e_op);
      eop.pee := null;
      eop.op := r_not;
      eop.oprel := null;
      eop.ped := e2;
   end rs_nd_e_op_not;

   procedure rs_nd_e_ref (eref: out atribut; ref1: in atribut) is
   begin
      eref := new node(nd_e_ref);
      eref.reflit := ref1;
   end rs_nd_e_ref;

   procedure rs_nd_e_lit (elit: out atribut; lit1: in atribut) is
   begin
      elit := new node(nd_e_lit);
      elit.reflit := lit1;
   end rs_nd_e_lit;


end semantica.c_arbre;
