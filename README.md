# OCamlAssistant
Its an OCaml Assistant
## Run It
To compile everything execute 
 - ocamllex lexer.mll   *#generate lexer.ml*
 - ocamlyacc parser.mly   *#generate parser.ml and parser.mli*
 - ocamlc -c request.ml
 - ocamlc -c parser.mli
 - ocamlc -c lexer.ml
 - ocamlc -c parser.ml
 - ocamlc -c calc.ml
 - ocamlc -o calc.exe lexer.cmo parser.cmo unix.cma calc.cmo
 
Read more at [Ocaml Manual](https://v2.ocaml.org/manual/lexyacc.html)
