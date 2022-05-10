(* lexer.mll *)
{ 
open Parser 
exception Eof
}
rule token = parse 
'+' {PLUS}
|[' ' '\t'] {token lexbuf}
|['\n'] {EOL}
|['0'-'9']+ as x {INT (int_of_string x)}
| '-' {MINUS}
|'*' {TIMES}
|'/' {DIV}
|'(' {LPAREN}
|')' {RPAREN}
|"CALCULATE" {CALCULATOR}
|['a'-'z']+ as s{STRING (s)}
|"SET A TIMER FOR" {TIMER}
|"DAYS""S"? {DAY}
|"HOUR""S"? {HOUR}
|"MINUTE""S"? {MIN}
|"SECOND""S"? {SEC}
|"AND" {AND}
|"CREATE NEW CONTACT" {CONTACT}
|"MAKE A NEW NOTE" {NOTE}
|['A'-'Z''a'-'z']+ as x{NAME (x)}
|(['0'-'9']['0'-'9']['0'-'9']'-'['0'-'9']['0'-'9']['0'-'9']'-'['0'-'9']['0'-'9']['0'-'9']['0'-'9']) as x{PHONENUM (x)}
|(['a'-'z']+'@'['a'-'z']+".com") as x{EMAIL (x)}
| eof {raise Eof}



