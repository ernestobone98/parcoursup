(* open Definitions  *)
(* 
let algo ?(affiche_config=false) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let h = ref 0 in
    let f = ref 0 in 
    let n = entree.n in 
    let conf = {rang_appel_de = Array.make n 0 ; fiance_de = Array.make n None} in 
    while conf.fiance_de.(!f) <> None do 
      for i=0 to n-1 do 
        f := entree.liste_appel_de.(!h) 
      done
    done
  end
  else
  failwith "non implémenté" *)

let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté"