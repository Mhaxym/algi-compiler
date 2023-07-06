with Ada.Text_IO; use Ada.Text_IO;
with semantica.missatges_error; use semantica.missatges_error;
with semantica.ctipus; use semantica.ctipus;

package body semantica.g_codi is

   -- Declaració dels procediments necessaris per a la generació de codi
   -- intermig.

   -- Auxialiars
   procedure nova_var(b: in boolean; d: in desplaçament; oc : in desplaçament;
                      proc: in num_proc; t : out num_var);
   procedure nova_var (b : in boolean; d: in desplaçament; proc: in num_proc;
                       t : out num_var);
   procedure nova_const(v: in valor; t: out num_var; tsb: in tipus_subjacent);
   procedure Genera (e3a :in instr_3a);
   procedure imatgeConstant(val : in valor);
   procedure imatgeVariable(var : in num_var);
   procedure imatgeEtiqueta(eti :in num_etiq);


   procedure gc_procediment (p : in pnode);
   procedure gc_decls (p : in pnode);

   procedure gc_sents (p : in pnode);
   procedure gc_sent_assig(p: in pnode);
   procedure gc_sent_rep(p: in pnode);
   procedure gc_sent_cond(p: in pnode);
   procedure gc_sent_crida(p: in pnode);
   procedure gc_lexpr_sent_crida(p: in pnode; idp: in id_nom);
   procedure gc_exp_sent_crida(p: in pnode; idp: in id_nom);
   -- Referències
   procedure gc_ref (p : in pnode; r, dv:in out num_var;
                     dc: out desplaçament; tsb: out tipus_subjacent);
   procedure gc_ref_id (p : in pnode; idt: out id_nom; r, dv: in out num_var;
                        dc: out desplaçament; tsb: out tipus_subjacent);
   procedure gc_opcions (p: in pnode; dc: in out desplaçament;
                         r, dv: in out num_var; id: in out id_nom;
                         tsb : in tipus_subjacent);
   procedure gc_opcio (p: in pnode; dc: in out desplaçament;
                       r, dv:in out num_var; id: in out id_nom;
                       tsb : in tipus_subjacent);
   procedure gc_lexp_ref (p: in pnode; ida: in id_nom; r, d: in out num_var;
                          ita: in out iterador_Array);
   procedure gc_exp_ref (p: in pnode; ida: in id_nom; r, d: in out num_var;
                         it: in out iterador_Array);
   -- Expressions
   procedure desreferencia (dve, re: in num_var; t: out num_var);
   procedure gc_E (p: in pnode; r,d : in out num_var;
                   tsb : out tipus_subjacent);
   procedure gc_e_aritm (p: in pnode; r1,d1,r2,d2: in num_var;
                         r,d: out num_var);
   procedure gc_e_log (p: in pnode; r,d: out num_var);
   procedure gc_e_log_or (p: in pnode; r,d: out num_var);
   procedure gc_e_lit (p: in pnode; r,d: out num_var;
                       tsb: out tipus_subjacent);
   procedure gc_e_rel_dif (p: in pnode; r1,d1,r2,d2: in num_var;
                           r,d: out num_var);
   procedure gc_e_menys_un_not (p: in pnode; r1,d1: in num_var;
                                r,d: out num_var);
   procedure gc_E_parent(p: in pnode; r1, d1: in num_var; r,d: out num_var);
   -- Auxiliars per a emplenar la taula de símbols
   procedure gc_decl_encap (p: in pnode; idIni: out id_nom;
                            nproc: in num_proc; nparam : out integer);
   procedure gc_decl_args(p: in pnode; idIni: in id_nom; nargs: in out natural);
   -- Declaracions
   procedure gc_decl_var(p : in pnode);
   procedure gc_lid_dvar(p: in pnode; idt: in id_nom);
   procedure gc_id_var(p : in pnode; idt: in id_nom);
   procedure gc_decl_const (p : in pnode);
   procedure gc_decl_const_lid(p: in pnode; idt: in id_nom; v: in valor);
   procedure gc_decl_tipus (p : in pnode);
   procedure gc_decl_subrang (p : in pnode);
   procedure gc_decl_record (p: in pnode);
   procedure gc_decl_camps (p: in pnode; idr : in id_nom;
                            ocup : out desplaçament);
   procedure gc_decl_camp (p: in pnode; idr : in id_nom;
                           ocup : in out desplaçament);
   procedure gc_decl_array (p: in pnode);
   procedure gc_decl_array_lids (p : in pnode; ida: in id_nom;
                                 ncamps, b : in out valor);
   procedure gc_decl_array_id (p : in pnode; ida: in id_nom;
                               ncamps, b : in out valor);
   -- Valor
   procedure gc_valor (p : in pnode; idt : out id_nom;
                       tsb : out tipus_subjacent; val : out valor;
                       pos : out posicio;
                       dt : in descripcio; id: in id_nom);
   procedure gc_valor_elem_neglit (p : in pnode; idt : out id_nom;
                                   tsb : out tipus_subjacent; val : out valor;
                                   pos : out posicio);
   procedure gc_valor_elem_lit (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                                pos : out posicio);
   procedure gc_valor_elem_negid (p : in pnode; idt : out id_nom;
                                  tsb : out tipus_subjacent; val : out valor;
                                  pos : out posicio);
   procedure gc_valor_elem_id (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio);

   -- Desenvolupament dels procediments anteriors:
   -- INICI RUTINES DE GENERACIÓ DE CODI INTERMIG

   -- GENERA CODI
   procedure genera_codi_int is
   begin
      gc_procediment(arrel.arr);
   end genera_codi_int;

   procedure prepara_gen_codi_int (nomf : in String) is
   begin
      create(f3a, out_file, nomf&".txt");
      create(f3b, out_file, nomf&".c3a");
      np := 0; nv := 0; nc := 0; ne := 0;
      tbuida(ts);
      posa_entorn_standard;
   end prepara_gen_codi_int;

   procedure conclou_gen_codi_int is
   begin
      if is_open(f3a) then
         close(f3a);
      end if;
      if is_open(f3b) then
         close(f3b);
      end if;
   end conclou_gen_codi_int;

   --   DECLARA_PROC:
   --       pc_procedure ENCAP pc_is
   --            DECLARACIONS
   --       pc_begin
   --            SENTS
   --       pc_end id s_punticoma
   --    ;
   procedure gc_procediment (p : in pnode) is
      e     : num_etiq;
      e3a   : instr_3a;
      idFin : id_nom;
      nparam: integer;
   begin
      np := np + 1; ne := ne + 1; e := ne;
      profGC := profGC + 1;
      empilar(pilaProc, np);
      gc_decl_encap(p.decl_pargs, idFin, np, nparam); -- Necessari per TS
      tp(np) := (plocal,idFin, profGC, 0, nparam, np, e);
      gc_decls(p.decl_pdecls);
      e3a := (etiq, e);
      Genera(e3a);
      e3a := (pmb, cim(pilaProc));
      Genera(e3a);
      gc_sents(p.decl_psents);
      e3a := (rtn, cim(pilaProc));
      Genera(e3a);
      desempilar(pilaProc);
      profGC := profGC - 1;
      surtBloc(ts); -- Necessari per TS
   end gc_procediment;

   procedure gc_decl_encap (p: in pnode; idIni: out id_nom; nproc : in
                              num_proc; nparam : out integer) is
      d, darg, da : descripcio;
      dt          : descripcio;
      e           : boolean;
      i           : iterador_Proc;
      idarg       : id_nom;
      desp        : desplaçament;
      narg        : natural;
      t           : num_var;
   begin
      d := (d_proc, nproc);
      idIni := p.arguments_id_proc.id_id;
      posa(ts, idIni, d, e);
      nparam := 0;
      narg := 0;
      if p.arguments_params /= null then
         if(p.arguments_params.parametres_args /= null) then
            gc_decl_args(p.arguments_params.parametres_args, idIni, narg);
            entraBloc(ts);
            desp := 12;
            primerProc(ts, idIni, i);
            while es_ValidProc(i) loop
               consultaProc(ts, i, idarg, darg);
               dt := consulta(ts, darg.ta);
               if darg.mode = mode_in then
                  nova_var(false, desp, dt.dt.ocup, cim(pilaProc), t);
                  d := (d_argin, darg.ta, t);
               else
                  nova_var(false, desp, dt.dt.ocup, cim(pilaProc), t);
                  d := (d_argin, darg.ta, t);
               end if;
               desp := desp + 4;
               nparam := nparam + 1;
               succProc(ts, i);
               posa(ts, idarg, d, e);
            end loop;
         end if;
      else
         entraBloc(ts);
      end if;
   end gc_decl_encap;

   procedure gc_decl_args(p: in pnode; idIni: in id_nom; nargs: in out natural) is
      dta, da : descripcio;
      e       : boolean;
      m       : mode_argument;
   begin
      if p.args_args /= null then
         gc_decl_args(p.args_args, idIni, nargs);
      end if;
      m := p.args_d_arg.mode_parametre.tipus_mode;
      da := (d_arg, p.args_d_arg.arg_tipus.id_id, m);
      posaArgument(ts, p.args_d_arg.arg_id.id_id, idIni, da, e);
      nargs := nargs + 1;
   end gc_decl_args;

   --  DECLARACIONS:
   --       DECLARACIONS DECLARACIO
   --    |
   --    ;
   --  DECLARACIO:
   --    |  DECLARA_PROC
   --    ;
   procedure gc_decls (p : in pnode) is
      pa : pnode;
   begin
      if p.declaracions_declaracions /= null then
         gc_decls(p.declaracions_declaracions);
      end if;
      if p.declaracions_declaracio /= null then
         pa := p.declaracions_declaracio.declaracio;
         if pa /= null then
            case pa.tnd is
               when nd_decl_prog => gc_procediment(pa);
               when nd_declara_variable => gc_decl_var(pa);
               when nd_declara_constant => gc_decl_const(pa);
               when nd_declara_tipus => gc_decl_tipus(pa);
               when others => null;
            end case;
         end if;
      end if;
   end gc_decls;

   -- Declaracions necessàries per emplenar la taula de símbols
   procedure gc_decl_var(p : in pnode) is
      pidt : pnode;
      idt  : id_nom;
      d    : descripcio;
   begin
      pidt := p.decl_var_id; idt := pidt.id_id;
      gc_lid_dvar(p.decl_var_l_ids, idt);
   end gc_decl_var;

   procedure gc_lid_dvar(p: in pnode; idt: in id_nom) is
   begin
      if p.l_ids /= null then
         gc_lid_dvar(p.l_ids, idt);
      end if;
      gc_id_var(p.id, idt);
   end gc_lid_dvar;

   procedure gc_id_var(p : in pnode; idt: in id_nom) is
      idv : id_nom;
      d   : descripcio;
      e   : boolean;
      t   : num_var;
   begin
      idv := p.id_id;
      d := consulta(ts,idt);
      nova_var(false, 0, d.dt.ocup, cim(pilaProc), t);
      d := (d_var, idt, t);
      posa(ts, idv, d, e);
   end gc_id_var;

   -- VALOR:
   --  |  id
   procedure gc_valor_elem_id (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
      d, dt : descripcio;
   begin
      d := consulta(ts, p.id_id);
      idt := d.tc;
      dt := consulta(ts, idt);
      tsb := dt.dt.tsb;
      val := d.vc;
      pos := p.id_pos;
   end gc_valor_elem_id;

   --  |  s_menys id
   procedure gc_valor_elem_negid (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
      d, dt : descripcio;
   begin
      d := consulta(ts, p.id_id);
      idt := d.tc;
      dt := consulta(ts, idt);
      tsb := dt.dt.tsb;
      val := - d.vc;
      pos := p.id_pos;
   end gc_valor_elem_negid;

   --     literal
   procedure gc_valor_elem_lit (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
   begin
      idt := id_null;
      tsb := p.lit_tipus;
      val := p.lit_val;
      pos := p.lit_pos;
   end gc_valor_elem_lit;

   --  |  s_menys literal
   procedure gc_valor_elem_neglit (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
   begin
      idt := id_null;
      tsb := p.lit_tipus;
      val := - p.lit_val;
      pos := p.lit_pos;
   end gc_valor_elem_neglit;

   --  VALOR:
   --     literal
   --  |  s_menys literal
   --  |  id
   --  |  s_menys id
   procedure gc_valor (p : in pnode; idt : out id_nom;
                       tsb : out tipus_subjacent; val : out valor;
                       pos : out posicio;
                       dt : in descripcio; id: in id_nom) is
   begin
      if p.v_lit /= null then
         gc_valor_elem_lit(p.v_lit, idt, tsb, val, pos);
      elsif p.v_lit_neg /= null then
         gc_valor_elem_neglit(p.v_lit_neg, idt, tsb, val, pos);
      elsif p.v_id /= null then
         gc_valor_elem_id(p.v_id, idt, tsb, val, pos);
      else
         gc_valor_elem_negid(p.v_id_neg, idt, tsb, val, pos);
      end if;
   end gc_valor;

   --   DECLARA_CONSTANT:
   --	 L_IDS s_dospunts pc_constant id s_assignacio VALOR s_punticoma
   procedure gc_decl_const (p : in pnode) is
      pidt, pvalor : pnode;
      idt, idval   : id_nom;
      dt           : descripcio;
      tsb          : tipus_subjacent;
      v            : valor;
      posi         : posicio;
   begin
      pidt := p.decl_const_tipus;
      idt := pidt.id_id;
      dt := consulta(ts, idt);
      pvalor := p.valor;
      gc_valor(pvalor, idval, tsb, v, posi, dt, idt); -- Analitzam el VALOR
      gc_decl_const_lid(p.decl_const_l_ids, idt, v);
   end gc_decl_const;

   procedure gc_decl_const_lid(p: in pnode; idt: in id_nom; v: in valor) is
      pid   : pnode;
      idv   : id_nom;
      d, dt : descripcio;
      e     : boolean;
      t     : num_var;
   begin

      pid := p.id;
      idv := pid.id_id;
      dt := consulta(ts, idt);
      nova_const(v, t, dt.dt.tsb);
      d := (d_const, idt, v, nv, dt.dt.tsb);
      posa(ts, idv, d, e);
      if p.l_ids /= null then
         gc_decl_const_lid(p.l_ids, idt, v);
      end if;
   end gc_decl_const_lid;

   -- pc_type id pc_is pc_new id pc_range VALOR s_puntpunt VALOR s_punticoma
   procedure gc_decl_subrang (p : in pnode) is
      pidt, pvalor1, pvalor2 : pnode;
      idt, idval1, idval2    : id_nom;
      dtb, dtd               : descripcio;
      dt                     : descr_tipus;
      tsb1, tsb2             : tipus_subjacent;
      v1, v2                 : valor;
      pos1, pos2             : posicio;
      e                      : boolean;
   begin
      pidt := p.decl_subrang_id2;
      idt := pidt.id_id;
      dtb := consulta(ts, idt);

      pvalor1 := p.vinf;
      gc_valor(pvalor1, idval1, tsb1, v1, pos1, dtb, idt);
      pvalor2 := p.vsup;
      gc_valor(pvalor2, idval2, tsb2, v2, pos2, dtb, idt);

      case dtb.dt.tsb is
         when tsb_ent => dt := (tsb_ent, dtb.dt.ocup, v1, v2);
         when tsb_car => dt := (tsb_car, dtb.dt.ocup, v1, v2);
         when tsb_bool => dt := (tsb_bool, dtb.dt.ocup, v1, v2);
         when others => null;
      end case;
      dtd := (d_tipus, dt);
      posa (ts, p.decl_subrang_id1.id_id, dtd, e);
   end gc_decl_subrang;

   --   pc_type id pc_is pc_record
   --     DECLARACIO_CAMPS
   --   pc_end pc_record s_punticoma
   procedure gc_decl_record (p: in pnode) is
      idr  : id_nom;
      dt   : descr_tipus;
      dr   : descripcio;
      ocup : desplaçament;
      e    : boolean;
   begin
      idr := p.decl_record_id.id_id;
      dt := (tsb_record, 0); dr := (d_tipus, dt);
      posa(ts, idr, dr, e);
      if p.decl_record_decl_camps /= null then
         gc_decl_camps(p.decl_record_decl_camps, idr, ocup);
      else
         ocup := 0;
      end if;
      dr.dt.ocup := ocup;
      actualitzaCamp(ts, idr, dr);
   end gc_decl_record;

   procedure gc_decl_camps (p: in pnode; idr : in id_nom;
                            ocup : out desplaçament) is
   begin
      if p.decl_camps /= null then
         gc_decl_camps (p.decl_camps, idr, ocup);
      end if;
      gc_decl_camp(p.decl_camp, idr, ocup);
   end gc_decl_camps;

   procedure gc_decl_camp (p: in pnode; idr : in id_nom;
                           ocup : in out desplaçament) is
      dtc, dc : descripcio;
      e       : boolean;
   begin
      dtc := consulta(ts, p.decl_camp_id2.id_id);
      dc := (d_camp, p.decl_camp_id2.id_id, ocup);
      posaCamp(ts, idr, p.decl_camp_id1.id_id, dc, e);
      ocup := ocup + dtc.dt.ocup;
   end gc_decl_camp;

   procedure gc_decl_array (p: in pnode) is
      dt     : descr_tipus;
      da, dc : descripcio;
      e      : boolean;
      n      : valor := 0;
      ib     : valor := 0;
   begin
      dt := (tsb_array, 0, id_null, 0); da := (d_tipus, dt);
      posa (ts, p.decl_array_id1.id_id, da, e);

      gc_decl_array_lids(p.decl_array_l_ids, p.decl_array_id1.id_id, n, ib);

      dc := consulta(ts, p.decl_array_id2.id_id);
      da.dt.ocup := desplaçament(n) * dc.dt.ocup;
      da.dt.tcomp := p.decl_array_id2.id_id;
      da.dt.b := ib;
      actualitzaCamp(ts, p.decl_array_id1.id_id, da);
   end gc_decl_array;

   procedure gc_decl_array_lids (p : in pnode; ida: in id_nom;
                                 ncamps, b : in out valor) is
   begin
      if p.l_ids /= null then
         gc_decl_array_lids(p.l_ids, ida, ncamps, b);
      end if;
      gc_decl_array_id(p.id, ida, ncamps, b);
   end gc_decl_array_lids;

   procedure gc_decl_array_id (p : in pnode; ida: in id_nom;
                               ncamps, b : in out valor) is
      di, dindex : descripcio;
   begin
      di := consulta(ts, p.id_id);
      dindex := (d_index, p.id_id);
      posaIndex(ts, ida, dindex);
      if ncamps = 0 then
         ncamps := di.dt.lsup - di.dt.linf + 1;
      else
         ncamps := (di.dt.lsup - di.dt.linf + 1) * ncamps;
      end if;
      -- Actalitzam la variable per a la generaciç de codi
      b := b*(di.dt.lsup - di.dt.linf + 1)+di.dt.linf;
   end gc_decl_array_id;

   --DECLARA_TIPUS:
   --     DECLARA_SUBRANG
   --  |  DECLARA_ARRAY
   --  |  DECLARA_RECORD
   procedure gc_decl_tipus (p : in pnode) is
      pa : pnode;
   begin
      pa := p.decl_t;
      if pa /= null then
         case pa.tnd is
            when nd_declara_subrang => gc_decl_subrang(pa);
            when nd_declara_record => gc_decl_record(pa);
            when nd_declara_array => gc_decl_array(pa);
            when others => null;
         end case;
      end if;
   end gc_decl_tipus;

   --  SENTS:
   --       SENTS SENT
   --    |
   --    ;
   --  SENT:
   --       SENT_REP
   --    |  SENT_COND
   --    |  SENT_ASSIG
   --    |  SENT_CRIDA
   --    ;
   procedure gc_sents (p : in pnode) is
      pa : pnode;
   begin
      if p /= null then
         if p.sents /= null then
            gc_sents(p.sents);
         end if;
         if p.sent /= null then
            if p.sent.sent_gen /= null then
               pa := p.sent.sent_gen;
               case pa.tnd is
                  when nd_sent_assig => gc_sent_assig(pa);
                  when nd_sent_rep => gc_sent_rep(pa);
                  when nd_sent_cond => gc_sent_cond(pa);
                  when nd_sent_crida => gc_sent_crida(pa);
                  when others => null;
               end case;
            end if;
         end if;
      end if;
   end gc_sents;

   --  REFERENCIA:
   --       id OPCIONS
   --    ;
   -- Codi per a les referències
   -- r: nº de variable de referència bàsica
   -- dc : desplaçament constant
   -- dv : desplaçament variable
   -- nproc : num_procediment
   procedure gc_ref (p : in pnode; r, dv: in out num_var;
                    dc: out desplaçament; tsb: out tipus_subjacent)
   is
      idt : id_nom;
   begin
       if p.ref_opcions.opcions_opcions = null then
         gc_ref_id(p, idt, r, dv, dc, tsb);
      else
         gc_ref_id(p, idt, r, dv, dc, tsb);
         gc_opcions(p.ref_opcions, dc, r, dv, idt, tsb);
      end if;
   end gc_ref;

   procedure gc_ref_id (p : in pnode; idt: out id_nom; r, dv: in out num_var;
                        dc: out desplaçament; tsb: out tipus_subjacent) is
      dta, dt : descripcio;
      t1      : num_var;
      e3a     : instr_3a;
      e       : num_etiq;
      v       : valor;
   begin
      dta := consulta(ts, p.ref_id.id_id);
      case dta.td is
         when d_var =>
            idt := dta.tv;
            dt := consulta(ts, idt);
            tsb := dt.dt.tsb;
            r := dta.nv;
            dc := 0;
            dv := null_var;
            v := -1;
            nova_const(v,t1,tsb_bool);
            if ((not esBuida(pCert) and not esBuida(pFals)) and then(cim(pCert) /= 0 and cim(pFals) /= 0)) and then tsb = tsb_bool then
               e3a := (if_igual, cim(pCert), r, t1);
               genera(e3a);
               e3a := (goto3a, cim(pFals)); genera(e3a);
            end if;
         when d_const =>
            nova_const(dta.vc, t1, dta.tsb_const);
            r := t1;
            dc := 0;
            dv := null_var;
            idt := dta.tc;
            tsb := dta.tsb_const;
            dt  := consulta(ts, idt);
            if tsb = tsb_bool and dta.vc = 1 then
               e := cim(pCert);
               e3a := (goto3a, e); genera(e3a);
            elsif tsb = tsb_bool and dta.vc = 0 then
               e := cim(pFals);
               e3a := (goto3a, e); genera(e3a);
            end if;
         when d_argin =>
            idt := dta.tain;
            r := dta.nain;
            dt := consulta(ts, dta.tain);
            tsb := dt.dt.tsb;
            dc := 0;
            dv := null_var;
         when others => null;
      end case;
   end gc_ref_id;

   --  OPCIONS:
   --       OPCIONS OPCIO
   --    |
   --    ;
   procedure gc_opcions (p: in pnode; dc: in out desplaçament;
                         r, dv: in out num_var; id: in out id_nom;
                         tsb : in tipus_subjacent) is
   begin
      if p.opcions_opcions /= null then
         gc_opcions(p.opcions_opcions, dc, r, dv, id, tsb);
      end if;
      if p.opcions_opcio /= null then
         if p.opcions_opcio.camp_opcio /= null then
            gc_opcio(p.opcions_opcio.camp_opcio, dc, r, dv, id, tsb);
         end if;
      end if;

   end gc_opcions;

   --   OPCIO:
   --       s_punt id
   --    |  s_parentesiobert L_EXPS s_parentesitancat
   --    ;
   procedure gc_opcio (p: in pnode; dc: in out desplaçament;
                       r, dv: in out num_var; id: in out id_nom;
                       tsb :  in tipus_subjacent) is
      dcc, dtc, da           : descripcio;
      tb, t1, tw, t2, t3, de : num_var;
      idtc                   : id_nom;
      ita                    : iterador_Array;
      e3a                    : instr_3a;
      v                      : valor;
      w                      : desplaçament;
   begin
      if p.tnd /= nd_l_exps then -- RECORD
         consultaCamp(ts, id, p.id_id, dcc);
         dtc := consulta(ts, dcc.tcmp);
         id := dcc.tcmp;
         dc := dc + dcc.dcmp;
      elsif p.tnd = nd_l_exps then -- ARRAY
         de := 0;
         gc_lexp_ref(p, id, r, de, ita);
         da := consulta(ts, id);
         nova_const(da.dt.b, tb, tsb);
         nova_var(false, 0, cim(pilaProc), t1);

         e3a := (resta, t1, de, tb);
         genera(e3a);

         idtc := da.dt.tcomp;
         dtc := consulta(ts, idtc);

         w := dtc.dt.ocup;
         v := Valor(w);
         nova_const(v, tw, tsb);
         nova_var(false, 0, cim(pilaProc), t2);

         e3a := (prod, t2, t1, tw);
         genera(e3a);

         if dv /= null_var then
            nova_var(false, 0, cim(pilaProc), t3);
            e3a := (suma, t3, t2, dv);
            genera(e3a);
            dv := t3;
         else
            dv := t2;
         end if;
         id := idtc;
      end if;
   end gc_opcio;

   procedure gc_lexp_ref (p: in pnode; ida: in id_nom; r, d: in out num_var;
                         ita: in out iterador_Array) is
   begin
      if p.l_exps_l_exps /= null then
         gc_lexp_ref(p.l_exps_l_exps, ida, r, d, ita);
      end if;
      gc_exp_ref(p, ida, r, d, ita);
   end gc_lexp_ref;

   procedure gc_exp_ref (p: in pnode; ida: in id_nom; r, d: in out num_var;
                         it: in out iterador_Array) is
      tsb    : tipus_subjacent;
      dind   : descripcio;
      idtind : id_nom;
      dtind  : descripcio;
      n      : valor;
      e3a    : instr_3a;
      te, t1, t2, tn, dexp, re : num_var;
   begin
      re := 0; dexp := 0;
      gc_E(p.l_exps_e, re, dexp, tsb);
      desreferencia(dexp, re, te);
      if p.l_exps_l_exps = null then
         primerArray(ts, ida, it);
         d := te;
      else
         succArray(ts, it);
         consultaArray(ts, it, dind);
         idtind := dind.d_index_id;
         dtind := consulta(ts, idtind);
         n := dtind.dt.lsup - dtind.dt.linf + 1;
         nova_const(n, tn, tsb_ent);
         nova_var(false, 0, cim(pilaProc), t1);
         e3a := (prod, t1, d, tn);
         genera(e3a);
         nova_var(false, 0, cim(pilaProc), t2);
         e3a := (suma, t2, t1, te);
         genera(e3a);
         d := t2;
      end if;
      end gc_exp_ref;

   -- Generació de codi per a les expressions
   procedure gc_E (p: in pnode; r,d : in out num_var; tsb : out tipus_subjacent) is
      r1, d1, r2, d2, dv : num_var;
      dc                 : desplaçament;
      ec, ef             : num_etiq;
      tsb1, tsb2         : tipus_subjacent;
      t1, t2             : num_var;
      e3a                : instr_3a;
   begin
      r1 := 0; r2 := 0; d1 := 0; d2 := 0; dv := 0;
      case p.tnd is
         when nd_e_op =>
            case p.op is
               when r_mes | r_menys | r_multiplicacio | r_divisio|
                    r_mod=>
                  gc_E(p.pee, r1, d1, tsb1);
                  gc_E(p.ped, r2, d2, tsb2);
                  gc_e_aritm(p, r1, d1, r2, d2, r, d);
                  tsb := tsb_ent;
               when r_and =>
                  gc_e_log(p, r, d);
                  tsb := tsb_bool;
               when r_or =>
                  gc_e_log_or(p, r, d);
                  tsb := tsb_bool;
               when r_diferent | r_relacional =>
                  gc_E(p.pee, r1, d1, tsb1);
                  gc_E(p.ped, r2, d2, tsb2);
                  gc_e_rel_dif (p, r1, d1, r2, d2, r, d);
                  tsb := tsb_bool;
               when r_menys_un =>
                  gc_E(p.pee, r1, d1, tsb);
                  gc_e_menys_un_not(p, r1, d1, r, d);
               when r_not =>
                  ec := cim(pCert); ef := cim(pFals);
                  desempilar(pCert); desempilar(pFals);
                  empilar(pCert, ef); empilar(pFals, ec);
                  gc_E(p.ped, r, d, tsb);
                  ec := cim(pCert); ef := cim(pFals);
                  desempilar(pCert); desempilar(pFals);
                  empilar(pCert, ef); empilar(pFals, ec);
               when r_nula =>
                  gc_E(p.pee, r1, d1, tsb);
                  gc_E_parent(p.pee, r1, d1, r, d);
               when others => null;
            end case;
         when nd_e_lit =>
            gc_e_lit(p, r, d, tsb);
         when nd_e_ref =>
            gc_ref(p.reflit, r, dv, dc, tsb);
            if dc = 0 and then dv = null_var then
               d := null_var;
            elsif dc = 0 and then dv /= null_var then
               d := dv;
            elsif dc /= 0 and then dv = null_var then
               nova_const(valor(dc), t1, tsb_ent);
               d := t1;
            else
               nova_const(valor(dc), t1, tsb_ent);
               nova_var(false, 0, cim(pilaProc), t2);
               e3a := (suma, t2, dv, t1);
               genera(e3a);
               d := t2;
            end if;
         when others => null;
      end case;
   end gc_E;

   --  E:
   --       E s_mes E
   --    |  E s_menys E
   --    |  E s_multiplicacio E
   --    |  E s_divisio E
   --    |  E pc_mod E
   --    |  E pc_and E
   --    |  E pc_or E
   procedure gc_e_aritm (p: in pnode; r1,d1,r2,d2: in num_var;
                         r,d: out num_var) is
      t, t1, t2 : num_var;
      e3a       : instr_3a;
   begin
      desreferencia(d1, r1, t);
      desreferencia(d2, r2, t1);
      nova_var(false, 0, cim(pilaProc), t2); -- t2 := novavar
      case p.op is
         when r_mes =>
            e3a := (suma, t2, t, t1);
         when r_menys =>
            e3a := (resta, t2, t, t1);
         when r_multiplicacio =>
            e3a := (prod, t2, t, t1);
         when r_divisio =>
            e3a := (div, t2, t, t1);
         when r_mod =>
            e3a := (mod3a, t2, t, t1);
         when others => null;
      end case;
      Genera(e3a);
      r := t2;
      d := null_var;
   end gc_e_aritm;

   procedure gc_e_log (p: in pnode; r,d: out num_var) is
      r1, d1, r2, d2, t, t1 : num_var;
      e3a                   : instr_3a;
      ec                    : num_etiq;
      tsb1, tsb2            : tipus_subjacent;
   begin
      r1 := 0; d1 := 0; r2 := 0; d2 := 0;
      ne := ne + 1; ec := ne;
      empilar(pCert, ec);
      gc_E(p.pee, r1, d1, tsb1);
      desreferencia(d1, r1, t);
      ec := cim(pCert); desempilar(pCert);
      e3a := (etiq, ec); genera(e3a);
      gc_E(p.ped, r2, d2, tsb2);
      desreferencia(d2, r2, t1);
      r := t1;
      d := null_var;
   end gc_e_log;

   procedure gc_e_log_or (p: in pnode; r,d: out num_var) is
      r1, d1, r2, d2, t, t1 : num_var;
      e3a                   : instr_3a;
      ef                    : num_etiq;
      tsb1, tsb2            : tipus_subjacent;
   begin
      r1 := 0; d1:= 0; r2 := 0; d2:= 0;
      ne := ne + 1; ef := ne;
      empilar(pFals, ef);
      gc_E(p.pee, r1, d1, tsb1);
      desreferencia(d1, r1, t);
      ef := cim(pFals); desempilar(pFals);
      e3a := (etiq, ef); genera(e3a);
      gc_E(p.ped, r2, d2, tsb2);
      desreferencia(d2, r2, t1);
      r := t1;
      d := null_var;
   end gc_e_log_or;

   --  E:
   --       E s_diferent E
   --    |  E s_relacional E
    procedure gc_e_rel_dif (p: in pnode; r1,d1,r2,d2: in num_var;
                            r,d: out num_var)  is
      t, t1  : num_var;
      e3a    : instr_3a;
      ec, ef : num_etiq;
   begin
      desreferencia(d1, r1, t);
      desreferencia(d2, r2, t1);
      ec := cim(pCert); ef := cim(pFals);
      if p.op = r_diferent then
         e3a := (if_dif, ec, t, t1);
      elsif p.oprel /= null then
         case p.oprel.op_rel is
            when r_igual => e3a := (if_igual, ec, t, t1);
            when r_major => e3a := (if_maj, ec, t, t1);
            when r_major_igual => e3a := (if_maj_ig, ec, t, t1);
            when r_menor => e3a := (if_menor, ec, t, t1);
            when r_menor_igual => e3a := (if_men_ig, ec, t, t1);
            when others => null;
         end case;
      end if;
      Genera(e3a);
      e3a := (goto3a, ef); genera(e3a);
      r := t1;
      d := null_var;
   end gc_e_rel_dif;

   --  E:
   --       s_menys E
   procedure gc_e_menys_un_not (p: in pnode; r1,d1: in num_var;
                                r,d: out num_var) is
      t1, t2 : num_var;
      e3a    : instr_3a;
   begin
      desreferencia(d1, r1, t1);
      nova_var(false, 0, cim(pilaProc), t2);
      e3a := (menys_u, t2, t1);
      Genera(e3a);
      r := t2;
      d := null_var;
   end gc_e_menys_un_not;

   --  E:
   --     literal
   procedure gc_e_lit (p: in pnode; r,d: out num_var; tsb: out tipus_subjacent) is
   begin
      nova_const(p.reflit.lit_val, r, p.reflit.lit_tipus);
      d := null_var;
      tsb := p.reflit.lit_tipus;
   end gc_e_lit;

   procedure gc_E_parent(p: in pnode; r1, d1: in num_var; r,d: out num_var) is
   begin
      r := r1;
      d := d1;
   end gc_E_parent;
   --  SENT_ASSIG:
   --       REFERENCIA s_assignacio E s_punticoma
   procedure gc_sent_assig(p: in pnode) is
      te, t1, t2, t3 : num_var;
      rr, re, de, dv : num_var;
      e3a            : instr_3a;
      ec, ef, efi, e : num_etiq;
      tsb, tsbr      : tipus_subjacent;
      dc             : desplaçament;
   begin
      dv := 0; dc:= 0; re := 0; de := 0;
      rr := 0;
      empilar(pCert,0);
      empilar(pFals, 0);
      gc_ref(p.ref, rr, dv, dc, tsbr);
      desempilar(pCert); desempilar(pFals);
      ne := ne + 1; e := ne;
      empilar(pCert, e);
      ne := ne + 1; e := ne;
      empilar(pFals, e);
      gc_E(p.e, re, de, tsb);
      if tsb /= tsb_bool then
         desreferencia(de, re, te);
         if dc = 0 and then dv = null_var then
            e3a := (copia, rr, te);
            genera(e3a);
         elsif dc = 0 and then dv /= null_var then
            e3a := (ass_index, rr, dv, te);
            genera(e3a);
         elsif dc /= 0 and then dv = null_var then
            nova_const(valor(dc), t1, tsb_ent);
            e3a := (ass_index, rr, t1, te);
            genera(e3a);
         else
            nova_const(valor(dc), t1, tsb_ent);
            nova_var(false, 0, cim(pilaProc), t2);
            e3a := (suma, t2, dv, t1);
            genera(e3a);
            e3a := (ass_index, rr, t2, te);
            genera(e3a);
         end if;
      elsif tsb = tsb_bool then
         ec := cim(pCert);
         e3a := (etiq, ec); genera(e3a);
         nova_var(false, 0, cim(pilaProc), t1);
         nova_const(valor(-1), t2, tsb_ent);
         e3a := (copia, t1, t2); genera(e3a);
         ne := ne + 1; efi := ne;
         e3a := (goto3a, efi); genera(e3a);
         ef := cim(pFals);
         e3a := (etiq, ef); genera(e3a);
         nova_const(valor(0), t3, tsb_ent);
         e3a := (copia, t1, t3); genera(e3a);
         e3a := (etiq, efi); genera(e3a);
         if dc = 0 and then dv = null_var then
            e3a := (copia, rr, t1);
            genera(e3a);
         elsif dc = 0 and then dv /= null_var then
            e3a := (ass_index, rr, dv, te);
            genera(e3a);
         elsif dc /= 0 and then dv = null_var then
            nova_const(valor(dv), t2, tsb_ent);
            e3a := (ass_index, rr, t2, t1);
            genera(e3a);
         else
            nova_const(valor(dc), t2, tsb_ent);
            nova_var(false, 0, cim(pilaProc), t3);
            e3a := (suma, t3, dv, t2);
            genera(e3a);
            e3a := (ass_index, rr, t3, t1);
            genera(e3a);
         end if;
      end if;
      desempilar(pCert); desempilar(pFals);
   end gc_sent_assig;


   --  SENT_REP:
   --       pc_while E pc_loop
   --            SENTS
   --       pc_end pc_loop s_punticoma
   procedure gc_sent_rep(p: in pnode) is
      ei, ef, e : num_etiq;
      r, d      : num_var;
      e3a       : instr_3a;
      tsb       : tipus_subjacent;
   begin
      ne := ne + 1; ei := ne;
      e3a := (etiq, ei); Genera(e3a);
      ne := ne + 1; e := ne;
      empilar(pCert, e);
      ne := ne + 1; e := ne;
      empilar(pFals, e);
      r := 0; d := 0;
      gc_E(p.sent_rep_e, r, d, tsb);
      e := cim(pCert); e3a := (etiq, e); genera(e3a);
      gc_sents(p.sent_rep_sents);
      e3a := (goto3a, ei); Genera(e3a);
      ef := cim(pFals);
      e3a := (etiq, ef); Genera(e3a);
      desempilar(pCert); desempilar(pFals);
   end gc_sent_rep;

   --  SENT_COND:
   --       pc_if E pc_then
   --            SENTS
   --       pc_end pc_if s_punticoma
   --    |  pc_if E pc_then
   --            SENTS
   --       pc_else
   --            SENTS
   --       pc_end pc_if s_punticoma
   --    ;
   procedure gc_sent_cond(p: in pnode) is
      e, efi : num_etiq;
      r, d   : num_var;
      e3a    : instr_3a;
      tsb    : tipus_subjacent;
   begin
      -- Pila etiquetes
      ne := ne + 1; e:= ne;
      empilar(pCert, e);
      ne := ne + 1; e:= ne;
      empilar(pFals, e);
      r := 0; d := 0;
      gc_E(p.sent_cond_e, r, d, tsb);
      -- Etiquetea pCert
      e := cim(pCert); e3a := (etiq, e);
      genera(e3a);
      gc_sents(p.sent_cond_sents);
      if p.sent_cond_esents /= null then
         ne := ne + 1; efi:= ne;
         e3a := (goto3a, efi);
         genera(e3a);
         e := cim(pFals); e3a := (etiq, e);
         genera(e3a);
         gc_sents(p.sent_cond_esents);
         e3a := (etiq, efi);
         genera(e3a);
      else
         e := cim(pFals);
         e3a := (etiq, e);
         genera(e3a);
      end if;
      desempilar(pCert); desempilar(pFals);
   end gc_sent_cond;

   --  SENT_CRIDA:
   --       REFERENCIA s_punticoma
   procedure gc_sent_crida(p: in pnode) is
      idp   : id_nom renames p.sent_crida_referencia.ref_id.id_id;
      d     : descripcio;
      pargs : pnode renames p.sent_crida_referencia.ref_opcions;
      npr   : num_proc;
      e3a   : instr_3a;
      param : parametre;
   begin
      d := consulta(ts, idp);
      npr := d.np;
      if pargs /= null then
         if pargs.opcions_opcio /= null then
            if pargs.opcions_opcio.camp_opcio /= null then
               gc_lexpr_sent_crida(pargs.opcions_opcio.camp_opcio, idp);
               while not esBuida(pparam) loop
                  param := cim(pparam);
                  desempilar(pparam);
                  if param.d = null_var then
                     e3a := (params, param.r);
                     Genera(e3a);
                  else
                     e3a := (paramc, param.r, param.d);
                     Genera(e3a);
                  end if;
               end loop;
            end if;
         end if;
      end if;
      e3a := (call, npr);
      Genera(e3a);
   end gc_sent_crida;

   procedure gc_lexpr_sent_crida(p: in pnode; idp: in id_nom) is
   begin
      if p.l_exps_l_exps /= null then
         gc_lexpr_sent_crida(p.l_exps_l_exps, idp);
      end if;
      gc_exp_sent_crida(p, idp);
   end gc_lexpr_sent_crida;

   procedure gc_exp_sent_crida(p: in pnode; idp: in id_nom) is
      da, dta : descripcio;
      r, d    : num_var;
      tsb     : tipus_subjacent;
      par     : parametre;
   begin
      r := 0; d := 0;
      gc_E(p.l_exps_e, r, d, tsb);
      par := (r, d);
      empilar(pparam, par);
   end gc_exp_sent_crida;

   -- RUTINES AUXILIARS PER A LA GENERACIÓ DE CODI INTERMIG
   procedure desreferencia (dve, re: in num_var; t: out num_var) is
      e3a : instr_3a;
   begin
      if dve = null_var then
         t := re;
      else
         nova_var(false, 0, cim(pilaProc), t);
         e3a := (cons_index, t, re, dve);
         genera(e3a);
      end if;
   end desreferencia;

   procedure nova_var(b: in boolean; d: in desplaçament; oc : in desplaçament;
                      proc: in num_proc; t: out num_var) is
      i : num_var := 0;
   begin
      nv := nv + 1;
      tv(nv) := (var, b, d, oc, proc);
      t := nv;
   end nova_var;

   procedure nova_var (b : in boolean; d: in desplaçament; proc: in num_proc;
                       t : out num_var) is
   begin
      nova_var(b,d,4,proc,t);
   end nova_var;

   procedure nova_const(v: in valor; t: out num_var; tsb: in tipus_subjacent) is
      trobat : boolean := false;
      i      : num_var := 0;
   begin
      while not trobat and i <= nv loop
         -- A l'hora d'afegir la constant, si aquesta ja existeix a la taula
         -- de variables només retornarem l'índex d'aquesta. Si no existeix,
         -- cream la constant i l'afegim.
         if tv(i).mode = const then
            if v = tc(tv(i).val).v and tv(i).tsub = tsb then
               trobat := true;
            end if;
         end if;
         i := i + 1;
      end loop;
      if not trobat then
         nc := nc + 1;
         tc(nc).v := v;
         -- Afegim la nova constant a la taula de variables
         nv := nv + 1;
         tv(nv) := (const, false, nc, tsb);
         t := nv;
      else
         t := i-1;
      end if;
      end nova_const;

   -- Mètode que generarà la sortida d'instruccions de 3 adreçes al fitxer
   -- de sortida.
   procedure imatgeConstant(val :in valor) is
   begin
      put(f3a, val'img(val'img'first+1..val'img'last));
   end imatgeConstant;

   procedure imatgeVariable(var :in num_var) is
   begin
      put(f3a, 't'&var'img(var'img'first+1..var'img'last));
   end imatgeVariable;

   procedure imatgeEtiqueta(eti:in num_etiq) is
   begin
      put(f3a, 'e'&
                 eti'img(eti'img'first+1..eti'img'last));
   end imatgeEtiqueta;

   procedure Genera (e3a : in instr_3a) is
   begin
      write(f3b, e3a); -- Escrivim la instrucció al fitxer binari
      case e3a.tinst is
         when suma | resta | prod | div | mod3a | and3a | or3a =>
            put(f3a,"     "); imatgeVariable(e3a.x);
            put(f3a,":=");
            if tv(e3a.y).mode = const then
               imatgeConstant(tc(tv(e3a.y).val).v);
            else
               imatgeVariable(e3a.y);
            end if;
            case e3a.tinst is
               when suma => put(f3a, "+");
               when resta => put(f3a, "-");
               when prod => put(f3a, "*");
               when div => put(f3a, "/");
               when mod3a => put(f3a, " mod ");
               when and3a => put(f3a, " and ");
               when or3a => put(f3a, " or ");
               when others => null;
            end case;
            if tv(e3a.z).mode = const then
               imatgeConstant(tc(tv(e3a.z).val).v);
            else
               imatgeVariable(e3a.z);
            end if;
            new_line(f3a);

         when not3a =>
            put(f3a,"     "); imatgeVariable(e3a.xn);
            put(f3a,":= not "); imatgeVariable(e3a.yn);
            new_line(f3a);

         when menys_u =>
            put(f3a,"     "); imatgeVariable(e3a.xn);
            put(f3a,":=-");
            if tv(e3a.yn).mode = var then
               imatgeVariable(e3a.yn);
            else
               imatgeConstant(tc(tv(e3a.yn).val).v);
            end if;
            new_line(f3a);

         when copia =>
            put(f3a,"     "); imatgeVariable(e3a.xCop);
            put(f3a,":=");
            if tv(e3a.yCop).mode = const then
               imatgeConstant(tc(tv(e3a.yCop).val).v);
            else
               imatgeVariable(e3a.yCop);
            end if;
            new_line(f3a);

         when cons_index =>
            put(f3a,"     "); imatgeVariable(e3a.xInd);
            put(f3a,":=");
            imatgeVariable(e3a.yInd);
            put(f3a, '[');
            if tv(e3a.zInd).mode = const then
               imatgeConstant(tc(tv(e3a.zInd).val).v);
            else
               imatgeVariable(e3a.zInd);
            end if;
            put_Line(f3a, "]");

         when ass_index =>
            put(f3a,"     "); imatgeVariable(e3a.xAssInd);
            put(f3a,'[');
            if tv(e3a.yAssInd).mode = const then
               imatgeConstant(tc(tv(e3a.yAssInd).val).v);
            else
               imatgeVariable(e3a.yAssInd);
            end if;
            put(f3a,"]:=");
            if tv(e3a.zAssInd).mode = const then
               imatgeConstant(tc(tv(e3a.zAssInd).val).v);
            else
               imatgeVariable(e3a.zAssInd);
            end if;
            new_line(f3a);

         when etiq =>
            imatgeEtiqueta(e3a.e); put(f3a, ": skip"); new_line(f3a);

         when goto3a =>
            put(f3a, "     goto ");imatgeEtiqueta(e3a.eGoTo);
            new_line(f3a);

         when if_menor | if_men_ig | if_dif | if_igual | if_maj_ig | if_maj =>
            put(f3a, "     if ");
            if tv(e3a.xIf).mode = const then
              imatgeConstant(tc(tv(e3a.xIf).val).v);
            else
               imatgevariable(e3a.xIf);
            end if;
            case e3a.tinst is
               when if_menor => put(f3a, "<");
               when if_men_ig => put(f3a, "<=");
               when if_dif => put(f3a, "/=");
               when if_igual => put(f3a, "=");
               when if_maj_ig => put(f3a, ">=");
               when if_maj => put(f3a, ">");
               when others => null;
            end case;
            if tv(e3a.yIf).mode = const then
               imatgeConstant(tc(tv(e3a.yIf).val).v);
            else
               imatgeVariable(e3a.yIf);
            end if;
            put(f3a, " goto ");imatgeEtiqueta(e3a.eIf);
            new_line(f3a);

         when pmb =>
            put_Line(f3a, "     pmb"&e3a.np'img);

         when rtn =>
            put_Line(f3a, "     rtn"&e3a.np'img);

         when call =>
            put_Line(f3a, "     call"&e3a.np'img);

         when params =>
            put(f3a, "     params ");
            imatgeVariable(e3a.xPS);
            new_Line(f3a);

         when paramc =>
            put(f3a, "     paramc ");
            imatgeVariable(e3a.xPC);
            put(f3a, "[");
            imatgeVariable(e3a.yPC);
            put_Line(f3a, "]");
      end case;
   end Genera;

end semantica.g_codi;
