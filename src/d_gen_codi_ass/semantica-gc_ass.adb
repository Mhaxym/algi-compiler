with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.strings.fixed; use ada.strings.fixed;
with decls.c3a_io; use decls.c3a_io;
use decls.c3a_io;
with decls.d_descripcio; use decls.d_descripcio;
with semantica.g_codi; use semantica.g_codi;
with Ada.Strings.Maps;
with Ada.Strings.Maps.Constants;
package body semantica.gc_ass is

   procedure calcula_desplacaments;
   procedure genera_ass;

   function to_Lower_Case (r: in registre) return String;

   newline: String(1..1):=(1=>ASCII.LF);

   -- Procedure principal de generació de codi assemblador
   procedure genera_codi_ass(nom: in String) is
   begin
      Open(fin, In_File, nom & ".c3a");
      Create(fass, out_file, nom&".s");
      calcula_desplacaments;
      genera_ass;
   end genera_codi_ass;

   -- Finalització de de generació de codi
   procedure conclou_codi_ass is
   begin
      Close(fass);
      Close(fin);
   end conclou_codi_ass;

   -- Lectura d'instrucció de 3a del fitxer binari
   function gc_ass_llegir return instr_3a is
      c3a: instr_3a;
   begin
      Read(fin, c3a);
      return c3a;
   end gc_ass_llegir;

   -- Càlcul dels desplaçaments
   procedure calcula_desplacaments is
      nproc : num_proc;
   begin
      for i in 1..nv loop
         if tv(i).mode = var and then tv(i).despl = 0 then
            nproc := tv(i).nproc;
            tp(nproc).ocupVarLoc := tp(nproc).ocupVarLoc + tv(i).ocup;
            tv(i).despl := -tp(nproc).ocupVarLoc;
         end if;
      end loop;
   end calcula_desplacaments;

   procedure gc_ass_escriure (codi: in String) is
   begin
      Put_Line(fass, codi);
   end gc_ass_escriure;

   procedure escriure_seccions is
   begin
    gc_ass_escriure(".section .bss");
    gc_ass_escriure(".comm DISP, 100");
    gc_ass_escriure(".section .text");
    gc_ass_escriure(".global _e1");
   end escriure_seccions;

   -- LOAD
   function ld (arg: in num_var; r: in registre) return String is
      desp_disp : Integer;
   begin
      if tv(arg).mode = var then -- Si no és una variable
         desp_disp := 4*(tp(tv(arg).nproc).prof);
         if tp(tv(arg).nproc).prof = tp(cim(pilaProc)).prof then
            if tv(arg).despl < 0 then -- Var local
               return "  movl "&trim(tv(arg).despl'img,ada.strings.left)&"(%ebp), %"&to_Lower_Case(r);

            elsif tv(arg).despl > 0 then -- Par local
               return "  movl "&trim(tv(arg).despl'img,ada.strings.left) &"(%ebp), %esi" & newline
                    & "  movl (%esi), %"&to_Lower_Case(r);
            end if;

         elsif tp(tv(arg).nproc).prof < tp(cim(pilaProc)).prof then
            if tv(arg).despl < 0 then -- Var global
               return "  movl $DISP, %esi" & newline
                 & "  movl "& trim(desp_disp'Img,ada.strings.left) & "(%esi), %esi"& newline
                 & "  movl "& trim(tv(arg).despl'img,ada.strings.left) & "(%esi), %" & to_Lower_Case(r);

            elsif tv(arg).despl > 0 then -- Par global
               return "  movl $DISP, %esi" & newline
                 & "  movl "& trim(desp_disp'Img,ada.strings.left) & "(%esi), %esi"& newline
                 & "  movl "& trim(tv(arg).despl'img,ada.strings.left) & "(%esi), %esi" & newline
                 & "  movl (%esi), %"& to_Lower_Case(r);
            end if;
         end if;
      else -- Si és una constant
         return "  movl $"& trim(tc(tv(arg).val).v'img,ada.strings.left) &
           ", %"
           &  to_Lower_Case(r);
      end if;
      return "";
   end ld;

   function lda (arg : in num_var; r: in registre) return String is
      etiq : num_etiq;
      desp_disp : Integer;
   begin
      if tv(arg).mode = var then -- Si és una variable
         desp_disp := 4*(tp(tv(arg).nproc).prof);
         if tp(tv(arg).nproc).prof = tp(cim(pilaProc)).prof then
            if tv(arg).despl < 0 then -- Var local
               return "  leal "&trim(tv(arg).despl'img,ada.strings.left)&"(%ebp), %"
                    & to_Lower_Case(r);

            elsif tv(arg).despl > 0 then -- Par local
               return "  movl "&trim(tv(arg).despl'img, ada.strings.left) &"(%ebp), %"
                 &    to_Lower_Case(r);
            end if;

         elsif tp(tv(arg).nproc).prof < tp(cim(pilaProc)).prof then
            if tv(arg).despl < 0 then -- Var global
               return " movl $DISP, %esi" & newline
                 & " movl "& trim(desp_disp'Img,ada.strings.left) & "(%esi), %esi"& newline
                 & " leal "& trim(tv(arg).despl'img,ada.strings.left) & "(%esi), %" & to_Lower_Case(r);

            elsif tv(arg).despl > 0 then -- Par global
               return " movl $DISP, %esi" & newline
                 & " movl "& trim(desp_disp'Img,ada.strings.left) & "(%esi), %esi"& newline
                 & " movl "& trim(tv(arg).despl'img,ada.strings.left) & "(%esi), %"
                 & to_Lower_Case(r);
            end if;
         end if;
      else -- Si és constant
         ne := ne + 1;
         etiq := ne;
         case tv(arg).tsub is
            when tsb_ent | tsb_bool =>
               return ".section .data" & newline
                 &    " ec" &trim(etiq'img, ada.strings.left)
                 &    ": .long  "& tc(tv(arg).val).v'img & newline
                 &    ".section .text" & newline
                 &    "  movl $ec"&trim(etiq'img, ada.strings.left)
                 &    ", %" & to_Lower_Case(r);
            when tsb_car =>
               return ".section .data" & newline
                 &    " ec" &trim(etiq'img, ada.strings.left)
                 &    ": .ascii  "&'"'
                 &    Character'Val(Integer(tc(tv(arg).val).v)) & '"' & newline
                 &    ".section .text" & newline
                 &    "  movl $ec"&trim(etiq'img, ada.strings.left) & ", %" & to_Lower_Case(r);
            when tsb_nul =>
               return ".section .data" & newline
                 &    " ec" &trim(etiq'img, ada.strings.left) &": .asciz  "&'"'
                 &    decls.d_taula_noms.consulta_str(tnoms, id_str(tc(tv(arg).val).v))&'"'& newline
                 &    ".section .text" & newline
                 &    "  movl $ec"&trim(etiq'img, ada.strings.left)
                 &    ", %" &to_Lower_Case(r);
            when others =>
               null;
         end case;
      end if;
      return "";
   end lda;

   function st (arg : in num_var; r : in registre) return String is
      desp_disp : constant Integer := 4*(tp(tv(arg).nproc).prof);
   begin
      if tp(tv(arg).nproc).prof = tp(cim(pilaProc)).prof then
         if tv(arg).despl < 0 then -- Var local
            return "  movl %"&to_Lower_Case(r) &", "&trim(tv(arg).despl'img,ada.strings.left)&"(%ebp)";

         elsif tv(arg).despl > 0 then -- Par local
            return "  movl "&trim(tv(arg).despl'img,ada.strings.left) &"(%ebp), %edi" & newline
              & "  movl %"& to_Lower_Case(r) &", (%edi)";
         end if;

      elsif tp(tv(arg).nproc).prof < tp(cim(pilaProc)).prof then
         if tv(arg).despl < 0 then -- Var global
            return "  movl $DISP, %esi" & newline
              & "  movl "& trim(desp_disp'Img,ada.strings.left) & "(%esi), %edi"& newline
              & "  movl %"& to_Lower_Case(r) & ", "&trim(tv(arg).despl'img,ada.strings.left) & "(%edi)";

         elsif tv(arg).despl > 0 then -- Par global
            return "  movl $DISP, %esi" & newline
              & "  movl "& trim(desp_disp'Img,ada.strings.left) & "(%esi), %esi"& newline
              & "  movl $"& trim(tv(arg).despl'img,ada.strings.left) & "(%esi), %edi" & newline
              & "  movl %"& to_Lower_Case(r) & ", (%edi)";
         end if;
      end if;
      return "";
   end st;

   procedure genera_ass is
      c3a : instr_3a;
      et : num_etiq;
      ocup: desplaçament;
      param4, desp_disp: integer;
   begin
      escriure_seccions;
      while not End_Of_File(fin) loop
         c3a := gc_ass_llegir;
         case c3a.tinst is
            when suma =>
               gc_ass_escriure(ld(c3a.y, eax));
               gc_ass_escriure(ld(c3a.z, ebx));
               gc_ass_escriure("  addl  %ebx, %eax");
               gc_ass_escriure(st(c3a.x, eax));
            when resta =>
   	       gc_ass_escriure(ld(c3a.y, eax));
               gc_ass_escriure(ld(c3a.z, ebx));
               gc_ass_escriure("  subl %ebx, %eax");
               gc_ass_escriure(st(c3a.x, eax));

            when prod =>
               gc_ass_escriure(ld(c3a.y, eax));
               gc_ass_escriure(ld(c3a.z, ebx));
               gc_ass_escriure("  imull %ebx, %eax");
               gc_ass_escriure(st(c3a.x, eax));

            when div =>
               gc_ass_escriure(ld(c3a.y, eax));
               gc_ass_escriure("  movl %eax, %edx");
               gc_ass_escriure("  sarl $31,  %edx");
               gc_ass_escriure(ld(c3a.z, ebx));
               gc_ass_escriure("  idivl %ebx");
               gc_ass_escriure(st(c3a.x, eax));

            when mod3a =>
               gc_ass_escriure(ld(c3a.y, eax));
               gc_ass_escriure("  movl %eax, %edx");
               gc_ass_escriure("  sarl $31,  %edx");
               gc_ass_escriure(ld(c3a.z, ebx));
               gc_ass_escriure("  idivl %ebx");
               gc_ass_escriure(st(c3a.x, edx));
            when and3a =>
               gc_ass_escriure(ld(c3a.y, eax));
               gc_ass_escriure(ld(c3a.z, ebx));
               gc_ass_escriure("  andl %ebx, %eax");
               gc_ass_escriure(st(c3a.x, eax));

            when or3a =>
               gc_ass_escriure(ld(c3a.y, eax));
               gc_ass_escriure(ld(c3a.z, ebx));
               gc_ass_escriure("  orl %ebx, %eax");
               gc_ass_escriure(st(c3a.x, eax));

            when not3a =>
               gc_ass_escriure(ld(c3a.yn, eax));
               gc_ass_escriure("  notl %eax");
               gc_ass_escriure(st(c3a.xn, eax));

            when menys_u =>
               gc_ass_escriure(ld(c3a.yn, eax));
               gc_ass_escriure("  negl %eax");
               gc_ass_escriure(st(c3a.xn, eax));

            when copia =>
               gc_ass_escriure(ld(c3a.yCop, eax));
               gc_ass_escriure(st(c3a.xCop, eax));

            when cons_index =>
               gc_ass_escriure(ld(c3a.zInd, eax));
               gc_ass_escriure(lda(c3a.yInd, esi));
               gc_ass_escriure("  addl %eax, %esi");
               gc_ass_escriure("  movl (%esi), %eax");
               gc_ass_escriure(st(c3a.xInd, eax));

            when ass_index =>
               gc_ass_escriure(ld(c3a.yAssInd, eax));
               gc_ass_escriure(ld(c3a.zAssInd, ebx));
               gc_ass_escriure(lda(c3a.xAssInd, edi));
               gc_ass_escriure("  addl %eax, %edi");
               gc_ass_escriure("  movl %ebx, (%edi)");

            when etiq =>
               gc_ass_escriure("_e" & trim(c3a.e'img,ada.strings.left) &":");

            when goto3a =>
               gc_ass_escriure("  jmp _e"&trim(c3a.eGoTo'img,ada.strings.left));

            when if_menor =>
               gc_ass_escriure(ld(c3a.xIf, eax));
               gc_ass_escriure(ld(c3a.yIf, ebx));
               gc_ass_escriure("  cmp %ebx, %eax");
               ne := ne + 1;
               et := ne;
               gc_ass_escriure("  jge _e"&trim(et'img,ada.strings.left));
               gc_ass_escriure("  jmp _e"&trim(c3a.eIf'img,ada.strings.left));
               gc_ass_escriure("_e"&trim(et'img,ada.strings.left)&":");
            when if_men_ig =>
               gc_ass_escriure(ld(c3a.xIf, eax));
               gc_ass_escriure(ld(c3a.yIf, ebx));
               gc_ass_escriure("  cmpl %ebx, %eax");
               ne := ne + 1;
               et := ne;
               gc_ass_escriure("  jg _e"&trim(et'img,ada.strings.left));
               gc_ass_escriure("  jmp _e"&trim(c3a.eIf'img,ada.strings.left));
               gc_ass_escriure("_e"&trim(et'img,ada.strings.left)&":");
            when if_dif =>
               gc_ass_escriure(ld(c3a.xIf, eax));
               gc_ass_escriure(ld(c3a.yIf, ebx));
               gc_ass_escriure("  cmpl %ebx, %eax");
               ne := ne + 1;
               et := ne;
               gc_ass_escriure("  je _e"&trim(et'img,ada.strings.left));
               gc_ass_escriure("  jmp _e"&trim(c3a.eIf'img,ada.strings.left));
               gc_ass_escriure("_e"&trim(et'img,ada.strings.left)&":");
            when if_igual =>
               gc_ass_escriure(ld(c3a.xIf, eax));
               gc_ass_escriure(ld(c3a.yIf, ebx));
               gc_ass_escriure("  cmpl %ebx, %eax");
               ne := ne + 1;
               et := ne;
               gc_ass_escriure("  jne _e"&trim(et'img,ada.strings.left));
               gc_ass_escriure("  jmp _e"&trim(c3a.eIf'img,ada.strings.left));
               gc_ass_escriure("_e"&trim(et'img,ada.strings.left)&":");
            when if_maj_ig =>
               gc_ass_escriure(ld(c3a.xIf, eax));
               gc_ass_escriure(ld(c3a.yIf, ebx));
               gc_ass_escriure("  cmpl %ebx, %eax");
               ne := ne + 1;
               et := ne;
               gc_ass_escriure("  jl _e"&trim(et'img,ada.strings.left));
               gc_ass_escriure("  jmp _e"&trim(c3a.eIf'img,ada.strings.left));
               gc_ass_escriure("_e"&trim(et'img,ada.strings.left)&":");
            when if_maj =>
               gc_ass_escriure(ld(c3a.xIf, eax));
               gc_ass_escriure(ld(c3a.yIf, ebx));
               gc_ass_escriure("  cmpl %ebx, %eax");
               ne := ne + 1;
               et := ne;
               gc_ass_escriure("  jle _e"&trim(et'img,ada.strings.left));
               gc_ass_escriure("  jmp _e"&trim(c3a.eIf'img,ada.strings.left));
               gc_ass_escriure("_e"&trim(et'img,ada.strings.left)&":");
            when pmb =>
               empilar(pilaProc, c3a.np);
               gc_ass_escriure("  movl $DISP, %eax");
               desp_disp := 4*(tp(c3a.np).prof);
               gc_ass_escriure("  addl $"&trim(desp_disp'img, ada.strings.left)&", %eax");
               gc_ass_escriure("  pushl (%eax)");
               gc_ass_escriure("  pushl %ebp");
               gc_ass_escriure("  movl %esp, %ebp");
               gc_ass_escriure("  movl %ebp, (%eax)");
               ocup := tp(c3a.np).ocupVarLoc;
               gc_ass_escriure("  subl $"&trim(ocup'img, ada.strings.left)&", %esp");
            when rtn =>
               gc_ass_escriure("  movl %ebp, %esp");
               gc_ass_escriure("  popl %ebp");
               gc_ass_escriure("  movl $DISP, %eax");
               desp_disp := 4*(tp(c3a.np).prof);
               gc_ass_escriure("  addl $"&trim(desp_disp'img, ada.strings.left)&", %eax");
               gc_ass_escriure("  popl %eax");
               gc_ass_escriure("  ret");
               desempilar(pilaProc);
            when call =>
               if tp(c3a.np).mode < pextern then
                  gc_ass_escriure("  call _e" &trim(tp(c3a.np).et'img,ada.strings.left));
               else
                  gc_ass_escriure("  call _"&consulta(tnoms,id_nom(tp(c3a.np).id)));
               end if;
               param4 := tp(c3a.np).nparam * 4;
               gc_ass_escriure("  addl $"&trim(param4'img,ada.strings.left)&", %esp");
            when params =>
               gc_ass_escriure(lda(c3a.xPS, eax));
               gc_ass_escriure("  pushl %eax");
            when paramc =>
               gc_ass_escriure(lda(c3a.xPC, eax));
               gc_ass_escriure(ld(c3a.yPC, ebx));
               gc_ass_escriure("  addl %ebx, %eax");
               gc_ass_escriure("  pushl %eax");
         end case;
      end loop;
   end genera_ass;

   function to_Lower_Case(r: in registre) return String is
   begin
      return Ada.Strings.Fixed.Translate(trim(r'img,ada.strings.left), Ada.Strings.Maps.Constants.Lower_Case_Map);
   end to_Lower_Case;

end semantica.gc_ass;
