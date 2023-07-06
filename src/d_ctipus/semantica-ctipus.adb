with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with semantica.missatges_error; use semantica.missatges_error;
with semantica.g_codi; use semantica.g_codi;

package body semantica.ctipus is
   error : exception;

   -- Rutines necessàries per a la comprovació de tipus.
   -- Procediment
   procedure ct_procediment(p : in pnode);
   procedure ct_decl_encap(p: in pnode; idIni: out id_nom);
   procedure ct_decl_decls(p: in pnode);
   procedure ct_decl_sents(p: in pnode);


   -- Encap
   procedure ct_decl_args(p: in pnode; idIni: in id_nom);

   -- Declaracions
   procedure ct_decl_var(p : in pnode);
   procedure ct_lid_dvar(p: in pnode; idt: in id_nom);
   procedure ct_id_var(p : in pnode; idt: in id_nom);
   procedure ct_decl_const_lid(p: in pnode; idt: in id_nom; v: in valor);
   procedure ct_valor_elem_id
     (p : in pnode; idt : out id_nom;tsb : out tipus_subjacent;
      val : out valor; pos : out posicio);
   procedure ct_decl_tipus (p : in pnode);
   procedure ct_decl_subrang (p : in pnode);
   procedure ct_decl_record (p: in pnode);
   procedure ct_decl_camps
     (p: in pnode; idr : in id_nom; ocup : out desplaçament);
   procedure ct_decl_camp
     (p: in pnode; idr : in id_nom; ocup : in out desplaçament);
   procedure ct_decl_array (p: in pnode);
   procedure ct_decl_array_lids
     (p : in pnode; ida: in id_nom; ncamps, b :in out valor);
   procedure ct_decl_array_id
     (p : in pnode; ida: in id_nom; ncamps, b : in out valor);
   -- Expressions
   procedure ct_referencia
     (p: in pnode; idt: out id_nom; tsb : out tipus_subjacent;
      esVar : out boolean; pos : out posicio);
   procedure ct_referencia_id
     (p: in pnode; idt: out id_nom; tsb : out tipus_subjacent;
      esVar : out boolean; pos : out posicio);
   procedure ct_opcions
     (p: in pnode; idt:in  out id_nom; tsb : in out tipus_subjacent;
      esVar : in out boolean; pos : in out posicio);
   procedure ct_opcio
     (p: in pnode; idt: in out id_nom; tsb : in out tipus_subjacent;
      esVar :in  out boolean; pos :in  out posicio);
   procedure ct_lexp_ref
     (p: in pnode; ida: in id_nom; ita: in out iterador_array);
   procedure ct_exp_ref
     (p: in pnode; ida: in id_nom; ita: in out iterador_Array);
   procedure ct_exp
     (p: in pnode; ide: out id_nom; tsbe : out tipus_subjacent;
      esVar : out boolean; pose : out posicio);
   procedure ct_e_aritm
     (ide: out id_nom; id1, id2: in id_nom; tsbe : out tipus_subjacent;
      tsb1, tsb2: in tipus_subjacent; pos1, pos2: in posicio);
   procedure ct_e_log
     (ide: out id_nom; id1, id2: in id_nom;tsbe : out tipus_subjacent;
      tsb1, tsb2: in tipus_subjacent; pos1, pos2: in posicio);
   procedure ct_e_rel_dif
     (ide: out id_nom; id1, id2: in id_nom; tsbe : out tipus_subjacent;
      tsb1, tsb2: in tipus_subjacent; pos1, pos2: in posicio);
   procedure ct_e_not
     (ide: out id_nom; id1: in id_nom; tsbe : out tipus_subjacent;
      tsb1: in tipus_subjacent; pos1: in posicio);
   procedure ct_e_menys_un
     (ide: out id_nom; id1: in id_nom; tsbe : out tipus_subjacent;
      tsb1: in tipus_subjacent; pos1: in posicio);
   procedure ct_exp_parentesi
     (ide: out id_nom; id1: in id_nom; tsbe : out tipus_subjacent;
      tsb1: in tipus_subjacent; pos1: in posicio);
   procedure ct_e_lit
     (p: in pnode; ide: out id_nom; tsbe: out tipus_subjacent;
      pose : out posicio);

   -- Sentències
   procedure ct_sent_assig( p: in pnode);
   procedure ct_sent_cond_repeticio( p: in pnode);
   procedure ct_sent_crida( p: in pnode);
   procedure ct_lexpr_sent_crida(p: in pnode; idp: in id_nom;
                                 it: in out iterador_Proc);
   procedure ct_exp_sent_crida(p: in pnode; idp: in id_nom;
                               it: in out iterador_Proc);


   procedure prepara_analisi is
   begin
      tbuida(tnoms); tbuida(ts);
      creaFitxer;
      posa_entorn_standard;
   end prepara_analisi;

   procedure comprova_tipus is
   begin
      ct_procediment(arrel.arr);
   end comprova_tipus;


   -- Rutines de comprovació de tipus del programa a compilar
   --   DECLARA_PROC:
   --       pc_procedure ENCAP pc_is
   --            DECLARACIONS
   --       pc_begin
   --            SENTS
   --       pc_end id s_punticoma
   --    ;
   procedure ct_procediment(p : in pnode) is
      idIni : id_nom;
   begin
      ct_decl_encap(p.decl_pargs, idIni);
      ct_decl_decls(p.decl_pdecls);
      ct_decl_sents(p.decl_psents);
      if idIni /= p.decl_pidf.id_id then
         me_nomProcedimentErroni(p.decl_pargs.arguments_id_proc.id_pos, idIni, p.decl_pidf.id_id);
         raise error;
      end if;
      surtBloc(ts);
   exception
      when error => errorCompilacio := true;
   end ct_procediment;

   procedure ct_decl_encap(p: in pnode; idIni: out id_nom) is
      d, darg, da : descripcio;
      e           : boolean;
      i           : iterador_Proc;
      idarg       : id_nom;
   begin
      np := np + 1;
      d := (d_proc, np);
      idIni := p.arguments_id_proc.id_id;
      posa(ts, idIni, d, e);
      if e then
         me_noNomProcediment(idIni, p.arguments_id_proc.id_pos);
         raise error;
      end if;

      if p.arguments_params /= null then
         if(p.arguments_params.parametres_args /= null) then
            ct_decl_args(p.arguments_params.parametres_args, idIni);
         end if;
      end if;
      entraBloc(ts);
      primerProc(ts, idIni, i);
      while es_ValidProc(i) loop
         consultaProc(ts, i, idarg, darg);
         succProc(ts, i);
         posa(ts, idarg, darg, e);
      end loop;
   exception
      when error => errorCompilacio := true;
   end ct_decl_encap;

   procedure ct_decl_args(p: in pnode; idIni: in id_nom) is
      dta, da : descripcio;
      e       : boolean;
      m       : mode_argument;
   begin
      if p.args_args /= null then
         ct_decl_args(p.args_args, idIni);
      end if;
      dta := consulta(ts, p.args_d_arg.arg_tipus.id_id);
      if dta.td /= d_tipus then
         me_notipus(p.args_d_arg.arg_id.id_pos,
                          p.args_d_arg.arg_id.id_id);
         raise error;
      end if;

      nv := nv + 1;
      m := p.args_d_arg.mode_parametre.tipus_mode;
      if m = mode_in then
         da := (d_argin, p.args_d_arg.arg_tipus.id_id, nv);
      elsif m = mode_inout or m = mode_out then
         da := (d_var, p.args_d_arg.arg_tipus.id_id, nv);
      end if;

      posaArgument(ts, p.args_d_arg.arg_id.id_id, idIni, da, e);
      if e then
         me_noArgValid(p.args_d_arg.arg_id.id_id,
                             p.args_d_arg.arg_id.id_pos);
         raise error;
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_decl_args;

   procedure ct_decl_var(p : in pnode) is
      pidt : pnode;
      idt  : id_nom;
      d    : descripcio;
   begin
      pidt := p.decl_var_id; idt := pidt.id_id;
      d := consulta(ts, idt); -- id del tipus
      if d.td /= d_tipus then
         me_notipus(pidt.id_pos, idt);
         raise error;
      end if;
      ct_lid_dvar(p.decl_var_l_ids, idt);
   exception
      when error => errorCompilacio := true;
   end ct_decl_var;

   procedure ct_lid_dvar(p: in pnode; idt: in id_nom) is
   begin
      if p.l_ids /= null then
         ct_lid_dvar(p.l_ids, idt);
      end if;
      ct_id_var(p.id, idt);
   end ct_lid_dvar;

   procedure ct_id_var(p : in pnode; idt: in id_nom) is
      idv : id_nom;
      d   : descripcio;
      e   : boolean;
   begin

      idv := p.id_id;
      nv := nv + 1; -- Faltarà afegir-ho a la taula de variables
      d := (d_var, idt, nv);
      posa(ts, idv, d, e);
      if e then
         me_existeix(p.id_pos, idv, " la variable");
         raise error;
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_id_var;

 -- VALOR:
 --  |  id
   procedure ct_valor_elem_id (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
      d, dt : descripcio;
   begin
      d := consulta(ts, p.id_id);
      if d.td /= d_const then
         me_noConstant(p.id_pos, d.td);
         raise error;
      end if;
      idt := d.tc;
      dt := consulta(ts, idt);
      tsb := dt.dt.tsb;
      val := d.vc;
      pos := p.id_pos;
   exception
      when error => errorCompilacio := true;
   end ct_valor_elem_id;

--  |  s_menys id
   procedure ct_valor_elem_negid (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
      d, dt : descripcio;
   begin
      d := consulta(ts, p.id_id);
      if d.td /= d_const then
         me_noConstant(p.id_pos, d.td);
         raise error;
      end if;
      idt := d.tc;
      dt := consulta(ts, idt);
      tsb := dt.dt.tsb;
      if tsb /= tsb_ent then
         me_noEnter(p.id_pos, tsb);
         raise error;
      end if;
      val := - d.vc;
      pos := p.id_pos;
   exception
      when error => errorCompilacio := true;
   end ct_valor_elem_negid;

--     literal
   procedure ct_valor_elem_lit (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
   begin
      idt := id_null;
      tsb := p.lit_tipus;
      val := p.lit_val;
      pos := p.lit_pos;
   end ct_valor_elem_lit;

--  |  s_menys literal
   procedure ct_valor_elem_neglit (p : in pnode; idt : out id_nom;
                               tsb : out tipus_subjacent; val : out valor;
                               pos : out posicio) is
   begin
      idt := id_null;
      tsb := p.lit_tipus;
      val := - p.lit_val;
      pos := p.lit_pos;
   end ct_valor_elem_neglit;

--  VALOR:
--     literal
--  |  s_menys literal
--  |  id
--  |  s_menys id
--  ;

   procedure ct_valor (p : in pnode; idt : out id_nom;
                       tsb : out tipus_subjacent; val : out valor;
                       pos : out posicio;
                       dt : in descripcio; id: in id_nom) is
   begin
      if p.v_lit /= null then
         ct_valor_elem_lit(p.v_lit, idt, tsb, val, pos);
      elsif p.v_lit_neg /= null then
         ct_valor_elem_neglit(p.v_lit_neg, idt, tsb, val, pos);
      elsif p.v_id /= null then
         ct_valor_elem_id(p.v_id, idt, tsb, val, pos);
      else
         ct_valor_elem_negid(p.v_id_neg, idt, tsb, val, pos);
      end if;
      if idt = id_null then
         if tsb /= dt.dt.tsb then
            me_tsbdiferent(pos, id, tsb);
            raise error;
         end if;
         if val < dt.dt.linf then
            me_noRang(pos, id);
            raise error;
         end if;
         if val > dt.dt.lsup then
            me_noRang(pos, id);
            raise error;
         end if;
      else
         if idt /= id then
            me_tipusDiferent(pos, id, idt);
            raise error;
         end if;
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_valor;

--   DECLARA_CONSTANT:
--	 L_IDS s_dospunts pc_constant id s_assignacio VALOR s_punticoma
   procedure ct_decl_const (p : in pnode) is
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
      if dt.td /= d_tipus then
         me_noTipus(pidt.id_pos, idt);
         raise error;
      end if;
      if dt.dt.tsb > tsb_ent then
         me_tsbNoEscalar(pidt.id_pos, idt);
         raise error;
      end if;
      pvalor := p.valor;
      ct_valor(pvalor, idval, tsb, v, posi, dt, idt); -- Analitzam el VALOR
      ct_decl_const_lid(p.decl_const_l_ids, idt, v);
   exception
      when error => errorCompilacio := true;
   end ct_decl_const;

   procedure ct_decl_const_lid(p: in pnode; idt: in id_nom; v: in valor) is
      pid   : pnode;
      idv   : id_nom;
      d, dt : descripcio;
      e     : boolean;
   begin
      nv := nv + 1;
      pid := p.id;
      idv := pid.id_id;
      dt := consulta(ts, idt);
      d := (d_const, idt, v, nv, dt.dt.tsb);
      posa(ts, idv, d, e);
      if e then
         me_existeix(pid.id_pos, idv, "la constant");
         raise error;
      end if;
      if p.l_ids /= null then
         ct_decl_const_lid(p.l_ids, idt, v);
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_decl_const_lid;

-- pc_type id pc_is pc_new id pc_range VALOR s_puntpunt VALOR s_punticoma
   procedure ct_decl_subrang (p : in pnode) is
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
      if dtb.td /= d_tipus then
         me_noTipus(pidt.id_pos, idt);
         raise error;
      end if;
      if dtb.dt.tsb > tsb_ent then
         me_tsbNoEscalar(pidt.id_pos, idt);
         raise error;
      end if;

      pvalor1 := p.vinf;
      ct_valor(pvalor1, idval1, tsb1, v1, pos1, dtb, idt);
      pvalor2 := p.vsup;
      ct_valor(pvalor2, idval2, tsb2, v2, pos2, dtb, idt);

      if v1 > v2 then
         me_valorInfMajorValorSup(pos1, v1, v2);
         raise error;
      end if;

      case dtb.dt.tsb is
         when tsb_ent => dt := (tsb_ent, dtb.dt.ocup, v1, v2);
         when tsb_car => dt := (tsb_car, dtb.dt.ocup, v1, v2);
         when tsb_bool => dt := (tsb_bool, dtb.dt.ocup, v1, v2);
         when others => null;
      end case;
      dtd := (d_tipus, dt);
      posa (ts, p.decl_subrang_id1.id_id, dtd, e);
      if e then
         me_existeix(p.decl_subrang_id1.id_pos, p.decl_subrang_id1.id_id,
                           " el subrang");
         raise error;
      end if;
   exception
         when error => errorCompilacio := true;
   end ct_decl_subrang;

--   pc_type id pc_is pc_record
--     DECLARACIO_CAMPS
--   pc_end pc_record s_punticoma
   procedure ct_decl_record (p: in pnode) is
      idr  : id_nom;
      dt   : descr_tipus;
      dr   : descripcio;
      ocup : desplaçament;
      e    : boolean;
   begin
      idr := p.decl_record_id.id_id;
      dt := (tsb_record, 0); dr := (d_tipus, dt);
      posa(ts, idr, dr, e);
      if e then
         me_existeix(p.decl_record_id.id_pos, idr, " el record");
         raise error;
      end if;
      if p.decl_record_decl_camps /= null then
         ct_decl_camps(p.decl_record_decl_camps, idr, ocup);
      else
         ocup := 0;
      end if;
      dr.dt.ocup := ocup;
      actualitzaCamp(ts, idr, dr);
   exception
      when error => errorCompilacio := true;
   end ct_decl_record;

   procedure ct_decl_camps (p: in pnode; idr : in id_nom;
                            ocup : out desplaçament) is
   begin
      if p.decl_camps /= null then
         ct_decl_camps (p.decl_camps, idr, ocup);
      end if;
      ct_decl_camp(p.decl_camp, idr, ocup);
   end ct_decl_camps;

   procedure ct_decl_camp (p: in pnode; idr : in id_nom;
                           ocup : in out desplaçament) is
      dtc, dc : descripcio;
      e       : boolean;
   begin
      dtc := consulta(ts, p.decl_camp_id2.id_id);
      if dtc.td /= d_tipus then
         me_notipus(p.decl_camp_id2.id_pos, p.decl_camp_id2.id_id);
         raise error;
      end if;
      dc := (d_camp, p.decl_camp_id2.id_id, ocup);
      posaCamp(ts, idr, p.decl_camp_id1.id_id, dc, e);
      if e then
         me_existeix(p.decl_camp_id1.id_pos,p.decl_camp_id1.id_id,
                          " el camp");
         raise error;
      end if;
      ocup := ocup + dtc.dt.ocup;
   exception
      when error => errorCompilacio := true;
   end ct_decl_camp;

   procedure ct_decl_array (p: in pnode) is
      dt     : descr_tipus;
      da, dc : descripcio;
      e      : boolean;
      n      : valor := 0;
      ib     : valor := 0;
   begin
      dt := (tsb_array, 0, id_null, 0); da := (d_tipus, dt);
      posa (ts, p.decl_array_id1.id_id, da, e);
      if e then
         me_existeix(p.decl_array_id1.id_pos,p.decl_array_id1.id_id,
                          " l'array");
         raise error;
      end if;

      ct_decl_array_lids(p.decl_array_l_ids, p.decl_array_id1.id_id, n, ib);

      dc := consulta(ts, p.decl_array_id2.id_id);
      if dc.td /= d_tipus then
         me_notipus(p.decl_array_id2.id_pos, p.decl_array_id2.id_id);
         raise error;
      end if;
      da.dt.ocup := desplaçament(n) * dc.dt.ocup;
      da.dt.tcomp := p.decl_array_id2.id_id;
      da.dt.b := ib;
      actualitzaCamp(ts, p.decl_array_id1.id_id, da);
   end ct_decl_array;

   procedure ct_decl_array_lids (p : in pnode; ida: in id_nom;
                                 ncamps, b : in out valor) is
   begin
      if p.l_ids /= null then
         ct_decl_array_lids(p.l_ids, ida, ncamps, b);
      end if;
      ct_decl_array_id(p.id, ida, ncamps, b);
   end ct_decl_array_lids;

   procedure ct_decl_array_id (p : in pnode; ida: in id_nom;
                               ncamps, b : in out valor) is
      di, dindex : descripcio;
   begin
      di := consulta(ts, p.id_id);
      if di.td /= d_tipus then
         me_notipus(p.id_pos, p.id_id);
         raise error;
      end if;
      if di.dt.tsb > tsb_ent then
         me_tsbNoEscalar(p.id_pos, p.id_id);
         raise error;
      end if;
      dindex := (d_index, p.id_id);
      posaIndex(ts, ida, dindex);
      if ncamps = 0 then
         ncamps := di.dt.lsup - di.dt.linf + 1;
      else
         ncamps := (di.dt.lsup - di.dt.linf + 1) * ncamps;
      end if;
      -- Actalitzam la variable per a la generació de codi
      b := b*(di.dt.lsup - di.dt.linf + 1)+di.dt.linf;
   exception
      when error => errorCompilacio := true;
   end ct_decl_array_id;

--DECLARA_TIPUS:
--     DECLARA_SUBRANG
--  |  DECLARA_ARRAY
--  |  DECLARA_RECORD
--  ;
   procedure ct_decl_tipus (p : in pnode) is
      pa : pnode;
   begin
      pa := p.decl_t;
      if pa /= null then
         case pa.tnd is
            when nd_declara_subrang => ct_decl_subrang(pa);
            when nd_declara_record => ct_decl_record(pa);
            when nd_declara_array => ct_decl_array(pa);
            when others => null;
         end case;
      end if;
   end ct_decl_tipus;

   --  DECLARACIO:
   --     DECLARA_VARIABLE
   --  |  DECLARA_CONSTANT
   --  |  DECLARA_TIPUS
   --  |  DECLARA_PROC
   --  ;
   procedure ct_decl_decls(p: in pnode) is
      pa : pnode;
   begin
      if p.declaracions_declaracions /= null then
         ct_decl_decls(p.declaracions_declaracions);
      end if;
      if p.declaracions_declaracio /= null then
         pa := p.declaracions_declaracio.declaracio;
         if pa /= null then
            case pa.tnd is
               when nd_declara_variable => ct_decl_var(pa);
               when nd_declara_constant => ct_decl_const(pa);
               when nd_declara_tipus => ct_decl_tipus(pa);
               when nd_decl_prog =>
                  ct_procediment(pa);
               when others => null;
            end case;
         end if;
      end if;
   end ct_decl_decls;

   --COMPROVACIÓ DE TIPUS DE LES EXPRESSIONS

   -- E : R
   procedure ct_referencia(p: in pnode; idt: out id_nom;
                           tsb : out tipus_subjacent; esVar : out boolean;
                           pos : out posicio) is
      d, dt : descripcio;
   begin
      if p.ref_opcions.opcions_opcions = null then
         ct_referencia_id(p.ref_id, idt, tsb, esVar, pos);
      else
         ct_referencia_id(p.ref_id, idt, tsb, esVar, pos);
         ct_opcions(p.ref_opcions, idt, tsb, esVar, pos);
      end if;

   end ct_referencia;

   procedure ct_referencia_id(p: in pnode; idt: out id_nom;
                              tsb : out tipus_subjacent; esVar : out boolean;
                              pos : out posicio) is
      d, dt : descripcio;
   begin
      d := consulta(ts, p.id_id);
      case d.td is
         when d_var =>
            idt := d.tv;
            dt := consulta(ts, idt);
            tsb := dt.dt.tsb;
            esVar := true;
            pos := p.id_pos;
         when d_const =>
            idt := d.tc;
            dt := consulta(ts, idt);
            tsb := d.tsb_const;
            esVar := false;
            pos := p.id_pos;
         when d_proc =>
            idt := p.id_id;
            tsb := tsb_proc;
            esVar := false;
         when d_argin =>
            idt := d.tain;
            dt := consulta(ts, idt);
            tsb := dt.dt.tsb;
            esVar := false;
            pos := p.id_pos;
         when others =>
            me_noExisteix(p.id_pos);
            raise error;
      end case;

   end ct_referencia_id;

   procedure ct_opcions (p: in pnode; idt: in out id_nom;
                         tsb :in  out tipus_subjacent; esVar : in out boolean;
                         pos : in out posicio) is
      d : descripcio;
   begin
      if p.opcions_opcions /= null then
         ct_opcions(p.opcions_opcions, idt,  tsb, esVar, pos);
      end if;
      if p.opcions_opcio /= null then
         if p.opcions_opcio.camp_opcio /= null then
            ct_opcio(p.opcions_opcio.camp_opcio, idt,  tsb, esVar, pos);
         end if;
      end if;
   end ct_opcions;

   procedure ct_opcio (p: in pnode; idt: in out id_nom;
                       tsb : in out tipus_subjacent; esVar : in out boolean;
                       pos : in out posicio) is
      d, dc, dtc : descripcio;
      ita        : iterador_Array;
   begin
      if p.tnd /= nd_l_exps then
         if tsb /= tsb_record then
            me_noRecord(pos, tsb);
            raise error;
         end if;
         consultaCamp(ts, idt, p.id_id, dc);
         if dc.td = d_nula then
            me_noCamp(pos, p.id_id, idt);
            raise error;
         end if;
         dtc := consulta(ts, dc.tcmp);
         idt := dc.tcmp;
         tsb := dtc.dt.tsb;
      else
         d := consulta(ts, idt);
         if d.dt.tsb /= tsb_array then
            me_notipus(pos, idt);
            raise error;
         end if;

         ct_lexp_ref(p, idt, ita);

         succArray(ts, ita);
         if es_ValidArray(ita) then
            me_faltenIndexs(pos, idt);
            raise error;
         end if;
         dtc := consulta(ts, d.dt.tcomp);
         idt := d.dt.tcomp;
         tsb := dtc.dt.tsb;
      end if;

   end ct_opcio;

   procedure ct_lexp_ref (p: in pnode; ida: in id_nom;
                          ita: in out iterador_Array) is
   begin
      if p.l_exps_l_exps /= null then
         ct_lexp_ref(p.l_exps_l_exps, ida, ita);
      end if;
      ct_exp_ref(p, ida, ita);
   end ct_lexp_ref;

   procedure ct_exp_ref (p: in pnode; ida: in id_nom;
                         ita: in out iterador_Array) is
      di, dti : descripcio;
      idt     : id_nom;
      tsb     : tipus_subjacent;
      esVar   : boolean;
      pos     : posicio;
   begin
      if p.l_exps_l_exps = null then
         primerArray(ts, ida, ita);
      else
         succArray(ts, ita);
         if not es_ValidArray(ita) then
            me_massaIndexs(ida);
            raise error;
         end if;
      end if;
      consultaArray(ts, ita, di);
      ct_exp(p.l_exps_e, idt, tsb, esVar, pos);
      if idt = id_null then
         dti := consulta(ts, di.d_index_id);
         if dti.dt.tsb /= tsb then
            me_tsbdiferent(pos, idt, dti.dt.tsb);
            raise error;
         end if;
      else
         if idt /= di.d_index_id then
            me_tipusDiferent(pos, idt, di.d_index_id);
            raise error;
         end if;
      end if;
   end ct_exp_ref;

   -- E
   procedure ct_exp(p: in pnode; ide: out id_nom;
                    tsbe : out tipus_subjacent; esVar : out boolean;
                    pose : out posicio) is
      id1, id2       : id_nom;
      tsb1, tsb2     : tipus_subjacent;
      esVar1, esVar2 : boolean;
      pos1, pos2     : posicio;
   begin
      case p.tnd is
         when nd_e_op =>
            -- Els condicionals següents s'han afegit per a que només es
            -- llegeixi el fill esquerre o dret quan es necessiti i així
            -- no tenir punters nulls que poden donar a error.
            if p.op /= r_not then
               ct_exp(p.pee, id1, tsb1, esVar1, pos1);
            end if;
            if p.op /= r_menys_un and p.op /= r_nula then
               ct_exp(p.ped, id2, tsb2, esVar2, pos2);
            end if;
            case p.op is
               -- Tant el mode_variable com la posició de les expressions
               -- s'afegirà aquí perquè és comuna a totes les sub_operacions.
               when r_mes | r_menys | r_multiplicacio | r_divisio|
                  r_mod=>
                  ct_e_aritm(ide, id1, id2, tsbe,
                             tsb1, tsb2, pos1, pos2);
                  pose := pos1;
                  esVar := false;
               when r_and | r_or =>
                  ct_e_log(ide, id1, id2, tsbe,
                           tsb1, tsb2, pos1, pos2);
                  pose := pos1;
                  esVar := false;
               when r_diferent | r_relacional =>
                  ct_e_rel_dif (ide, id1, id2, tsbe,
                                tsb1, tsb2, pos1, pos2);
                  pose := pos1;
                  esVar := false;
               when r_not =>
                  ct_e_not(ide, id1, tsbe, tsb1, pose);
                  esVar := false;
               when r_menys_un =>
                  ct_e_menys_un(ide, id1, tsbe, tsb1, pose);
                  esVar := false;
               when r_nula =>
                  ct_exp_parentesi(ide, id1, tsbe, tsb1, pose);
                  esVar := false;
               when others => null;
            end case;
         when nd_e_lit =>
            ct_e_lit(p, ide, tsbe, pose);
            -- En el cas del literal, com no és pot modificar el seu contingut
            -- es posarà el mode var := fals, és a dir, se posarà me := const
            esVar := false;
         when nd_e_ref =>
            -- En el cas de la referència, com depèn d'ella mateixa, el mode
            -- serà retornat per ct_referencia.
            ct_referencia(p.reflit, ide, tsbe, esVar, pose);
         when others => null;
      end case;
   end ct_exp;

   --  E:
   --       E s_mes E
   --    |  E s_menys E
   --    |  E s_multiplicacio E
   --    |  E s_divisio E
   --    |  E pc_mod E
   procedure ct_e_aritm(ide: out id_nom; id1, id2: in id_nom;
                        tsbe : out tipus_subjacent;
                        tsb1, tsb2: in tipus_subjacent;
                        pos1, pos2: in posicio) is
   begin
      -- Comprovació de tipus_subjaçent de les components de l'expressió
      -- aritmètica.
      if tsb1 /= tsb_ent then
         me_noEnter(pos1, tsb1);
         raise error;
      end if;
      if tsb2 /= tsb_ent then
         me_noEnter(pos1, tsb1);
         raise error;
      end if;
      tsbe := tsb_ent;
      -- Compatibilitat d'IDs.
      if id1 = id_null then
         if id2 = id_null then
            ide := id_null;
         else
            ide := id2;
         end if;
      else
         if id2 = id_null then
            ide := id1;
         else
            if id1 /= id2 then
               me_tipusDiferent(pos1, id1, id2);
               raise error;
            end if;
            ide := id1;
         end if;
      end if;

   exception
      when error => errorCompilacio := true;
   end ct_e_aritm;

   --  E:
   --       E pc_and E
   --    |  E pc_or E
   procedure ct_e_log(ide: out id_nom; id1, id2: in id_nom;
                        tsbe : out tipus_subjacent;
                        tsb1, tsb2: in tipus_subjacent;
                        pos1, pos2: in posicio) is
   begin
      -- Comprovació de tipus_subjaçent de les components de l'expressió
      -- logarítmica.
      if tsb1 /= tsb_bool then
         me_tsbNoBoolea(pos1, id1);
         raise error;
      end if;
      if tsb2 /= tsb_bool then
         me_tsbNoBoolea(pos2, id2);
         raise error;
      end if;
      tsbe := tsb_bool;
      -- Compatibilitat d'IDs.
      if id1 /= id_null and id2 /= id_null then
         if id1 /= id2 then
            me_tipusDiferent(pos1, id1, id2);
            raise error;
         end if;
      end if;
      if id1 = id_null then
         ide := id2;
      else
         ide := id1;
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_e_log;

   --  E:
   --       E s_diferent E
   --    |  E s_relacional E
   procedure ct_e_rel_dif(ide: out id_nom; id1, id2: in id_nom;
                          tsbe : out tipus_subjacent;
                          tsb1, tsb2: in tipus_subjacent;
                          pos1, pos2: in posicio) is
   begin
      -- Comprovació de tipus_subjaçent de les components de l'expressió
      -- relacional.
      if tsb1 /= tsb2 then
         me_tipusDiferent(pos1, id1, id2);
         raise error;
      end if;

      -- Compatibilitat d'IDs.
      if id1 /= id_null and id2 /= id_null then
         if id1 /= id2 then
            me_tipusDiferent(pos1, id1, id2);
            raise error;
         end if;
      end if;
      if tsb1 > tsb_ent then
         me_tsbNoEscalar(pos1, id1);
         raise error;
      end if;

      tsbe := tsb_bool;
      ide := id_null;
   exception
      when error => errorCompilacio := true;
   end ct_e_rel_dif;

   --  E:
   --       not E
   procedure ct_e_not(ide: out id_nom; id1: in id_nom;
                      tsbe : out tipus_subjacent;
                      tsb1: in tipus_subjacent;
                      pos1: in posicio) is
   begin
      -- Comprovació de tipus_subjaçent de les components de l'expressió.
      if tsb1 /= tsb_bool then
         me_tsbNoBoolea(pos1, id1);
         raise error;
      end if;

      ide := id1;
      tsbe := tsb1;
   exception
      when error => errorCompilacio := true;
   end ct_e_not;

   --  E:
   --       s_menys E
   procedure ct_e_menys_un(ide: out id_nom; id1: in id_nom;
                           tsbe : out tipus_subjacent;
                           tsb1: in tipus_subjacent;
                           pos1: in posicio) is
   begin
      -- Comprovació de tipus_subjaçent de les components de l'expressió.
      if tsb1 /= tsb_ent then
         me_noEnter(pos1, tsb1);
         raise error;
      end if;

      ide := id1;
      tsbe := tsb1;
   exception
      when error => errorCompilacio := true;
   end ct_e_menys_un;

   --  E:
   --       s_parentesiobert E s_parentesitancat
   procedure ct_exp_parentesi(ide: out id_nom; id1: in id_nom;
                              tsbe : out tipus_subjacent;
                              tsb1: in tipus_subjacent;
                              pos1: in posicio) is
   begin
      ide := id1;
      tsbe := tsb1;
   end ct_exp_parentesi;

   --  E:
   --     literal
   procedure ct_e_lit(p: in pnode; ide: out id_nom; tsbe: out tipus_subjacent;
                      pose : out posicio) is
   begin
      tsbe := p.reflit.lit_tipus;
      ide := id_null;
      pose := p.reflit.lit_pos;
   end ct_e_lit;

   -- CT de les SENTÈNCIES

   --  SENT_ASSIG:
   --       REFERENCIA s_assignacio E s_punticoma
   procedure ct_sent_assig( p: in pnode) is
      idr, ide         : id_nom;
      tsbr, tsbe       : tipus_subjacent;
      dt               : descripcio;
      posr, pose       : posicio;
      esVar_r, esVar_e : boolean;
   begin
      ct_referencia(p.ref, idr, tsbr, esVar_r, posr);
      ct_exp(p.e, ide, tsbe, esVar_e, pose);
      -- Si volem assignar una expressió a una referència no variable =>
      -- error.
      if not esVar_r then
         me_referencia_no_variable(posr, p.ref.ref_id.id_id);
         raise error;
      end if;
      -- Si l'expressió no és d'un tipus declarat, és a dir, és general,
      -- comprovarem si els tipus subjaçents són compatibles.

      if ide = id_null then
         if tsbe /= tsbr then
            me_tsbdiferent(posr, idr, tsbe);
            raise error;
         end if;
         if tsbe > tsb_ent then
            me_noEnter(pose, tsbe);
            raise error;
         end if;
      else
         -- Si no és tipus universal, comprovam que el tipus de l'expressió
         -- sigui el mateix tipus que la referència.
         if idr /= ide then
            me_tipusDiferent(posr, idr, ide);
            raise error;
         end if;
         dt := consulta(ts, ide);
         if dt.dt.tsb /= tsbr then
            me_noEnter(pose, dt.dt.tsb);
            raise error;
         end if;
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_sent_assig;

   --  SENT_COND:
   --       pc_if E pc_then
   --            SENTS
   --       pc_end pc_if s_punticoma
   --  SENT_REP:
   --       pc_while E pc_loop
   --            SENTS
   --       pc_end pc_loop s_punticoma
   procedure ct_sent_cond_repeticio( p: in pnode) is
      idt   : id_nom;
      tsb   : tipus_subjacent;
      pos   : posicio;
      esVar : boolean;
   begin
      if p.tnd = nd_sent_cond then
         ct_exp(p.sent_cond_e, idt, tsb, esVar, pos);
      else
         ct_exp(p.sent_rep_e, idt, tsb, esVar, pos);
      end if;
      -- Basta mirar que el tipus subjaçent de l'expressió sigui booleà.
      if tsb /= tsb_bool then
         me_tsbNoBoolea(pos, idt);
         raise error;
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_sent_cond_repeticio;

   --  SENT_CRIDA:
   --       REFERENCIA s_punticoma
   --    ;
   procedure ct_sent_crida( p: in pnode) is
      idr   : id_nom renames p.sent_crida_referencia.ref_id.id_id;
      pargs : pnode renames p.sent_crida_referencia.ref_opcions;
      itp   : iterador_Proc;
      pos   : posicio renames p.sent_crida_referencia.ref_id.id_pos;
      d     : descripcio;
   begin
      d := consulta(ts, idr);
      if d.td /= d_proc then
         me_NoProcediment(pos);
         raise error;
      end if;
      if pargs /= null then
         if pargs.opcions_opcio /= null then
            if pargs.opcions_opcio.camp_opcio /= null then
               ct_lexpr_sent_crida(pargs.opcions_opcio.camp_opcio, idr, itp);
               succProc(ts, itp);
            end if;
         else
            primerProc(ts, idr, itp);
         end if;
      end if;
      if es_ValidProc(itp) then
         me_falten_parametres(pos);
         raise error;
      end if;
   exception
      when error => errorCompilacio := true;
   end ct_sent_crida;

   procedure ct_lexpr_sent_crida(p: in pnode; idp: in id_nom;
                                 it: in out iterador_Proc) is
   begin
      if p.l_exps_l_exps /= null then
         ct_lexpr_sent_crida(p.l_exps_l_exps, idp, it);
      end if;
      ct_exp_sent_crida(p, idp, it);
   end ct_lexpr_sent_crida;

   procedure ct_exp_sent_crida(p: in pnode; idp: in id_nom;
                               it: in out iterador_Proc) is
      da, dta        : descripcio;
      id, idarg, idt : id_nom;
      pos            : posicio;
      tsb            : tipus_subjacent;
      esVar          : boolean;
   begin
      if p.l_exps_l_exps = null then
         primerProc(ts, idp, it);
         if not es_ValidProc(it) then
            me_parametresNoEsperats;
            raise error;
         end if;
      else
         succProc(ts, it);
         if not es_ValidProc(it) then
            me_parametresNoEsperats;
            raise error;
         end if;
      end if;
      consultaProc(ts, it, id, da);
      ct_exp(p.l_exps_e, idarg, tsb, esVar, pos);
      if da.td = d_argin then
            idt := da.tain;
      elsif da.td = d_var then
         idt := da.tv;
      elsif da.td = d_arg then
         idt := da.ta;
      end if;
      if idarg = id_null then
         dta := consulta(ts, idt);
         if dta.td /= d_nula and then dta.dt.tsb /= tsb then
            me_tsbdiferent(pos, idt, tsb);
            raise error;
         end if;
      else
         if da.td = d_var then
            if idarg /= da.tv  then
               me_tipusDiferent(pos, idarg, da.tv);
               raise error;
            end if;
         elsif da.td = d_argin then
             if idarg /= da.tain  then
               me_tipusDiferent(pos, idarg, da.tain);
               raise error;
            end if;
         elsif da.td = d_arg then
            if idarg /= da.ta  then
               me_tipusDiferent(pos, idarg, da.ta);
               raise error;
            end if;
         end if;
      end if;
   end ct_exp_sent_crida;


   -- SENT
   procedure ct_decl_sents(p: in pnode) is
      pa : pnode;
   begin
      if p.sents /= null then
         ct_decl_sents(p.sents);
      end if;
      if p.sent /= null then
         pa := p.sent.sent_gen;
         if pa /= null then
         case pa.tnd is
            when nd_sent_assig => ct_sent_assig(pa);
            when nd_sent_cond =>
               ct_sent_cond_repeticio(pa);
               if pa.sent_cond_sents /= null then
                 ct_decl_sents(pa.sent_cond_sents);
               end if;
               if pa.sent_cond_esents /= null then
                  ct_decl_sents(pa.sent_cond_esents);
               end if;
            when nd_sent_rep =>
               ct_sent_cond_repeticio(pa);
               if pa.sent_rep_sents /= null then
                 ct_decl_sents(pa.sent_rep_sents);
               end if;
            when nd_sent_crida => ct_sent_crida(pa);
            when others => null;
         end case;
      end if;
   end if;
   end ct_decl_sents;

   procedure posa_entorn_standard is
      idint, idbool, idchar, idtrue, idfalse, idputc, idputi,
      idgetc, idgeti, idputstr, idnewline, ida: id_nom;
      d, daux, da : descripcio;
      dt : descr_tipus;
      er : boolean := false;
   begin
      posa(tnoms, "integer", idint);
      dt := (tsb_ent, 4, valor'First, valor'Last);
      d := (d_tipus, dt);
      posa(ts, idint, d, er);
      if er then
         raise error;
      end if;

      posa(tnoms, "character", idchar);
      dt := (tsb_car, 4, valor'First, valor'Last);
      d := (d_tipus, dt);
      posa(ts,idchar, d, er);
      if er then
         raise error;
      end if;

      posa(tnoms, "boolean", idbool);
      dt := (tsb_bool, 4, 0, 1);
      d := (d_tipus, dt);
      posa(ts,idbool, d, er);
      if er then
         raise error;
      end if;

      posa(tnoms, "true", idtrue);
      nc := nc + 1;
      tc(nc).v := boolean'pos(true);
      -- Afegim la nova constant a la taula de variables
      nv := nv + 1;
      tv(nv) := (const, false, nc, tsb_bool);
      d := (d_const, idbool, tc(nc).v, nv, tsb_bool);
      posa(ts, idtrue, d, er);
      if er then
         raise error;
      end if;

      posa(tnoms, "false", idfalse);
      nc := nc + 1;
      tc(nc).v := boolean'pos(false);
      -- Afegim la nova constant a la taula de variables
      nv := nv + 1;
      tv(nv) := (const, false, nc, tsb_bool);
      d := (d_const, idbool, tc(nc).v, nv, tsb_bool);
      posa(ts, idfalse, d, er);
      if er then
         raise error;
      end if;

      posa(tnoms, "putc", idputc);
      np := np + 1;
      tp(np) := (pextern, idputc, 0, 0, 0, np);
      tp(np).nparam := 1;
      empilar(pilaProc, np);
      d := (d_proc, np);
      posa(ts, idputc, d, er);
      if er then
         raise error;
      end if;
      -- Arguments del putc
      posa(tnoms, "c", ida);
      da := (d_arg, idchar, mode_in);
      posaArgument(ts, ida, idputc, da, er);

      posa(tnoms, "puti", idputi);
      np := np + 1;
      tp(np) := (pextern,idputi, 0, 0, 0, np);
      tp(np).nparam := 1;
      empilar(pilaProc, np);
      d := (d_proc, np);
      posa(ts, idputi, d, er);
      if er then
         raise error;
      end if;
      -- Arguments del puti
      posa(tnoms, "i", ida);
      da := (d_arg, idint, mode_in);
      posaArgument(ts, ida, idputi, da, er);

      posa(tnoms, "getc", idgetc);
      np := np + 1;
      tp(np) := (pextern,idgetc, 0, 0, 0, np);
      tp(np).nparam := 1;
      empilar(pilaProc, np);
      d := (d_proc, np);
      posa(ts, idgetc, d, er);
      if er then
         raise error;
      end if;
      -- Arguments del getc
      posa(tnoms, "c", ida);
      da := (d_arg, idchar, mode_inout);
      posaArgument(ts, ida, idgetc, da, er);

      posa(tnoms, "geti", idgeti);
      np := np + 1;
      tp(np) := (pextern,idgeti, 0, 0, 0, np);
      tp(np).nparam := 1;
      empilar(pilaProc, np);
      d := (d_proc, np);
      posa(ts, idgeti, d, er);
      if er then
         raise error;
      end if;
      -- Arguments del puti
      posa(tnoms, "i", ida);
      da := (d_arg, idint, mode_inout);
      posaArgument(ts, ida, idgeti, da, er);

      posa(tnoms, "puts", idputstr);
      np := np + 1;
      tp(np) := (pextern,idputstr, 0, 0, 0, np);
      tp(np).nparam := 1;
      empilar(pilaProc, np);
      d := (d_proc, np);
      posa(ts, idputstr, d, er);
      if er then
         raise error;
      end if;
      -- Arguments de puts
      posa(tnoms, "s", ida);
      da := (d_arg, id_null, mode_in);
      posAargument(ts, ida, idputstr, da, er);

      posa(tnoms, "new_line", idnewline);
      np := np + 1;
      tp(np) := (pextern,idnewline, 0, 0, 0, np);
      tp(np).nparam := 0;
      empilar(pilaProc, np);
      d := (d_proc, np);
      posa(ts, idnewline, d, er);
      if er then
         raise error;
      end if;
   exception
      when error => errorCompilacio := true;
   end posa_entorn_standard;
end semantica.ctipus;
