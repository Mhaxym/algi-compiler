
package semantica.c_arbre is
   -- Rutines lèxiques que constuiran les fulles de l'arbre

   procedure rl_simb (a: out atribut; pos: in posicio);
   procedure rl_identificador
     (a: out atribut; nom: in String; pos: in posicio);
   procedure rl_lit_str (a: out atribut; nom: in String; pos: in posicio);
   procedure rl_lit_ent (a: out atribut; nom: in String; pos: in posicio);
   procedure rl_lit_car (a: out atribut; nom: in String; pos: in posicio);
   procedure rl_op_rel (a: out atribut; rel: in String; pos: in posicio);
   -- Rutines sintàctiques que construiran els nodes interiors de l'arbre

   procedure rs_programa (programa: out atribut; a:in atribut);
   procedure rs_decl_prog
     (proc: out atribut; args: in atribut; decl : in atribut;
      sents : in atribut; idfinal: in atribut);
   procedure rs_nd_arguments
     (ndarg : out atribut; id_proc : in atribut; param : in atribut);
   procedure rs_nd_arguments (ndarg : out atribut; id_proc : in atribut);
   procedure rs_nd_parametres (ndpar : out atribut; args: in atribut);
   procedure rs_nd_args
     (ndargs: out atribut; args : in atribut; arg: in atribut);
   procedure rs_nd_args (ndargs: out atribut; arg: in atribut);
   procedure rs_nd_d_arg
     (darg : out atribut;arg_id: in atribut;
      mode : in atribut; tip: in atribut);
   procedure rs_nd_mode_parametre_in (mod_in: out atribut);
   procedure rs_nd_mode_parametre_out (mod_in: out atribut);
   procedure rs_nd_mode_parametre_inout (mod_in: out atribut);

   -- Declaracions

   procedure rs_nd_declaracions
     (ndecls : out atribut; decls: in atribut; decl: in atribut);
   procedure rs_nd_declaracions (ndecls : out atribut);
   procedure rs_nd_declaracio(ndecl : out atribut; decl_gen : in atribut);
   procedure rs_nd_declara_variable
     (declvar: out atribut; lids: in atribut; tip: in atribut);
   procedure rs_nd_l_ids (lids: out atribut; lid: in atribut; id: in atribut);
   procedure rs_nd_l_ids (lids: out atribut;id: in atribut);
   procedure rs_nd_declara_constant
     (declconst : out atribut; lids: in atribut;
      tip : in atribut; valor: in atribut);
   procedure rs_nd_valor_lit (valit: out atribut; lit: in atribut);
   procedure rs_nd_valor_lit_menys (valit: out atribut; litn: in atribut);
   procedure rs_nd_valor_id (valid: out atribut; id: in atribut);
   procedure rs_nd_valor_id_menys (valid: out atribut; idn: in atribut);
   procedure rs_nd_declara_tipus (decltip : out atribut; tipus: in atribut);
   procedure rs_nd_declara_subrang
     (declrng: out atribut; id1: in atribut; id2: in atribut;
      vinf: in atribut; vsup: in atribut);
   procedure rs_nd_declara_array
     (declarr: out atribut; id1: in atribut;
      lids: in atribut; id2: in atribut);
   procedure rs_nd_declara_record
     (declrec: out atribut; id: in atribut; decl_camp : in atribut);
   procedure rs_nd_declaracio_camps
     (dclcmps: out atribut; cmps: in atribut; cmp: in atribut);
   procedure rs_nd_declaracio_camps (dclcmps: out atribut; cmp: in atribut);
   procedure rs_nd_declaracio_camp
     (dclcmp: out atribut; id1: in atribut; id2: in atribut);

   -- Sentències

   procedure rs_nd_sents
     (ndsent: out atribut; sents: in atribut; sent: in atribut);
   procedure rs_nd_sents
     (ndsent: out atribut);
   procedure rs_nd_sent
     (dsent: out atribut; sent: in atribut);
   procedure rs_nd_sent_rep
     (srep: out atribut; e: in atribut; sents: in atribut);
   procedure rs_nd_sent_cond
     (scond : out atribut; e: in atribut; sent: in atribut);
   procedure rs_nd_sent_cond
     (scond : out atribut; e: in atribut; sent: in atribut; esent: in atribut);
   procedure rs_nd_sent_assig
     (sass: out atribut; ref : in atribut; e: in atribut);
   procedure rs_nd_referencia
     (ref : out atribut; id: in atribut; opc: in atribut);
   procedure rs_nd_opcions
     (ndopcs : out atribut; opos: in atribut; op: in atribut);
   procedure rs_nd_opcions
     (ndopcs : out atribut);
   procedure rs_nd_opcio
     (ndopc : out atribut; camp: in atribut);
   procedure rs_nd_l_exps
     (lexp : out atribut; lexps: in atribut; e: in atribut);
   procedure rs_nd_l_exps
     (lexp : out atribut; e: in atribut);
   procedure rs_nd_sent_crida(scrid : out atribut; ref: in atribut);

   -- Expressió

   procedure rs_nd_e_op_mes
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_menys
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_multiplicacio
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_divisio
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_mod
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_and
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_or
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_diferent
     (eop: out atribut; e1: in atribut; e2: in atribut);
   procedure rs_nd_e_op_relacional
     (eop: out atribut; e1: in atribut; rel: in atribut; e2: in atribut);
   procedure rs_nd_e_op_munitari
     (eop: out atribut; e1: in atribut);
   procedure rs_nd_e_op_expun
     (eop: out atribut; e1: in atribut);
   procedure rs_nd_e_op_not
     (eop: out atribut; e2: in atribut);
   procedure rs_nd_e_ref
     (eref: out atribut; ref1: in atribut);
   procedure rs_nd_e_lit
     (elit: out atribut; lit1: in atribut);

end semantica.c_arbre;
