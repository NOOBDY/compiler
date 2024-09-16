let l = List.init 1_000_000 (fun x -> x + 1)

let rev l =
    let rec aux l1 l2 =
        match l1 with
        | [] -> l2
        | x :: xs -> aux xs (x :: l2)
    in
        aux l []

let rec map f l =
    match l with
    | [] -> []
    | x :: xs -> f x :: map f xs

let () = List.iter (Printf.printf "%d ") (rev l)
let () = print_newline ()
let () = List.iter (Printf.printf "%d ") (map (fun x -> x + 2) l)
let () = print_newline ()
