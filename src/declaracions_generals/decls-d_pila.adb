package body decls.d_pila is
      procedure crearPila(p: out pila) is
   begin
      p.cim := 0;
   end crearPila;

   procedure empilar(p: in out pila; x: in E) is
   begin
      p.cim := p.cim + 1;
      p.llista(p.cim) := x;
   end empilar;

   procedure desempilar(p: in out pila) is
   begin
      if not esBuida(p) then
         p.cim := p.cim - 1;
      end if;
   end desempilar;

   function cim(p: in pila) return E is
   begin
      if not esBuida(p) then
         return p.llista(p.cim);
      else
         raise pbuida;
      end if;
   end cim;

   function esBuida(p: in pila) return boolean is
   begin
      return p.cim = 0;
   end esBuida;
end decls.d_pila;
