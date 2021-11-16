open Definitions

let choix x = function
  | (-1) -> None
  | _ -> Some x

let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let k = ref 0 in
    let h: homme ref = ref 0 in
    let f: femme ref = ref 0 in
    (* let choix = ref (-1) in *)
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let p : (femme*femme) array = Array.make entree.n (0,0) in
    while !k < entree.n do
      while (choix !h) <> (choix (-1)) do
        f := entree.liste_appel_de.(!h).(conf.rang_appel_de.(!h));
        if conf.fiance_de.(!f) = None then begin
          conf.fiance_de.(!f) <- Some !h;
          h:= (-1) ;
          print_configuration conf;

          (*h := !h + 1;*)
        end
        else if entree.prefere.(!f) !h (Option.get conf.fiance_de.(!f))
        then begin 
          let h_tmp = Option.get conf.fiance_de.(!f) in
          conf.fiance_de.(!f) <- Some !h;
          h := h_tmp;
          conf.rang_appel_de.(!h) <- conf.rang_appel_de.(!h) + 1; (* on peut le mettre au debut car le rang n'affecte pas l'homme*)
        end else
          conf.rang_appel_de.(!h) <- conf.rang_appel_de.(!h) + 1;
          print_configuration conf;
      done;
      p.(!k) <- (!h,conf.rang_appel_de.(!h)); 
      k := !k + 1;
    done;
    (* let p : (femme*femme) array = [||] in
    for i=0 to entree.n do
      p.(i) <- (i,conf.rang_appel_de.(i))
    done; *)
    
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide"


(* let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté" *)