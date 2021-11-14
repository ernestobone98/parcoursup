open Definitions

let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let k = ref 0 in
    let conf = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let p : (femme*femme) array = [||] in
    while !k < 1 do
      let f = ref (entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k))) in
      while conf.rang_appel_de.(!k) < 1 do
        if conf.fiance_de.(!f) = None then begin
          conf.fiance_de.(!f) <- Some !k
        end
        else if entree.prefere.(!f) !k (Option.get conf.fiance_de.(!f))
        then conf.fiance_de.(!f) <- Some !k
      done;
      (* p.(!k) <- (!k,conf.rang_appel_de.(!k)); *)
      
      k := !k + 1;
    done;
    (* let p : (femme*femme) array = [||] in
    for i=0 to entree.n do
      p.(i) <- (i,conf.rang_appel_de.(i))
    done; *)
    
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide"


  (* let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let conf = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    print_configuration conf;
    (* if affiche_config then (); *)
    let p : (femme*femme) array = [||] in
    Array.to_list p;

  end
  else invalid_arg "L'entree n'est pas valide" *)



(* let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté" *)