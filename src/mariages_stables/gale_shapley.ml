(* open Definitions 

let algo ?(affiche_config=false) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let h = ref 0 in
    let f = ref 0 in 
    let n = entree.n in 
    let pretendants = ref [] in
    let h_celibataires = ref [] in 
    let conf = {rang_appel_de = Array.make n 0 ; fiance_de = Array.make n None} in 
    for i= 0 to n -1 do
      h_celibataires := !h_celibataires@[i];
    done
    while !h_celibataires <> []  do 
      !h_celibataires := [];

      
    done
  end
  else
  failwith "non implémenté" *)

let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté"