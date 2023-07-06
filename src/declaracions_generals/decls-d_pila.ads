with decls.declaracions_generals;
use decls.declaracions_generals;
generic type E is private;
package decls.d_pila is
   type pila is limited private;

   procedure crearPila(p: out pila);
   procedure empilar(p: in out pila; x: in E);
   procedure desempilar(p: in out pila);
   function cim(p: in pila) return E;
   function esBuida(p: in pila) return boolean;
   pbuida: exception;

private
   type iPila is new integer range 0..100;
   type lPila is array (iPila) of E;

   type pila is record
      llista: lPila;
      cim: iPila;
   end record;

end decls.d_pila;
