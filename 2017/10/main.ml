open Core

type state = {
  current_position:int;
  skip_size: int;
}

let reverse_slice array start len =
  let length = Array.length array in
  for i = 0 to (len / 2) - 1 do
    let j = (start + i) % length in
    let k = (start + len - 1 - i) % length in
    Array.swap array j k;
  done

let knot_hash array state length =
  let current_position = state.current_position in
  reverse_slice array current_position length;
  let array_length = Array.length array in
  let skip = state.skip_size in
  {
    current_position = (current_position + length + skip) % array_length;
    skip_size = skip + 1
  }

let hash init array lengths =
  let f = knot_hash array in
  List.fold lengths ~init ~f

let create_sparse_hash input =
  let sparse_hash = Array.init 256 Fn.id in
  let rec loop state n =
    if n = 0 then sparse_hash
    else loop (hash state sparse_hash input) (n-1)
  in loop {current_position = 0; skip_size = 0;} 64

let create_dense_hash sparse =
  let dense = Array.create ~len:16 0 in
  for i = 0 to 255 do
    let j = i / 16 in
    dense.(j) <- Int.bit_xor dense.(j) sparse.(i);
  done;
  dense

let read_input () =
  let additional_lengths = In_channel.read_all "./input.txt"
                           |> String.to_list
                           |> List.map ~f:Char.to_int in
  List.append additional_lengths [17; 31; 73; 47; 23]

let _ =
  let hash = read_input ()
             |> create_sparse_hash
             |> create_dense_hash
             |> Array.map ~f:(sprintf "%02x")
             |> Array.to_list
             |> String.concat in
  printf "hash: %s\n" hash
