with Ada.Text_IO; use Ada.Text_IO;
with decls.declaracions_generals; use decls.declaracions_generals;
with a_lexic; use a_lexic;
with lexic_io;use lexic_io;
with an_sintactic_tokens; use an_sintactic_tokens;
with asintactic; use asintactic;

procedure prova_lexic is
   tk : Token;
begin
   -- PROVA PER AL L�XIC
   Open_Input("prova.txt");
   tk := yylex;

   put("-----------------------------------------------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   put("---------------PROVA DE L'ANALITZADOR L�XIC----------------");new_line;
   put("--                                                       --");new_line;
   put("--                                                       --");new_line;
   put("-------ANALITZAR� EL CONTINGUT DEL FITXER prova.txt--------");new_line;
   put("-----------------------------------------------------------");new_line;
   put("-----------------------------------------------------------");new_line;

   while tk /= End_Of_Input loop
      put(Token'Image(tk));
      new_line;
      tk := yylex;
   end loop;
   Close_Input;

end prova_lexic;
