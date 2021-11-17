open Definitions

(* let choix x = function
  | None -> raise()
  | _ -> x *)

let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let k = ref 0 in
    let f: femme ref = ref 0 in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let p : (femme*femme) array = Array.make entree.n (0,0) in
    while !k < entree.n do
      f := entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k));
      if conf.fiance_de.(!f) = None then begin
        conf.fiance_de.(!f) <- Some !k;
      end
      else
      while !k < entree.n do
        f := entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k)); (*Verificar esto*)
        if entree.prefere.(!f) !k (Option.get conf.fiance_de.(!f))
        then begin 
          conf.fiance_de.(!f) <- Some !k;
          conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
        end
        else conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
    done;

      print_configuration conf;
      p.(!k) <- (!k,conf.rang_appel_de.(!k));
      k := !k + 1;
    done;
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

(* let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let k = ref 0 in
    let x: homme ref = ref 0 in (*utilizar una sola variable*)
    let f: femme ref = ref 0 in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let p : (femme*femme) array = Array.make entree.n (0,0) in
    while !k < entree.n do
      while !x <> None do
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
        else conf.rang_appel_de.(!x) <- conf.rang_appel_de.(!x) + 1;
      done;
      print_configuration conf;
      p.(!k) <- (!x,conf.rang_appel_de.(!x));
      k := !k + 1;
    done;
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide" *)