(*Request.ml this will be the class that will have all the functions for requests. Also be the type for %start main*)
type contact = {name:string; email:string; phonenum:string;};;
type request = Math of int| Clock of int | Sentence of string  | Help of string | ContactReq of contact | Note of string ;;
