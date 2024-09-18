type 'a seq =
    | Elt of 'a
    | Seq of 'a seq * 'a seq

let (@@) x y = Seq(x, y)

(* (a) *)
let rec hd (l : 'a seq) : 'a =
    match l with
    | Elt x -> x
    | Seq (x, _) -> hd x

let tl (l : 'a seq) : 'a seq =
    match l with
    | Elt _ -> failwith "empty array"
    | Seq (x, y) -> let rec aux l' =
        match l' with
        | Seq(Elt _, y') -> y'
        | Seq(x', y') -> aux x' @@ y'
        | Elt _ -> failwith "impossible"
        in
            aux (Seq(x, y))

let rec mem (v : 'a) (l : 'a seq) : bool =
    match l with
    | Elt x -> x == v
    | Seq (x, y) -> mem v x || mem v y

let rec rev (l : 'a seq) : 'a seq =
    match l with
    | Elt x -> Elt x
    | Seq (x, y) -> Seq (rev y, rev x)

let rec map (f : 'a -> 'b) (l : 'a seq) : 'b seq =
    match l with
    | Elt x -> Elt (f x)
    | Seq (x, y) -> map f x @@ map f y

let rec fold_left (f : 'acc -> 'a -> 'acc) (acc : 'acc) (l : 'a seq) : 'acc =
    match l with
    | Elt x -> f acc x
    | Seq (x, y) -> fold_left f (fold_left f acc x) y

let rec fold_right (f : 'a -> 'acc -> 'acc) (l : 'a seq) (acc : 'acc) : 'acc =
    match l with
    | Elt x -> f x acc
    | Seq (x, y) -> fold_right f x (fold_right f y acc)

(* (b) *)
let seq2list (l : 'a seq) : 'a list = fold_right (fun v acc -> v :: acc) l []

(* TODO: tail recursive seq2list *)

(* (c) *)
let find_opt (x : 'a) (l : 'a seq) : 'a option =
    let aux (res, i) v =
        match res with
        | None ->
                if x = v
                    then (Some i, i + 1)
                    else (res, i + 1)
        | res' -> (res', i + 1)
    in
        fst (fold_left aux (None, 0) l)

(* (d) *)
let nth (s : 'a seq) (n : int) : 'a =
    let aux (res, i) v =
        match res with
        | None ->
                if i = n
                    then (Some v, i + 1)
                    else (res, i + 1)
        | res' -> (res', i + 1)
    in
        match fst (fold_left aux (None, 0) s) with
        | None -> failwith "index out of bounds"
        | Some v -> v

let print_list (l : 'a seq) = List.iter (Printf.printf "%d ") (seq2list l)

let s1 = Seq(Elt 1, Seq(Elt 2, Elt 3))
let s2 = Seq(Seq(Elt 1, Seq(Elt 2, Elt 4)), Elt 3)

let () = print_int (hd s1)
let () = print_newline ()
let () = print_list (tl s2)
let () = print_newline ()
let () = print_list (map (fun v -> v + 1) s2)
let () = print_newline ()
let () = print_list (rev s2)
let () = print_newline ()
let () = print_string (if mem 2 s2 then "true" else "false")
let () = print_newline ()
let () = print_int (fold_left (+) 0 s1)
let () = print_newline ()
let () = print_int (fold_right (+) s1 0)
let () = print_newline ()
let () = List.iter (Printf.printf "%d ") (seq2list s2)
let () = print_newline ()
let () = match find_opt 1 s2 with | Some i -> print_int i | None -> print_string "None"
let () = print_newline ()
let () = print_int (nth s2 1)
let () = print_newline ()
