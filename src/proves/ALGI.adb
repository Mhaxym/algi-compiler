with Ada.Text_IO, lexic_io, an_sintactic_tokens, asintactic, semantica.ctipus,
semantica.g_codi, semantica.gc_ass, Ada.Command_Line, semantica;
use Ada.Text_IO, lexic_io, an_sintactic_tokens, asintactic, semantica.ctipus,
semantica.g_codi, semantica.gc_ass, Ada.Command_Line, semantica;
procedure ALGI is
   i: integer;
begin
   i := Argument_Count;
   if i = 0 then
      Put_Line("NO S'HA ESPECIFICAT EL FITXER .algi A COMPILAR");
   elsif i > 1 then
      Put_Line("NOMÉS S'ADMET UN PARÀMETRE");
   else
      prepara_analisi;

      Open_Input(Argument(1));
      yyparse;
      Close_Input;

      comprova_tipus;

      if not er_Analisi then
         prepara_gen_codi_int(Argument(1)(1..Argument(1)'last - 5));
         genera_codi_int;
         conclou_gen_codi_int;

         genera_codi_ass(Argument(1)(1..Argument(1)'last - 5));
         conclou_codi_ass;
      end if;
      conclou_analisi;
   end if;

end ALGI;
