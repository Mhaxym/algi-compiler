with Ada.Text_IO, decls.d_descripcio; use Ada.Text_IO, decls.d_descripcio;

package semantica.missatges_error is
   procedure CreaFitxer;
   procedure TancaFitxer;

   procedure me_posicio(pos: in posicio);
   procedure me_error_comp;
   procedure me_comp_ok;
   procedure me_notipus(pos: in posicio; id: in id_nom);
   procedure me_noExisteix (pos: in posicio);
   procedure me_existeix(pos: in posicio;id: in id_nom;s: in string);
   procedure me_noConstant(pos : in posicio;td: descripcio_tipus);
   procedure me_noEnter(pos : in posicio;tsub: tipus_subjacent);
   function tdAString (td: in descripcio_tipus) return String;
   function tsbAString (tsub: in tipus_subjacent) return String;
   procedure me_tsbdiferent(pos: in posicio; id: in id_nom;
                                  tsb : in tipus_subjacent);
   procedure me_tipusDiferent(pos: in posicio; id, idt: in id_nom);
   procedure me_tsbNoEscalar(pos: in posicio; id: in id_nom);
   procedure me_tsbNoBoolea(pos: in posicio; id: in id_nom);
   procedure me_noRecord(pos: in posicio; tsb : in tipus_subjacent);
   procedure me_noCamp(pos: in posicio; id, idt: id_nom);
   procedure me_faltenIndexs(pos: in posicio; id : id_nom);
   procedure me_massaIndexs(id:in id_nom);
   procedure me_noRang(pos: in posicio;idt: in id_nom);
   procedure me_valorInfMajorValorSup(pos: in posicio;
                                            v1, v2: in valor);
   procedure me_nomProcedimentErroni(pos: in posicio;
                                           idIni, idFinal: in id_nom);


   procedure me_noNomProcediment (idIni: in id_nom; pos: posicio);
   procedure me_noArgValid (idArg: in id_nom; pos: posicio);
   procedure me_referencia_no_variable(pos: in posicio; id: in id_nom);
   procedure me_falten_parametres(pos: in posicio);
   procedure me_parametresNoEsperats;
   procedure me_NoProcediment(pos: in posicio);



private
   f : Ada.Text_IO.File_Type;
   nomLog : constant string (1..19) := "missatges_error.log";
end semantica.missatges_error;
