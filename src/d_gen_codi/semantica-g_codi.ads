with decls.d_descripcio, decls.declaracions_generals, decls.codi_3_a,
decls.d_taula_simbols,decls.c3a_io , Ada.Text_IO;
use decls.declaracions_generals, decls.d_descripcio, decls.codi_3_a,
    decls.d_taula_simbols, decls.c3a_io;

package semantica.g_codi is
   procedure prepara_gen_codi_int(nomf : in String);
   procedure conclou_gen_codi_int;
   procedure genera_codi_int;
private
   f3b : decls.c3a_io.File_Type;
   f3a : Ada.Text_IO.File_Type;
end semantica.g_codi;
