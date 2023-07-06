with decls.declaracions_generals, decls.d_taula_noms, decls.d_arbre,
     decls.d_taula_simbols, decls.codi_3_a, decls.d_pila,
     decls.pila_procediment,
     decls.pila_etiquetes,
     pila_parametres;
use decls.declaracions_generals, decls.d_taula_noms, decls.d_arbre,
    decls.d_taula_simbols, decls.codi_3_a,
    decls.pila_procediment, decls.pila_etiquetes, pila_parametres;
package semantica is
   procedure prepara_analisi;
   procedure conclou_analisi;

   function er_Analisi return boolean;
private
   tnoms: taula_noms;
   ts: t_simbols;

   tp: t_procediments;
   tv: t_variable;
   tc: t_constant;

   c3a : t_c3a;
   arrel: pnode;

   nv: num_var;
   np: num_proc;
   ne: num_etiq;
   nc : num_const;
   ni3a : num_i3a;
   profGC : integer;

   -- Piles necessàries per a la comprovació de tipus i la generació de codi
   -- intermig.
   pilaProc : decls.pila_procediment.pila;

   pCert : decls.pila_etiquetes.pila;
   pFals : decls.pila_etiquetes.pila;

   pparam : pila_parametres.pila;



   errorCompilacio : boolean;
end semantica;
