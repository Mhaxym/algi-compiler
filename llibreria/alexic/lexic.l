-- Diferents macros que utilitzara l'analitzador lexic

lletra [A-Za-z]
digit  [0-9]

-- Tots els caracters representables

car_rep [\040-\176]

-- Tots els caracters representables de la taula ascii menys
-- els caracters de les CometesDobles

car_rep_no_dc [\040-\041\043-\176]

%%

-- Tots els simbols dels que disposara el compilador
":"         {rl_simb (yylval, pos); return s_dospunts;}
";"         {rl_simb (yylval, pos); return s_punticoma;}
"("         {rl_simb (yylval, pos); return s_parentesiobert;}
")"         {rl_simb (yylval, pos); return s_parentesitancat;}
"+"         {rl_simb (yylval, pos); return s_mes;}
"-"         {rl_simb (yylval, pos); return s_menys;}
"*"	        {rl_simb (yylval, pos); return s_multiplicacio;}
"/"	        {rl_simb (yylval, pos); return s_divisio;}
"="	        {rl_op_rel (yylval, yytext, pos); return s_relacional;}
"<"         {rl_op_rel (yylval, yytext, pos); return s_relacional;}
">"	        {rl_op_rel (yylval, yytext, pos); return s_relacional;}
"<="        {rl_op_rel (yylval, yytext, pos); return s_relacional;}
">="        {rl_op_rel (yylval, yytext, pos); return s_relacional;}
","         {rl_simb (yylval, pos); return s_coma;}
"."         {rl_simb (yylval, pos); return s_punt;}
":="        {rl_simb (yylval, pos); return s_assignacio;}
"/="        {rl_simb (yylval, pos); return s_diferent;}
".."        {rl_simb (yylval, pos); return s_puntpunt;}

-- Paraules clau que utilitzara el compilador
"begin"     {rl_simb (yylval, pos); return pc_begin;}
"end"       {rl_simb (yylval, pos); return pc_end;}
"if"        {rl_simb (yylval, pos); return pc_if;}
"else"      {rl_simb (yylval, pos); return pc_else;}
"then"      {rl_simb (yylval, pos); return pc_then;}
"while"     {rl_simb (yylval, pos); return pc_while;}
"loop"      {rl_simb (yylval, pos); return pc_loop;}
"constant"  {rl_simb (yylval, pos); return pc_constant;}
"new"       {rl_simb (yylval, pos); return pc_new;}
"null"      {rl_simb (yylval, pos); return pc_null;}
"out"       {rl_simb (yylval, pos); return pc_out;}
"procedure" {rl_simb (yylval, pos); return pc_procedure;}
"function"  {rl_simb (yylval, pos); return pc_function;}
"record"    {rl_simb (yylval, pos); return pc_record;}
"range"     {rl_simb (yylval, pos); return pc_range;}
"return"    {rl_simb (yylval, pos); return pc_return;}
"type"      {rl_simb (yylval, pos); return pc_type;}
"array"     {rl_simb (yylval, pos); return pc_array;}
"and"       {rl_simb (yylval, pos); return pc_and;}
"or"        {rl_simb (yylval, pos); return pc_or;}
"not"       {rl_simb (yylval, pos); return pc_not;}
"of"        {rl_simb (yylval, pos); return pc_of;}
"is"        {rl_simb (yylval, pos); return pc_is;}
"in"        {rl_simb (yylval, pos); return pc_in;}
"mod"       {rl_simb (yylval, pos); return pc_mod;}

-- Estructura dels identificadors, els strings i els literals enter i caracter

{lletra}((_?)({lletra}|{digit}))*             {rl_identificador
                                                (yylval, yytext, pos);
																						   	return id; }
\"({car_rep_no_dc})*\"                        {rl_lit_str(yylval, yytext, pos);
																						    return literal; }
{digit}+                                      {rl_lit_ent(yylval, yytext, pos);
                                                return literal; }
"'"{car_rep}"'"                               {rl_lit_car(yylval, yytext, pos);
                                                return literal; }
"--"[^\n]*                                    {null;}
[\r]+                                         {null;}
.                                             {return Error;}

%%

with lexic_io; use lexic_io;
with lexic_dfa; use lexic_dfa;
with an_sintactic_tokens; use an_sintactic_tokens;
package a_lexic is
	function yylex return token;
end a_lexic;
with decls.declaracions_generals; use decls.declaracions_generals;
with semantica.c_arbre; use semantica.c_arbre;
package body a_lexic is

 function pos return posicio is
 p : posicio;
 begin
   p.lin := YY_LINE_NUMBER;
	 p.col := YY_BEGIN_COLUMN;
	 return p;
 end pos;

##
end a_lexic;
