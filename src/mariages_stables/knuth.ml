open Definitions 

let algo ?(affiche_config=false) entree = 
  if (entree_valide entree) then begin 
    ignore affiche_config;
    let (k : int ref)  = ref 0 in
    let conf = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n  None} in 
    while !k < entree.n do
      let h : (homme ref) = ref !k in
      let f = ref (entree.liste_appel_de.(!h).(conf.rang_appel_de.(!h))) in
      while conf.rang_appel_de.(!h) < entree.n do
        if conf.fiance_de.(!f) = None then begin
          (* Casar a la mujer actual - Marier a la femme actuelle *)
          conf.fiance_de.(!f) <- Some !k;
        end

        else if entree.prefere.(!f) !h conf.fiance_de.(!f)
          (*Mirar si la mujer lo prefiere
          Voir si la femme actuelle le prefere 
          *)
         then conf.fiance_de.(!f) <- Some !k
      done;
      k := !k + 1;
    done;
  end
  else invalid_arg "L'entree n'est pas valide"


(* let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté" *)