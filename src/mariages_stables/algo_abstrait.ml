(* open Definitions *)

module type PIOCHE = sig
  type 'a t
    val of_list: 'a list -> 'a t 
    val pioche : 'a t -> 'a option 
     val defausse : 'a -> 'a t -> unit 
end



module Pile : PIOCHE = struct
  
  type 'a t = unit (* <- à modifier *)

  let of_list l = 
    ignore l;
    failwith "non implémenté"

  let pioche p = 
    ignore p;
    failwith "non implémenté"

  let defausse x p =
    ignore x;
    ignore p;
    failwith "non implémenté"

end



module File : PIOCHE = struct
  
  type 'a t = unit (* <- à modifier *)

  let of_list l = 
    ignore l;
    failwith "non implémenté"

  let pioche p =
    ignore p;
    failwith "non implémenté"

  let defausse x p =
    ignore x;
    ignore p;
    failwith "non implémenté"

end




module Algo(P:PIOCHE) = struct
  
  let run entree = 
    ignore entree;
    failwith "non implémenté"

end
