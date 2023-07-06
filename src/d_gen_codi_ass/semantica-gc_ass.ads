with decls.declaracions_generals, Ada.Text_IO, decls.c3a_io;
use decls.declaracions_generals, Ada.Text_IO, decls.c3a_io;
package semantica.gc_ass is
   procedure genera_codi_ass(nom: in String);
   procedure conclou_codi_ass;
private
   type registre is
     (eax,
      ebx,
      ecx,
      edx,
      esi,
      edi,
      esp,
      ebp);
   fass : ada.Text_IO.File_Type;
   fin  : decls.c3a_io.File_Type;
end semantica.gc_ass;
