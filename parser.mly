/*parser.mly*/
%{
%}
%token EOL
%token <int> INT 
%token <string> STRING 
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token GET
%token TIMER CALCULATOR SENTENCE
%token AND
%token SEC MIN HOUR DAY
%token CONTACT 
%token NOTE
%token <string> PHONENUM NAME EMAIL
%left PLUS MINUS
%left TIMES DIV
%nonassoc UMINUS
%start main 
%type <Request.request> main 

%%

main:  /*non-terminal*/
  sentence EOL {$1}
  ;
sentence:
  TIMER timerExpr {Request.Clock ($2)}
  |CALCULATOR calcExpr {Request.Math ($2)}
  |SENTENCE stringExpr {Request.Sentence ($2)}
  |NOTE stringExpr {Request.Note($2)}
  |CONTACT conExpr {$2}
  ;
calcExpr: /*non-terminal*/
  INT { $1 }  /*a bunch of or statements*/
  |LPAREN calcExpr RPAREN {$2}
  |calcExpr PLUS calcExpr {$1 + $3} 
  |calcExpr MINUS calcExpr {$1 - $3}
  |calcExpr TIMES calcExpr {$1 * $3}
  |calcExpr DIV calcExpr {$1 / $3}
  |MINUS calcExpr %prec UMINUS {- $2}
  ;
stringExpr:
  STRING {$1}
  ;
timerExpr:
  timerExprD {$1}
  |timerExprH {$1}
  |timerExprM {$1}
  |timerExprS {$1}
  ;
timerExprD:
    calcExpr DAY {$1 * 86400}
    | calcExpr DAY AND timerExprH {$1 * 86400 + $4}
    | calcExpr DAY AND timerExprM {$1 * 86400 + $4}
    | calcExpr DAY AND timerExprS {$1 * 86400 + $4}
  /*do later im lazy*/
;
timerExprH:
  calcExpr HOUR {$1 * 3600}
    | calcExpr HOUR AND timerExprM {$1 * 3600 + $4}
    | calcExpr HOUR AND timerExprS {$1 * 3600 + $4}
;
timerExprM:
  calcExpr MIN {$1 * 60}
    | calcExpr MIN AND timerExprS {$1 * 60 + $4}
;
timerExprS:
  calcExpr SEC {$1}
;
conExpr:
  PHONENUM NAME EMAIL {Request.ContactReq {name = $2;email = $3;phonenum = $1}}
  |PHONENUM EMAIL NAME {Request.ContactReq {name = $3;email = $2;phonenum = $1}}
  |NAME EMAIL PHONENUM {Request.ContactReq {name = $1;email = $2;phonenum = $3}}
  |NAME PHONENUM EMAIL {Request.ContactReq {name = $1;email = $3;phonenum = $2}}
  |EMAIL PHONENUM NAME {Request.ContactReq {name = $3;email = $1;phonenum = $1}}
  |EMAIL NAME PHONENUM {Request.ContactReq {name = $2;email = $1;phonenum = $3}}
;
  
  

