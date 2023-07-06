
with decls.declaracions_generals;use decls.declaracions_generals;
with Ada.Strings.Hash; use Ada.Strings;
with Ada.Text_IO; use Ada.Text_IO;

package body decls.d_taula_noms is

   procedure tbuida (tn : out taula_noms) is
      td: t_disp renames tn.td;
      tid: t_ident renames tn.tid;
      tstr: t_str renames tn.tstr;
      nid: id_nom renames tn.nid;
      nc : natural renames tn.nc;
      nstr:id_str renames tn.nstr;
      nombre_strings: natural renames tn.nombre_strings;
      id_str_init: id_str := 0;
   begin
      for i in td'First.. td'Last loop
         td(i) := id_null;
      end loop;
      -- Nombre de caràcters, d'identificadors i de strings a 0.
      nid := 0; nc := 0; nstr := 0;
      nombre_strings := max_car;
      tid(id_null):=(nc,id_null);
      while id_str_init < id_str'last loop
         tstr(id_str_init) := 0;
         id_str_init := id_str_init + 1;
      end loop;
   end tbuida;

   function igual
     (nom : in string; tn : in taula_noms; p: in id_nom)
      return boolean is

      tid: t_ident renames tn.tid;
      tc : t_caracter renames tn.tc;
      i, j :natural; -- Índex sobre el nom i la taula de noms.
      pi, pf : natural; -- Posició inicial i posició final dins tc.

   begin
      pi := tid(p-1).ic+1; pf := tid(p).ic;
      i := nom'First; j := pi;
      while nom(i)=tc(j) and i<nom'Last and j<pf loop
         i := i+1; j := j+1;
      end loop;
      return nom(i)=tc(j) and i=nom'last and j=pf;
   end igual;

   -- Afegirà un nom a la taula de caràcters.
   procedure posaNom
     (nom : in string; tc : in out t_caracter; nc : in out natural) is
   begin
      for i in nom'Range loop
         nc := nc + 1;
         tc(nc) := nom(i);
      end loop;
   end posaNom;

   procedure posa
     (tn : in out taula_noms; nom : in string; id : out id_nom) is
      td : t_disp renames tn.td;
      tid: t_ident renames tn.tid;
      nid: id_nom renames tn.nid;
      tc : t_caracter renames tn.tc;
      nc : natural renames tn.nc;
      trobat : boolean := false;
      -- Variables per al hashing i la cerca.
      i: indexTD;
      p: id_nom;
   begin
      i := hash(nom) mod b;
      p := td(i);
      while p /= id_null and then not igual (nom, tn, p) loop
         p := tid(p).sh;
      end loop;
      if p = id_null then
         if nid = id_nom(max_id) then raise desbordament_capacitat; end if;
         if nc+nom'Length > max_car then raise desbordament_capacitat; end if;
         posaNom(nom, tc, nc);
         nid := nid + 1;
         tid(nid) := (nc, td(i));
         td(i) := nid; p := nid;
      end if;
      id := p;
   end posa;


   function consulta (tn : in taula_noms; id : id_nom) return string is
      tid: t_ident renames tn.tid;
      nid: id_nom renames tn.nid;
      tc : t_caracter renames tn.tc;
      pi, pf: natural;
   begin
      if id = id_null or id > nid then raise mal_us; end if;
      pi := tid(id-1).ic+1; pf := tid(id).ic;
      return tc(pi..pf);
   end consulta;

   procedure posa_str
     (tn : in out taula_noms; s : in string; id: out id_str) is
      tstr: t_str renames tn.tstr;
      nstr: id_str renames tn.nstr;
      tc : t_caracter renames tn.tc;
      nc : natural renames tn.nc;
      index_str : id_str;
      pescriure, parametre_posaNom : natural;
      nombre_strings: natural renames tn.nombre_strings;
   begin
      index_str := 0;
      if(nstr /= 0) then
        index_str := nstr;
      end if;
      if tstr(index_str) = 0 then
         pescriure := nombre_strings - s'Length;
         if (pescriure < nc) then raise desbordament_capacitat; end if;
         if nstr + 1 > tstr'Last then raise desbordament_capacitat; end if;
         parametre_posaNom := pescriure;
         posaNom(s, tc, parametre_posaNom);
         nombre_strings := nombre_strings - s'Length;
         tstr(index_str) := pescriure +1 ;
         nstr := nstr + 1;
      end if;
      id := index_str;
   end posa_str;

   function consulta_str
     (tn : in taula_noms; id : in id_str) return string is
      tc : t_caracter renames tn.tc;
      tstr: t_str renames tn.tstr;
      pi, pf: natural;
   begin
      if id = 0 then
         pi :=tstr(id) ; pf := max_car;
         return String(tc(pi..pf));
      else
         pi := tstr(id); pf := tstr(id-1);
         return String(tc(pi..pf-1));
         -- Li restam -1 per situar-mos en el darre caràcter
         -- de l'string.
      end if;
   end consulta_str;
end decls.d_taula_noms;
