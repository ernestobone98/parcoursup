open Definitions

let choix x = function
  | (-1) -> None
  | _ -> Some x

let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let k = ref 0 in
    let x: homme ref = ref 0 in
    let f: femme ref = ref 0 in
    (* let choix = ref (-1) in *)
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let p : (femme*femme) array = Array.make entree.n (0,0) in
    while !k < entree.n do
      while (choix !x) <> None do
        f := entree.liste_appel_de.(!x).(conf.rang_appel_de.(!x));
        if conf.fiance_de.(!f) = None then begin
          conf.fiance_de.(!f) <- Some !x;
          x := !x + 1;
        end
        else if entree.prefere.(!f) !x (Option.get conf.fiance_de.(!f))
        then begin 
          let h_tmp = Option.get conf.fiance_de.(!f) in
          conf.fiance_de.(!f) <- Some !x;
          x := h_tmp;
          conf.rang_appel_de.(!x) <- conf.rang_appel_de.(!x) + 1;
        end
      done;
      (* p.(!k) <- (!h,conf.rang_appel_de.(!h)); *)
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