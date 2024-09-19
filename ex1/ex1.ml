(* (a) *)
let rec fact n = if n = 0 then 1 else n * fact (n - 1)

(* (b) *)
let rec nb_bit_pos n = if n = 0 then 0 else (n land 1) + nb_bit_pos (n lsr 1)
let () = print_int (fact 10)
let () = print_string "\n"
let () = print_int (nb_bit_pos 9)
let () = print_string "\n"
