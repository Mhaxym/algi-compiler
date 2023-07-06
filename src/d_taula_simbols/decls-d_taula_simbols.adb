with Ada.Text_IO; use Ada.Text_IO;

package body decls.d_taula_simbols is
   -- Algoritmes generals de la taula de símbols
   procedure tbuida (ts: out t_simbols) is
      td: t_descripcio renames ts.td;
      ta: t_ambit renames ts.ta;
      prof: profunditat renames ts.np;
   begin
      prof := 0; ta(prof):=0;

      for id in 1..id_nom'last loop
         td(id) := (prof, (td => d_nula), 0);
      end loop;
      prof := 1; ta(prof):=0;
   end tbuida;

   function consulta (ts: in out t_simbols; id: in id_nom) return descripcio is
      td: t_descripcio renames ts.td;
   begin
      return td(id).d;
   end consulta;

   procedure posa
     (ts: in out t_simbols; id: in id_nom; d: in descripcio; e: out boolean) is
      td: t_descripcio renames ts.td;
      te: t_expansio renames ts.te;
      ta: t_ambit renames ts.ta;
      prof: profunditat renames ts.np;
      ie: iExpansio;
   begin
      e := False;
      if td(id).np = prof then raise conflicte; end if;
      ie := ta(prof);
      ie := ie+1;
      te(ie) := (id, td(id).np, td(id).d, 0);
      ta(prof) := ie;
      td(id).np := prof; -- Informació sobre el node que s'acaba de guardar
      td(id).d := d;
   exception
         when conflicte => e := true;
   end posa;

   -- Algoritmes per a la gestió de records
   procedure posaCamp
     (ts: in out t_simbols; idr, idc : id_nom;
      dc: in descripcio; e : out boolean) is
      td: t_descripcio renames ts.td;
      te: t_expansio renames ts.te;
      ta: t_ambit renames ts.ta;
      prof: profunditat renames ts.np;
      ie: iExpansio;
      d : descripcio;
   begin
      d := td(idr).d;
      if d.td /= d_tipus and d.dt.tsb /= tsb_record then raise mal_us; end if;
      ie := td(idr).p;
      while ie /= 0 and te(ie).id /= idc loop
         ie := te(ie).scc;
      end loop;
      e := (ie /= 0);
      if not e then
         ta(prof) := ta(prof) + 1; ie := ta(prof);
         te(ie) := (idc, -1, dc, td(idr).p);
         td(idr).p := ie;
      end if;
   end posaCamp;

   procedure consultaCamp
     (ts : in t_simbols; idr, idc : in id_nom; dc : out descripcio) is
      td: t_descripcio renames ts.td;
      te: t_expansio renames ts.te;
      ie: iExpansio;
      d : descripcio;
   begin
      d := td(idr).d;
      if d.td /= d_tipus and d.dt.tsb /= tsb_record then raise mal_us; end if;
      ie := td(idr).p;
      while ie /= 0 and te(ie).id /= idc loop
         ie := te(ie).scc;
      end loop;
      if ie /= 0 then dc := te(ie).d; else dc := (td => d_nula); end if;
   end consultaCamp;

   procedure actualitzaCamp (ts: in out t_simbols; id: in id_nom;
                             dc: in descripcio) is
      td: t_descripcio renames ts.td;
   begin
      td(id).d := dc;
   end actualitzaCamp;


   -- Algoritmes per a la gestió d'arrays
   procedure posaIndex
     (ts: in out t_simbols; ida: in id_nom; dind: in descripcio) is
      td: t_descripcio renames ts.td;
      te: t_expansio renames ts.te;
      ta: t_ambit renames ts.ta;
      prof: profunditat renames ts.np;
      ie, iep: iExpansio;
      d : descripcio;
   begin
      d := td(ida).d;
      if d.td /= d_tipus and d.dt.tsb /= tsb_array then raise mal_us; end if;
      ie := td(ida).p; iep := 0;
      while ie /= 0 loop
         iep := ie; ie := te(ie).scc;
      end loop;
      ta(prof) := ta(prof) + 1; ie := ta(prof); -- Captura d'espai
      te(ie).d := dind; te(ie).np := -1; te(ie).id := id_null;
      if iep = 0 then
         td(ida).p := ie;
      else
         te(iep).scc := ie;
      end if;
      te(ie).scc := 0;
   end posaIndex;

   procedure primerArray
     (ts: in out t_simbols; ida: id_nom; it: out iterador_Array) is
      td: t_descripcio renames ts.td;
      d : descripcio;
   begin
      d := td(ida).d;
      if d.td /= d_tipus and d.dt.tsb /= tsb_array then raise mal_us; end if;
      it.itArr := td(ida).p;
   end primerArray;

   procedure succArray (ts: in out t_simbols; it: in out iterador_Array) is
      te: t_expansio renames ts.te;
   begin
      if it.itArr = 0 then raise mal_us; end if;
      it.itArr := te(it.itArr).scc;
   end succArray;

   function es_ValidArray (it: in iterador_Array) return boolean is
   begin
      return it.itArr /= 0;
   end es_ValidArray;

   procedure consultaArray
     (ts: in out t_simbols; it: in iterador_Array; dind: out descripcio) is
      te: t_expansio renames ts.te;
   begin
      if it.itArr = 0 then raise mal_us; end if;
      dind := te(it.itArr).d;
   end consultaArray;

   -- Algoritmes per a la gestió de procediments
   procedure posaArgument
     (ts :in out t_simbols; idarg, idproc: in id_nom;
      darg: in descripcio; e: out boolean) is
      td: t_descripcio renames ts.td;
      te: t_expansio renames ts.te;
      ta: t_ambit renames ts.ta;
      prof: profunditat renames ts.np;
      ie, iep: iExpansio;
      d : descripcio;
   begin
      d := td(idproc).d;
      if d.td /= d_proc then raise mal_us; end if;
      ie := td(idproc).p; iep := 0;
      while ie /= 0 and te(ie).id /= idarg loop
         iep := ie; ie := te(ie).scc;
      end loop;
      e := (ie /= 0);
      if not e then
         ta(prof) := ta(prof)+1; ie := ta(prof); -- Captura d'espai
         te(ie).id := idarg;
         te(ie).np := -1;
         te(ie).d := darg;
         if iep = 0 then
            td(idproc).p := ie;
         else
            te(iep).scc := ie;
         end if;
         te(ie).scc := 0;
      end if;
   end posaArgument;

   procedure primerProc
     (ts: in t_simbols; idproc: in id_nom; it : out iterador_Proc) is
      td: t_descripcio renames ts.td;
      d : descripcio;
   begin
      d := td(idproc).d;
      if d.td /= d_proc then raise mal_us; end if;
      it.itProc := td(idproc).p;

   end primerProc;

   procedure succProc (ts: in t_simbols; it: in out iterador_Proc) is
      te: t_expansio renames ts.te;
   begin
      if it.itProc = 0 then raise mal_us; end if;
      it.itProc := te(it.itProc).scc;
   end succProc;

   function es_ValidProc(it: in iterador_Proc) return boolean is
   begin
      return it.itProc /= 0;
   end es_ValidProc;

   procedure consultaProc
     (ts: in t_simbols; it: in iterador_Proc;
      idarg: out id_nom; darg: out descripcio) is
      te: t_expansio renames ts.te;
   begin
      if it.itProc = 0 then raise mal_us; end if;
      idarg := te(it.itProc).id; darg := te(it.itProc).d;
   end consultaProc;

   -- Algoritmes per al control de la profunditat
   procedure entraBloc(ts: in out t_simbols) is
      ta: t_ambit renames ts.ta;
      prof: profunditat renames ts.np;
   begin
      prof := prof + 1;
      ta(prof) := ta(prof-1);
   end entraBloc;

   procedure surtBloc(ts: in out t_simbols) is
      td: t_descripcio renames ts.td;
      te: t_expansio renames ts.te;
      ta: t_ambit renames ts.ta;
      prof: profunditat renames ts.np;
      ie, il: iExpansio;
      id : id_nom;
   begin
      ie := ta(prof);  il := ta(prof-1);
      while ie > il loop
         if te(ie).np /= -1 then
            id := te(ie).id;
            td(id).np := te(ie).np; -- Actualitzam
            td(id).d := te(ie).d;
            --td(id).p := te(ie).scc;
         end if;
         ie := ie-1;
      end loop;
      prof := prof -1;
   end surtBloc;

      -- Algoritmes per a fer proves
   procedure infoTD (ts: in t_simbols; i: in integer; d : out descripcio_tipus;
                     prof: out integer;  succ: out integer) is
   begin
      d := ts.td(id_nom(i)).d.td;
      succ := integer(ts.td(id_nom(i)).p);
      prof := integer(ts.td(id_nom(i)).np);
   end infoTD;

   procedure infoTE (ts: in t_simbols; i: in integer; idExp: out id_nom; prof: out integer;
                     d: out descripcio_tipus; succ: out integer) is
   begin
      idExp := ts.te(iExpansio(i)).id;
      prof := integer(ts.te(iExpansio(i)).np);
      d := descripcio_tipus(ts.te(iExpansio(i)).d.td);
      succ := integer(ts.te(iExpansio(i)).scc);
   end infoTE;

   procedure infoTA (ts: in t_simbols; i: in integer; a: out integer) is
   begin
      a := integer(ts.ta(profunditat(i)));
   end infoTA;

   function consProf(ts: in t_simbols) return integer is
   begin
      return integer(ts.ta(ts.np));
   end consProf;

   function consProfGlobal(ts: in t_simbols) return integer is
   begin
      return integer(ts.np);
   end consProfGlobal;
end decls.d_taula_simbols;
