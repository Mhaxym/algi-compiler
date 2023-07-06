
with semantica.missatges_error; use semantica.missatges_error;
with Ada.Text_IO; use Ada.Text_IO;
with semantica.ctipus; use semantica.ctipus;

package body semantica is
   procedure prepara_analisi is
   begin
      missatges_error.creaFitxer; -- Crea fitxer de missatges d'error.

      nv := 0;
      np := 0;
      ne := 0;
      nc := 0;
      ni3a := 0;
      errorCompilacio := false;

      tbuida(tnoms);
      tbuida(ts);

      posa_entorn_standard;
   end prepara_analisi;

   procedure conclou_analisi is
   begin
      missatges_error.TancaFitxer; -- Tanca el fitxer de missatges d'error.
      if not errorCompilacio then
         put("------- LA COMPILACIO HA ACABAT SATISFACTORIAMENT ---------");
         new_line;
      else
         put("------- LA COMPILACIO HA ACABAT AMB ERRORS ----------------");
         new_line;
         put("-------------- COMPROVAU FITXER .log ----------------------");
         new_line;
      end if;
   end conclou_analisi;

   function er_Analisi return boolean is
   begin
      return errorCompilacio;
   end er_Analisi;
end semantica;
