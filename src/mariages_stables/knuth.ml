(* open Definitions *)

let algo ?(affiche_config=false) entree = 
let open Definitions in
  if (entree_valide entree) then begin 
    ignore affiche_config;
    let k = ref 0 in
    while k < entree.n do
      let h = ref (string_of_homme !k) in
      let f = ref (string_of_femme(entree.liste_appel_de.(!h).(conf.rang_appel_de.(!h)) in
      while conf.rang_appel_de.(!h) < entree.n do
        if conf.fiance_de.(!f))) = None then begin
          (*Casar a la mujer actual*)
        end
        else if (*Mirar si la mujer lo prefiere*)
      done;
      k := !k + 1;
    done;
  end
  else invalid_arg "L'entree n'est pas valide"


(* let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté" *)