open Definitions

module type PIOCHE = sig
  type 'a t
    val of_list: 'a list -> 'a t 
    val pioche : 'a t -> 'a option 
     val defausse : 'a -> 'a t -> unit 
end



module Pile : PIOCHE = struct
  
  type 'a t = 'a list ref (* unit <- à modifier *) (* deja modifie *)

  let of_list l = 
    let l2 = ref [] in 
    l2 := !l2 @ l ;
    l2 

  let pioche p = match !p with
  | [] -> None
  | hd::tl -> p := tl ;
  Some hd 

  let defausse x p =
    p := x::!p

end



module File : PIOCHE = struct

  type 'a t = 'a list ref (*unit*) (* <- à modifier *)
  

  let of_list l = 
    let l2 = ref [] in 
    l2 := !l2 @ l ;
    l2 
  let pioche p = match !p with
  | [] -> None
  | hd::tl -> p := tl ;
  Some hd 

  let defausse x p =
    let l2 = ref (List.rev !p) in 
    p := List.rev (x::!l2)

end

module Algo(P:PIOCHE) = struct

  let run entree =
    let n = entree.n in
    let config = {rang_appel_de = Array.make n 0;fiance_de = Array.make n None } in
    let p = P.of_list (List.init n (fun i -> i)) in
    let h = ref (P.pioche p) in 
    let f = ref 0 in
    let t : (homme*femme) array = Array.make entree.n (0,0) in

    while !h <> None do       
      f := entree.liste_appel_de.(Option.get !h).(config.rang_appel_de.(Option.get !h));
      if config.fiance_de.(!f) = None then begin
        t.(Option.get !h) <- (Option.get !h,!f);
        config.fiance_de.(!f) <- !h;
      end
      else begin
        if entree.prefere.(!f) (Option.get !h) (Option.get config.fiance_de.(!f)) then begin
            let tmp =  config.fiance_de.(!f) in
            t.(Option.get !h) <- (Option.get !h,!f);
            config.fiance_de.(!f)<- !h;
            h :=  tmp;
          end;
        config.rang_appel_de.(Option.get !h) <- config.rang_appel_de.(Option.get !h) +1 ;
        P.defausse (Option.get !h) p ;
      end;
      h := P.pioche p;
    done;
    Array.to_list t;
end