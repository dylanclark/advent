open Core
open Advent2017

let _ =
    match Sys.argv.(1) |> Int.of_string with
    | 1 -> printf "day one:\n"; One.solve ();
    | 2 -> printf "day two:\n"; Two.solve ();
    | 3 -> printf "day three:\n"; Three.solve ();
    | 4 -> printf "day four:\n"; Four.solve ();
    | 5 -> printf "day five:\n"; Five.solve ();
    | 6 -> printf "day five:\n"; Six.solve ();
    | _ -> printf "not there yet."