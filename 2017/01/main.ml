open Core

let shift l n =
  let first, second = List.split_n l n in
  List.append second first

let solve n sequence =
  let f acc a b = if a = b then acc + a else acc in
  List.fold2_exn sequence (shift sequence n) ~init:0 ~f

let sequence str =
  let chars = String.to_list str in
  List.filter_map chars ~f:Char.get_digit

let a seq =
  solve 1 seq

let b seq =
  solve (List.length seq / 2) seq

let _ =
  let data = In_channel.read_all "./input.txt" in
  let seq = sequence data in
  a seq |> printf "a: %d\n";
  b seq |> printf "b: %d\n";