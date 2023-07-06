package body semantica.missatges_error is
   procedure CreaFitxer is
   begin
      create(f, out_file, nomLog);
   end CreaFitxer;

   procedure TancaFitxer is
   begin
      if is_open(f) then
         close(f);
      end if;
   end TancaFitxer;

   procedure me_error_comp is
   begin
      new_line;
      Put_Line(" -- S'HA PRODUIT UN ERROR DE COMPILACIO --");
      put_line(" -- Per saber mes informacio consultau el fitxer: missatges_error.txt");
   end me_error_comp;

   procedure me_comp_ok is
   begin
      new_line;
      put_line(" -- S'HA COMPILAT CORRECTAMENT");
   end me_comp_ok;

   procedure me_posicio (pos: in posicio) is
   begin
      put_Line(f, "Error en la línia " &integer'Image(pos.lin)&" i columna "
               &integer'Image(pos.col)&"  ("&integer'Image(pos.lin)&","
               &integer'Image(pos.col)&"):");
   end me_posicio;
   procedure me_noExisteix (pos: in posicio) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f,"     No existeix la variable.");
   end me_noExisteix;
   procedure me_notipus(pos: in posicio; id: in id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f,"     """&consulta(tnoms,id)&
                 """ no és un nom de tipus existent.");
   end me_notipus;

   procedure me_existeix(pos: in posicio;id: in id_nom; s: in string) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_line(f,"     El nom "&s&" " &""&consulta(tnoms,id)&""&
                 " ja existeix");
   end me_existeix;

   procedure me_noConstant(pos : in posicio; td: descripcio_tipus) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      Put_Line(F,"     S'esperava un tipus constant i no un tipus "&
                 tdAString(td));
   end me_noConstant;

   procedure me_noEnter(pos : in posicio; tsub: tipus_subjacent) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_line(f,"     S'esperava un enter i no un "&tsbAString(tsub));
   end me_noEnter;

   procedure me_tsbdiferent(pos:in posicio; id :in id_nom;
                            tsb:in tipus_subjacent) is
      d: descripcio;
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f, "     No es pot assignar un "&tsbAString(tsb)&
                 " a un id de tipus "&consulta(tnoms, id)&".");
   end me_tsbdiferent;

   procedure me_tipusDiferent(pos: in posicio; id, idt: in id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f, "     No es pot assignar l'element a l'identificador. ");
      put_Line(f, "     Tipus Diferents: ");
      put_Line(f, "       Tipus primer identificador: "&consulta(tnoms,id));
      if idt = id_null then
         put_Line(f, "       Tipus segon identificador: String");
      else
         put_Line(f, "       Tipus segon identificador: "&consulta(tnoms, idt));
      end if;
      end me_tipusDiferent;

   procedure me_tsbNoEscalar(pos: in posicio; id: in id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      if id /= id_null then
         put_line(f,"     El tipus "&consulta(tnoms,id)&" no és escalar.");
      else
         put_line(f,"     El tipus de l'expressió no és escalar.");
      end if;

   end me_tsbnoescalar;

   procedure me_noRang(pos: in posicio;idt: in id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_line(f,"     L'identificador "&consulta(tnoms,idt)&
                 " està fora de rang.");
   end me_noRang;

   procedure me_valorInfMajorValorSup(pos: in posicio;
                                            v1, v2: in valor) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f, "     El valor del límit inferior "&valor'Image(v1)&
                 " és major"&" que el valor del límit superior "&
                 valor'Image(v2));
   end me_valorInfMajorValorSup;


   procedure me_nomProcedimentErroni(pos: in posicio;
                                           idIni, idFinal: in id_nom)is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f, "     El procediment "&consulta(tnoms, idIni)&
                 " no se correspon amb el final "&consulta(tnoms, idFinal));
   end me_nomProcedimentErroni;

   procedure me_noNomProcediment (idIni: in id_nom; pos : posicio) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f, "     El nom "&consulta(tnoms, idIni)&
                 " ja existeix amb id_nom: " &id_nom'Image(idIni));
   end me_noNomProcediment;

   procedure me_noArgValid (idArg: in id_nom; pos: posicio) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f, "     El nom "&consulta(tnoms, idArg)&
                 " ja existeix com a nom d'argument.");
   end me_noArgValid;

   procedure me_referencia_no_variable(pos: in posicio; id: in id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      if id /= id_null then
         put_Line(f, "     El nom "&consulta(tnoms, id)&
                    " no és una variable.");
      else
         put_line(f,"     El nom donat no és una variable.");
      end if;
   end me_referencia_no_variable;

   procedure me_tsbNoBoolea(pos: in posicio; id: in id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      if id /= id_null then
         put_line(f,"     El tipus "&consulta(tnoms,id)&" no és booleà.");
      else
         put_line(f,"     El tipus del resultat no és booleà.");
      end if;

   end me_tsbNoBoolea;

   procedure me_falten_parametres(pos: in posicio) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line
        (f,"     El nombre de paràmetres introduïts és inferior l'esperat.");
   end me_falten_parametres;

   procedure me_parametresNoEsperats is
   begin
      Put_Line(f, "");
      put_Line
        (f,"     El nombre de paràmetres introduïts és superior l'esperat.");
   end me_parametresNoEsperats;
   procedure me_NoProcediment(pos: in posicio) is
   begin
      Put_Line(f,"");
      me_posicio(pos);
      put_Line(f,"     No és un procediment.");
   end me_NoProcediment;

   procedure me_noRecord(pos: in posicio; tsb : in tipus_subjacent) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f,"     El tipus subjaçent "&
                 tsbAString(tsb)&" no és un tipus record.");
   end me_noRecord;
   procedure me_noCamp(pos: in posicio; id, idt: id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f,"     El camp "&
                 consulta(tnoms,id)&" no pertany al record "&
                 consulta(tnoms, idt));
   end me_noCamp;

   procedure me_faltenIndexs(pos: in posicio; id : id_nom) is
   begin
      Put_Line(f, "");
      me_posicio(pos);
      put_Line(f,"     L'array "&
                 consulta(tnoms,id)&" té menys indexs dels declarats.");
   end me_faltenIndexs;

   procedure me_massaIndexs(id:in id_nom) is
   begin
      Put_Line(f, "");
      put_Line(f,"     L'array "&
                 consulta(tnoms,id)&" té massa indexs dels declarats.");
   end me_massaIndexs;
   function tdAString (td: in descripcio_tipus) return String is
   begin
      case td is
         when d_var => return "variable";
         when d_const => return "constant";
         when d_tipus => return "tipus";
         when d_proc => return "procediment";
         when d_nula => return "nula";
         when d_camp => return "camp";
         when d_arg => return "argument";
         when d_argin => return "argument in";
         when others => return "altres tipus";
      end case;
   end tdAString;
     function tsbAString (tsub: in tipus_subjacent) return String is
   begin
      case tsub is
         when tsb_bool => return "boolea";
         when tsb_ent => return "enter";
         when tsb_array => return "array";
         when tsb_record => return "record";
         when tsb_nul => return "null";
         when tsb_car => return "caràcter";
         when others => return "altre tipus";
      end case;
   end tsbAString;
end semantica.missatges_error;
