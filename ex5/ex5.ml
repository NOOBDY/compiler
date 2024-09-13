(* fancy η reduction *)
(* (a) *)
let square_sum = List.map (fun i -> i * i)

(* (b) *)
let find_opt x = List.find_opt (fun v -> v == x)

let () =
    let list = [38; 27; 43; 3; 9; 82; 10] in
    List.iter (Printf.printf "%d ") (square_sum list);
      print_newline ()

let () =
    let list = [38; 27; 43; 3; 9; 82; 10] in
    match (find_opt 3 list) with
    | Some v -> print_int v;
      print_newline ()
    | None -> print_endline "Not found"
