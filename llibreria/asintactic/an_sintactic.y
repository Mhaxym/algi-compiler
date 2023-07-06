%token Error
%token End_of_Input
%token pc_begin
%token pc_end
%token pc_if
%token pc_else
%token pc_then
%token pc_while
%token pc_loop
%token pc_constant
%token pc_new
%token pc_null
%token pc_out
%token pc_procedure
%token pc_function
%token pc_record
%token pc_range
%token pc_return
%token pc_type
%token pc_array
%token pc_and
%token pc_or
%token pc_not
%token pc_of
%token pc_is
%token pc_in
%token pc_mod
%token s_dospunts
%token s_punticoma
%token s_parentesiobert
%token s_parentesitancat
%token s_menys
%token s_mes
%token s_multiplicacio
%token s_divisio
%token s_relacional
%token s_coma
%token s_punt
%token s_puntpunt
%token s_assignacio
%token s_diferent
%token id
%token literal

%left pc_or pc_and
%left pc_not
%nonassoc s_relacional s_diferent s_assignacio
%left s_mes s_menys
%left menys_unitari
%left s_multiplicacio s_divisio pc_mod



%with decls.d_arbre;
{
     subtype YYSType is decls.d_arbre.atribut;
}

%%

PROGRAMA:
     DECLARA_PROC                            {rs_programa($$,$1);}
  ;

DECLARA_PROC:
     pc_procedure ENCAP pc_is
          DECLARACIONS
     pc_begin
          SENTS
     pc_end id s_punticoma                   {rs_decl_prog($$, $2, $4, $6, $8);}
  ;

ENCAP:
     id PARAMETRES                             {rs_nd_arguments($$, $1, $2);}
  |  id                                        {rs_nd_arguments($$, $1);}
  ;

PARAMETRES:
     s_parentesiobert ARGS s_parentesitancat   {rs_nd_parametres($$, $2);}
  ;

ARGS:
     ARGS s_punticoma D_ARG                    {rs_nd_args($$, $1, $3);}
  |  D_ARG                                     {rs_nd_args($$,$1);}
  ;

D_ARG:
     id s_dospunts MODE_PARAMETRE id           {rs_nd_d_arg($$, $1, $3, $4);}
  ;

MODE_PARAMETRE:
	   pc_in                                     {rs_nd_mode_parametre_in($$);}
  |  pc_out                                    {rs_nd_mode_parametre_out($$);}
  |  pc_in pc_out                              {rs_nd_mode_parametre_inout($$);}
  ;

DECLARACIONS:
     DECLARACIONS DECLARACIO                   {rs_nd_declaracions($$, $1, $2);}
  |                                            {rs_nd_declaracions($$);}
  ;

DECLARACIO:
  	 DECLARA_VARIABLE                          {rs_nd_declaracio($$, $1);}
  |  DECLARA_CONSTANT                          {rs_nd_declaracio($$, $1);}
  |  DECLARA_TIPUS                             {rs_nd_declaracio($$, $1);}
  |  DECLARA_PROC                              {rs_nd_declaracio($$, $1);}
  ;

DECLARA_VARIABLE:
     L_IDS s_dospunts id s_punticoma       {rs_nd_declara_variable($$, $1, $3);}
  ;

L_IDS:
     L_IDS s_coma id                           {rs_nd_l_ids($$, $1, $3);}
  |  id                                        {rs_nd_l_ids($$, $1);}
  ;

DECLARA_CONSTANT:
	 L_IDS s_dospunts pc_constant id s_assignacio VALOR s_punticoma

   {rs_nd_declara_constant($$, $1, $4, $6);}
  ;

VALOR:
     literal                                   {rs_nd_valor_lit($$, $1);}
  |  s_menys literal                           {rs_nd_valor_lit_menys($$, $2);}
  |  id                                        {rs_nd_valor_id($$, $1);}
  |  s_menys id                                {rs_nd_valor_id_menys($$, $2);}
  ;

DECLARA_TIPUS:
     DECLARA_SUBRANG                           {rs_nd_declara_tipus($$, $1);}
  |  DECLARA_ARRAY                             {rs_nd_declara_tipus($$, $1);}
  |  DECLARA_RECORD                            {rs_nd_declara_tipus($$, $1);}
  ;

DECLARA_SUBRANG:
     pc_type id pc_is pc_new id pc_range VALOR s_puntpunt VALOR s_punticoma

     {rs_nd_declara_subrang($$, $2, $5, $7, $9);}
  ;

DECLARA_ARRAY:
     pc_type id pc_is pc_array
     s_parentesiobert L_IDS s_parentesitancat pc_of id s_punticoma

     {rs_nd_declara_array($$, $2, $6, $9);}
  ;

DECLARA_RECORD:
	 pc_type id pc_is pc_record
	      DECLARACIO_CAMPS
	 pc_end pc_record s_punticoma

   {rs_nd_declara_record($$, $2, $5);}
  ;

DECLARACIO_CAMPS:
     DECLARACIO_CAMPS DECLARACIO_CAMP      {rs_nd_declaracio_camps($$, $1, $2);}
  |  DECLARACIO_CAMP                       {rs_nd_declaracio_camps($$, $1);}
  ;

DECLARACIO_CAMP:
     id s_dospunts id s_punticoma          {rs_nd_declaracio_camp($$, $1, $3);}
  ;

SENTS:
     SENTS SENT                            {rs_nd_sents($$, $1, $2);}
  |                                        {rs_nd_sents($$);}
  ;

SENT:
     SENT_REP                              {rs_nd_sent($$, $1);}
  |  SENT_COND                             {rs_nd_sent($$, $1);}
  |  SENT_ASSIG                            {rs_nd_sent($$, $1);}
  |  SENT_CRIDA                            {rs_nd_sent($$, $1);}
  ;

SENT_REP:
     pc_while E pc_loop
          SENTS
     pc_end pc_loop s_punticoma            {rs_nd_sent_rep($$, $2, $4);}
  ;

SENT_COND:
     pc_if E pc_then
          SENTS
     pc_end pc_if s_punticoma              {rs_nd_sent_cond($$, $2, $4);}
  |  pc_if E pc_then
          SENTS
     pc_else
     	    SENTS
     pc_end pc_if s_punticoma              {rs_nd_sent_cond($$, $2, $4, $6);}
  ;

SENT_ASSIG:
     REFERENCIA s_assignacio E s_punticoma {rs_nd_sent_assig($$, $1, $3);}
  ;

REFERENCIA:
     id OPCIONS                            {rs_nd_referencia($$, $1, $2);}
  ;

OPCIONS:
     OPCIONS OPCIO                         {rs_nd_opcions($$, $1, $2);}
  |                                        {rs_nd_opcions($$);}
  ;

OPCIO:
	   s_punt id                                  {rs_nd_opcio($$, $2);}
  |  s_parentesiobert L_EXPS s_parentesitancat  {rs_nd_opcio($$, $2);}
  ;

L_EXPS:
     L_EXPS s_coma E                       {rs_nd_l_exps($$, $1, $3);}
  |  E                                     {rs_nd_l_exps($$, $1);}
  ;

SENT_CRIDA:
     REFERENCIA s_punticoma                {rs_nd_sent_crida($$, $1);}
  ;

E:
     E s_mes E                           {rs_nd_e_op_mes($$, $1, $3);}
  |  E s_menys E                         {rs_nd_e_op_menys($$, $1, $3);}
  |  E s_multiplicacio E                 {rs_nd_e_op_multiplicacio($$, $1, $3);}
  |  E s_divisio E                       {rs_nd_e_op_divisio($$, $1, $3);}
  |  E pc_mod E                          {rs_nd_e_op_mod($$, $1, $3);}
  |  E pc_and E                          {rs_nd_e_op_and($$, $1, $3);}
  |  E pc_or E                           {rs_nd_e_op_or($$, $1, $3);}
  |  E s_diferent E                      {rs_nd_e_op_diferent($$, $1, $3);}
  |  E s_relacional E                    {rs_nd_e_op_relacional($$, $1, $2, $3);}
  |  s_menys E        %prec menys_unitari  {rs_nd_e_op_munitari($$, $2);}
  |  s_parentesiobert E s_parentesitancat  {rs_nd_e_op_expun($$, $2);}
  |  pc_not E                            {rs_nd_e_op_not($$, $2);}
  |  REFERENCIA                          {rs_nd_e_ref($$, $1);}
  |  literal                             {rs_nd_e_lit($$, $1);}
  ;

%%

package asintactic is
     procedure YYParse;
end asintactic;

with an_sintactic_tokens, an_sintactic_shift_reduce, an_sintactic_goto, Text_IO,
a_lexic, lexic_io, an_sintactic_error_report;
use an_sintactic_tokens, an_sintactic_shift_reduce, an_sintactic_goto, Text_IO,
a_lexic, lexic_io, an_sintactic_error_report;

with semantica.c_arbre;
use semantica.c_arbre;
package body asintactic is

  procedure YYError(S : in string) is
       begin
        Text_IO.Put_Line(S);
        raise An_Sintactic_Error_Report.Syntax_Error;
  end YYError;

##
end asintactic;
