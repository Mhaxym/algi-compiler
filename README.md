## Overview
This is just a small project I did during my compiter science degree (*`mid-2015`*).

It's a compiler for a small language called "ALGI" implemented in Ada.
The language is a simple imperative language with a Pascal-like syntax.

### To test your code
- Go to `src/execucio`.
- Compile your code using `algi.bat` specifying your file as an argument.
- You could also use `algi.exe` directly.
- This will generate a `*.exe` file. It'll also generate a `*.c3a` wich is a three adress code file and a `*.o`/`*.s` with the assembly code.
- Run the `*.exe` file to execute your code.

### There are some examples in the `src/execucio` folder.

`Bubble Sort` example:
```ALGI
procedure main is
  type index is new integer range 0..9;
  type ar is array (index) of integer;

  procedure bubble_sort (a : in out ar) is
    hhc : boolean;
    i : integer;
    j : index;
  begin
    j := 0;
    hhc := true;
    while hhc loop
      hhc := false;
      while j < 10 loop
        if a(j+1) < a(j) then
          hhc := true;
          i := a(j+1);
          a(j+1) := a(j);
          a(j) := i;
        end if;
        j := j + 1;
      end loop;
      j:=0;
    end loop;
  end bubble_sort;
    b : ar;
    j : index;
    k : integer;
  begin
    j := 0;
    puts("Introduiu els valors que voleu ordenar: ");
    new_line;
    while j < 10 loop
      new_line;
      puts(" Valor : ");
      geti(k);
      b(j) := k;
      j := j + 1;
    end loop;
    bubble_sort(b);
    j := 0;
    puts("Els valors ordenats son: "); new_line;
    while j < 10 loop
      puts("  ");
      puti(b(j));
      j := j + 1;
    end loop;
  end main;
  ```

  ### Notes
  - Almost everything is commented/coded in Catalan.
  - This was implemented using Ada 2012 and GNAT 2015.