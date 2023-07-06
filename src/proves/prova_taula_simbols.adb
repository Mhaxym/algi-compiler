with decls.d_taula_simbols, decls.declaracions_generals, decls.d_descripcio,
     ada.Text_IO,ada.Integer_Text_IO;
use decls.d_taula_simbols, decls.declaracions_generals, decls.d_descripcio,
    ada.Text_IO,ada.Integer_Text_IO;

procedure prova_taula_simbols is
   ts: t_simbols;
   error: boolean;
   d, d2, d3, d4, d5, d6, d7, d8: descripcio;
   dInfo: descripcio_tipus;
   it: iterador_Array;
   itProc : iterador_Proc;
   argOut, id : id_nom;
   prof, succ, profTS: integer;
begin
   tbuida(ts);

   put("-----------------------------------------------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   put("-----------------PROVA TAULA DE SÍMBOLS--------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   new_line;

   d:= (d_tipus, (tsb_array, desplaçament(4), id_nom(1), 0));
   d2:= (d_var, id_nom(2), num_var(24));
   d3:= (d_tipus,(tsb_record, desplaçament(4)));
   d4:= (d_proc, num_proc(30));
   d7:= (d_var, id_nom(7), num_var(77));
   d8:= (d_var, id_nom(9), num_var(99));

   entraBloc(ts);


   put("----------------------- COMENÇAM PROVES -------------------------------");
   new_line;
   put("------------------------------ P1 -------------------------------------");
   new_line;new_line;
   put("Posam a la taula de símbols una descripció (5) per a l'id_nom=3 que conté ");
   new_line;
   put("una variable amb id_nom=2, i num_var=24.");
   new_line;new_line;

   posa(ts, id_nom(3), d2, error);
   if error then put("Error al posa de P1"); end if;
   d5 := consulta(ts, id_nom(3));
   put(" -> L'id_nom que conté la descripció (5) és:              ");
   put(integer(d5.tv));
   new_line;
   put(" -> El nombre de variable que conté la descripció (5) és: ");
   put(integer(d5.nv));
   new_line;new_line;



   put("------------------------------ P2 -------------------------------------");
   new_line;new_line;
   put("Posam a la taula de símbols una descripció (3) per a l'id_nom=4 que conté ");
   new_line;
   put("un record amb dos camps, el primer amb d2 i el segon amb d7.");
   new_line;new_line;

   posa(ts, id_nom(4), d3, error);
   if error then put("Error al posa del 'Record'"); end if;
   posaCamp(ts, id_nom(4), id_nom(5), d2, error);
   if error then put("Error al posaCamp (1)"); end if;
   posaCamp(ts, id_nom(4), id_nom(6), d7, error);
   if error then put("Error al posaCamp (2)"); end if;
   consultaCamp(ts,id_nom(4),id_nom(5), d6);
   put(" --> CAMP (1) del 'RECORD'");
   new_line;new_line;
   put(" -> L'id_nom que conté la descripció (6) del camp amb id_nom=5 és:              ");
   put(integer(d6.tv));
   new_line;
   put(" -> El nombre de variable que conté la descripció (6) del camp amb id_nom=5 és: ");
   put(integer(d6.nv));
   new_line;new_line;
   consultaCamp(ts,id_nom(4),id_nom(6), d6);
   put(" --> CAMP (2) del 'RECORD'");
   new_line;new_line;
   put(" -> L'id_nom que conté la descripció (6) del camp amb id_nom=6 és:              ");
   put(integer(d6.tv));
   new_line;
   put(" -> El nombre de variable que conté la descripció (6) del camp amb id_nom=6 és: ");
   put(integer(d6.nv));
   new_line;new_line;



   put("------------------------------ P3 -------------------------------------");
   new_line;new_line;
   put("Posam a la taula de símbols una descripció (0) per a l'id_nom=7 que conté ");
   new_line;
   put("una array amb dues descripcions, d7 i d8.");
   new_line;new_line;

   posa(ts, id_nom(8), d, error);
   if error then put("Error a posa array"); end if;
   posaIndex(ts, id_nom(8), d7);  -- Descripció per al primer índex
   posaIndex(ts, id_nom(8), d8);  -- Desripció per al segon índex
   primerArray(ts, id_nom(8), it);
   consultaArray(ts, it, d6);
   put(" --> INDEX (1) de l'ARRAY");
   new_line;new_line;
   put(" -> L'id_nom que conté la descripció (6) de l'índex és:              ");
   put(integer(d6.tv));
   new_line;
   put(" -> El nombre de variable que conté la descripció (6) de l'índex és: ");
   put(integer(d6.nv));
   new_line;new_line;
   succArray(ts, it); -- Següent índex de l'array
   put(" --> INDEX (2) de l'ARRAY");
   new_line;new_line;
   consultaArray(ts, it, d6);
   put(" -> L'id_nom que conté la descripció (6) de l'índex és:              ");
   put(integer(d6.tv));
   new_line;
   put(" -> El nombre de variable que conté la descripció (6) de l'índex és: ");
   put(integer(d6.nv));
   new_line;new_line;

   put("------------------------------ P4 -------------------------------------");
   new_line;new_line;
   put("Posam a la taula de símbols una descripció (4) per a l'id_nom=10 que conté ");
   new_line;
   put("un procediment amb dos arguments d8 i d7.");
   new_line;new_line;

   posa(ts, id_nom(10), d4, error);
   posaArgument(ts, id_nom(11), id_nom(10), d8, error);
   if error then put("Error a posaArgument (1)"); end if;
   posaArgument(ts, id_nom(12), id_nom(10), d7, error);
   if error then put("Error a posaArgument (2)"); end if;
   primerProc(ts, id_nom(10), itProc);
   consultaProc(ts, itProc, argOut, d6);
   put("El primer argument del procediment amb id_nom=10 té id_nom=11"); new_line;
   put(" -> L'id del primer argument del procediment és :                 ");
   put(integer(argOut));
   new_line;
   put(" -> L'id_nom que conté la variable que es passa com argument és: ");
   put(integer(d6.tv));
   new_line;new_line;

   succProc(ts, itProc);
   consultaProc(ts, itProc, argOut, d6);
   put("El segon argument del procediment amb id_nom=10 té id_nom=12"); new_line;
   put(" -> L'id del segon argument del procediment és :                 ");
   put(integer(argOut));
   new_line;
   put(" -> L'id_nom que conté la variable que es passa com argument és: ");
   put(integer(d6.tv));
   new_line;new_line;

   put("------------------------------ P5 -------------------------------------");
   new_line;new_line;
   put("Imprimim les taules que conformen la taula de símbols. ");
   new_line;new_line;

   put("TAULA DE DESCRIPCIÓ"); new_line;
   for i in 1..30 loop
      infoTD(ts, i, dInfo, prof, succ);
      put("Descripció:  ");
      put(descripcio_tipus'pos(dInfo));
      Put_Line("");
      put("Profunditat: ");
      put(integer(prof));
      new_line;
      put("Següent:     ");
      put(integer(succ));
      Put_Line("");
      put_line("------------");
   end loop;

   put("TAULA DE EXPANSIO"); new_line;
   profTS:= consProf(ts);
   for i in 1..profTS loop
      infoTE(ts, i, id, prof, dInfo, succ);
      put("Id_nom:      ");
      put(integer(id));new_line;
      put("Profunditat: ");
      put(integer(prof));new_line;
      put("Descripció:  ");
      put(descripcio_tipus'pos(dInfo));
      new_line;
      put("Següent:     ");
      put(integer(succ));
      new_line;
      put_line("------------");
   end loop;
   profTS:= consProfGlobal(ts);
   put_line("TAULA D'ÀMBIT");
   for i in 1..profTS loop
      infoTA(ts, i, prof);
      put("Àmbit:");
      put(integer(prof));
      put_line("");
      put_line("------------");
   end loop;
   surtBloc(ts);
end prova_taula_simbols;
