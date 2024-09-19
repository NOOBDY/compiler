(* fancy η reduction *)
(* (a) *)
let square_sum = List.fold_left (fun acc i -> acc + (i * i)) 0

(* (b) *)
let find_opt v l =
  let rec aux l' i =
    match l' with
    | [] -> None
    | x :: xs ->
        if v = x
          then Some v
          else aux xs (i + 1)
  in
    aux l 0

let find_opt' x l =
  let aux (res, i) v =
      match res with
      | None when x == v -> (Some i, i + 1)
      | _ -> (res, i + 1)
  in
    fst (List.fold_left aux (None, 0) l)

let () =
    let list = [38; 27; 43; 3; 9; 82; 10] in
    Printf.printf "%d" (square_sum list);
      print_newline ()

let () =
    let list = [38; 27; 43; 3; 9; 82; 10] in
    match (find_opt 43 list) with
    | Some v -> print_int v;
      print_newline ()
    | None -> print_endline "Not found"

let () =
    let list = [38; 27; 43; 3; 9; 82; 10] in
    match (find_opt' 43 list) with
    | Some v -> print_int v;
      print_newline ()
    | None -> print_endline "Not found"
