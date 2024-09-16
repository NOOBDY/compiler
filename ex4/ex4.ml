let split l =
    let rec aux l' left right =
        match l' with
        | [] -> (left, right)
        | x :: xs -> if List.length xs < List.length l / 2
            then
                aux xs (x :: left) right
            else
                aux xs left (x :: right)
    in
    aux l [] []

let rec merge l1 l2 =
    match (l1, l2) with
    | ([], l2') -> l2'
    | (l1', []) -> l1'
    | (x :: xs, y :: ys) -> if x <= y
        then
            x :: merge xs l2
        else
            y :: merge l1 ys

let rec sort l =
    match split l with
    | (xs, []) -> xs
    | ([], ys) -> ys
    | (xs, ys) -> merge (sort xs) (sort ys)

let () = List.iter (Printf.printf "%d ") (sort [2; 4; 4; 1;])
let () = print_newline ()
