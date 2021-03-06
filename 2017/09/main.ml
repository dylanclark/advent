open Core

type t = { score:int; garbage_count:int; in_garbage:bool; current_group:int; }

let rec solve input ({score; garbage_count; in_garbage; current_group} as state) =
  match input with
  | [] -> state
  | '{'::l when in_garbage = false ->
    solve l {state with current_group = current_group + 1}
  | '}'::l when in_garbage = false ->
    solve l {state with score = score + current_group; current_group = current_group - 1}
  | '<'::l when in_garbage = false ->
    solve l {state with in_garbage = true;}
  | '>'::l  ->
    solve l {state with in_garbage = false;}
  | '!'::_::l ->
    solve l state
  | _::l when in_garbage = true ->
    solve l {state with garbage_count = garbage_count + 1;}
  | _::l ->
    solve l state

let input file =
  In_channel.read_all file
  |> String.to_list

let _ =
  let input = input "./input.txt" in
  let state = solve input {score=0; garbage_count=0; in_garbage=false; current_group=0;} in
  printf "a: %d\n" state.score;
  printf "b: %d\n" state.garbage_count;