let explode s' = List.init (String.length s') (fun i -> String.make 1 (String.get s' i))
let unexplode = String.concat ""

(* (a) *)
let palindrome str =
  let str_rev s' = unexplode (List.rev (explode s')) in
  str = str_rev str
;;

(* (b) *)
let compare m1 m2 =
  let rec aux l1 l2 =
    match l1, l2 with
    | [], _ :: _ -> true
    | x :: xs, y :: ys -> if x = y then aux xs ys else x < y
    | _ -> false
  in
  aux (explode m1) (explode m2)
;;

let compare' m1 m2 =
  let l1 = String.length m1 in
  let l2 = String.length m2 in
  let rec aux i =
    match () with
    | () when l1 = i && l2 > i -> true
    | () when String.get m1 i = String.get m2 i -> aux (i + 1)
    | _ -> false
  in
  aux 0
;;

let take n str = String.sub str 0 n
let tail str = String.sub str 1 (String.length str - 1)

(* (c) *)
let factor m1 m2 =
  let rec aux window tape =
    if String.length window > String.length tape
    then false
    else if window = take (String.length window) tape
    then true
    else aux window (tail tape)
  in
  aux m1 m2
;;

let () = print_endline (if palindrome "kayak" then "true" else "false")
let () = print_endline (if compare "kayak" "bayak" then "true" else "false")
let () = print_endline (if compare' "kayak" "bayak" then "true" else "false")
let () = print_endline (if factor "ka" "kayak" then "true" else "false")
