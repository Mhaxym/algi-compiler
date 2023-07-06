with  Decls.d_Arbre;
package An_Sintactic_Tokens is


     subtype YYSType is decls.d_arbre.atribut;

    YYLVal, YYVal : YYSType; 
    type Token is
        (End_Of_Input, Error, Pc_Begin, Pc_End,
         Pc_If, Pc_Else, Pc_Then,
         Pc_While, Pc_Loop, Pc_Constant,
         Pc_New, Pc_Null, Pc_Out,
         Pc_Procedure, Pc_Function, Pc_Record,
         Pc_Range, Pc_Return, Pc_Type,
         Pc_Array, Pc_And, Pc_Or,
         Pc_Not, Pc_Of, Pc_Is,
         Pc_In, Pc_Mod, S_Dospunts,
         S_Punticoma, S_Parentesiobert, S_Parentesitancat,
         S_Menys, S_Mes, S_Multiplicacio,
         S_Divisio, S_Relacional, S_Coma,
         S_Punt, S_Puntpunt, S_Assignacio,
         S_Diferent, Id, Literal,
         Menys_Unitari );

    Syntax_Error : exception;

end An_Sintactic_Tokens;
