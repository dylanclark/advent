{
open Lexing
open Parser

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_bol = lexbuf.lex_curr_pos;
               pos_lnum = pos.pos_lnum + 1
    }
}

let int = ['0'-'9']+
let letter = ['a'-'z']
let whitespace = [' ' '\t']+
let new_line = '\n'

rule read =
parse
| whitespace      { read lexbuf }
| new_line        { next_line lexbuf; read lexbuf }
| ","             { COMMA }
| "/"             { SLASH }
| (int as i)      { NUMBER (int_of_string i) }
| (letter as l)   { LETTER (l) }
| eof             { EOF }