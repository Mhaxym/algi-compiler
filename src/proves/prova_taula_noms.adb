with Ada.Text_IO; use Ada.Text_IO;
with decls.d_taula_noms; use decls.d_taula_noms;
with decls.declaracions_generals; use decls.declaracions_generals;

procedure prova_taula_noms is
   id1, id2, id3, id4, id5, id6, id7, id8: id_nom;
   id9, id10, id11, id12 : id_str;
   tn: taula_noms;
begin
   tbuida(tn);
   -- El primer que farem es provar si funciona la part de la taula de noms que
   -- utilitza caracters.
   put("-----------------------------------------------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   put("------------------PROVA TAULA DE NOMS----------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   new_line;
   new_line;
   put("------------------------------------------------------------");new_line;
   put("--------------------IMATGES DELS ID_NOM---------------------");new_line;
   put("------------------------------------------------------------");new_line;
   new_line;
   put("Primer posarem els texts dins els id_nom, i imprimirem la seva imatge.");new_line;
   new_line;
   posa(tn, "Hola", id1);
   put("La imatge de l'id_nom 1 és: ");
   put(id_nom'image(id1));new_line;
   posa(tn, "com", id2);
   put("La imatge de l'id_nom 2 és: ");
   put(id_nom'image(id2));new_line;
   posa(tn, "va", id3);
   put("La imatge de l'id_nom 3 és: ");
   put(id_nom'image(id3));new_line;
   posa(tn, "?", id4);
   put("La imatge de l'id_nom 4 és: ");
   put(id_nom'image(id4));new_line;
   posa(tn, "Tingui", id5);
   put("La imatge de l'id_nom 5 és: ");
   put(id_nom'image(id5));new_line;
   posa(tn, "un", id6);
   put("La imatge de l'id_nom 6 és: ");
   put(id_nom'image(id6));new_line;
   posa(tn, "bon", id7);
   put("La imatge de l'id_nom 7 és: ");
   put(id_nom'image(id7));new_line;
   posa(tn, "dia!", id8);
   put("La imatge de l'id_nom 8 és: ");
   put(id_nom'image(id8));new_line;

   new_line;
   put("------------------------------------------------------------");new_line;
   put("--------------------IMATGES DELS ID_STR---------------------");new_line;
   put("------------------------------------------------------------");new_line;
   new_line;

   posa_str(tn,"Per a fer les proves de la taula de noms amb strings.",id9);
   put("La imatge de l'id_str 1 és: ");
   put(id_str'image(id9));
   posa_str(tn,"Pots posar qualsevol string.",id10);new_line;
   put("La imatge de l'id_str 2 és: ");
   put(id_str'image(id10));
   posa_str(tn,"Aquest és l'string de prova número 3 del compilador.",id11);new_line;
   put("La imatge de l'id_str 3 és: ");
   put(id_str'image(id11));new_line;
   posa_str(tn,"Pots posar tots els que vulguis.",id12);
   put("La imatge de l'id_str 4 és: ");
   put(id_str'image(id12));new_line;

   -- A continuació imprimirem el contingut de cada id_nom utilitzant la
   -- function consulta.

   new_line;
   put("-----------------------------------------------------------");new_line;
   put("------------------CONTINGUT DELS ID_NOM--------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   new_line;

   put("----- A continuació veurem el valor de cada id_nom --------");new_line;
   new_line;
   put(consulta(tn, id1));new_line;
   put(consulta(tn, id2));new_line;
   put(consulta(tn, id3));new_line;
   put(consulta(tn, id4));new_line;
   put(consulta(tn, id5));new_line;
   put(consulta(tn, id6));new_line;
   put(consulta(tn, id7));new_line;
   put(consulta(tn, id8));new_line;

   -- Imprimim el contingut dels string per comprovar que s'han escrit bé i que
   -- els algoritmes són capassos d'accedir a les dades.

   new_line;
   put("-----------------------------------------------------------");new_line;
   put("------------------CONTINGUT DELS ID_STR--------------------");new_line;
   put("-----------------------------------------------------------");new_line;
   new_line;

   put("El contingut del String 1 és: ");
   put(consulta_str(tn,id9));new_line;
   put("El contingut del String 2 és: ");
   put(consulta_str(tn,id10));new_line;
   put("El contingut del String 3 és: ");
   put(consulta_str(tn,id11));new_line;
   put("El contingut del String 4 és: ");
   put(consulta_str(tn,id12));new_line;
   new_line;
   new_line;
end prova_taula_noms;
