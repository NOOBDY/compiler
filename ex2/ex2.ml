let fibo n =
    let rec aux m acc1 acc2 =
        if m = 0
            then acc1
            else aux (m - 1) acc2 (acc1 + acc2)
    in
        aux n 0 1

let () = print_int (fibo 5)
