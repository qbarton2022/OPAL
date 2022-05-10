(*calc.ml*)
open Lexing
open Parsing
open Unix

let fileContact= "contact.csv"
let noteFile = "notes.txt"

let writeContact name email phoneNum =
  let file = open_out fileContact in 
    Printf.fprintf file "%s, %s, %s\n" name email phoneNum;
    close_out file

let makeNote noteMessage =
  let nFile = open_out  noteFile in 
    Printf.fprintf nFile "%s\n" "-- "^string_of_int tm_month^"/"^string_of_int tm_mday^"/"^string_of_int tm_year^"  "^string_of_int tm_hour^":"^ string_of_int tm_min^" --\n"^noteMessage;
    close_out nFile


let printSentence (sent:Request.request) = 
  match sent with
    | Clock (a) -> print_endline ("Timer set for "^string_of_int a^" seconds")
    | Math (a) -> print_endline (string_of_int a)
    | ContactReq (a) -> writeContact a.name a.email a.phonenum
    | Note (a) -> noteMessage a
    | _ -> print_endline ("mmmmmmm")
let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
    let result = Parser.main Lexer.token lexbuf in
      printSentence result; print_newline(); flush stdout
    done
  with Lexer.Eof ->
    print_string "Lexer.Eof";
    exit 0;;


