open Definitions

let algo ?(affiche_config=false) entree =
  if (entree_valide entree) then begin 
    ignore affiche_config;
    let k = ref 0 in
    let tmp = ref 0 in
    let conf = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in
    let f = ref (entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k))) in
    (*let next = ref 0 in*)
    let p : (homme*femme) array = Array.make entree.n (0,0) in 
    while !k < entree.n do 
      let quite_loop = ref false in
      f := entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k));
      Format.printf "Permiere boucle : \nk = %d f = %d\n" !k !f;
      if conf.fiance_de.(!f) = None then begin
        conf.fiance_de.(!f) <- Some !k;
        Format.printf "f ete celib donc on marie : \nk = %d f = %d\n" !k !f;
      end
      else while( conf.rang_appel_de.(!k) < entree.n && not !quite_loop) do
          if entree.prefere.(!f) !k (Option.get conf.fiance_de.(!f)) then begin
            tmp := Option.get conf.fiance_de.(!f);
            conf.fiance_de.(!f) <- Some !k;
            p.(!k) <- (!k,conf.rang_appel_de.(!k));
            Format.printf "Si f prefere celui qui propose et non actuel donc on marie : \nk = %d f = %d\n" !k !f;
            k:= !tmp;
            conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
            (* k ne propose pas a la femme suivante*)
            quite_loop := true;
          end
          else begin
            conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
            quite_loop := true;
            Format.printf "Si f prefere actuel on marie pas. On pase a lhomme suivant : \nk = %d f = %d\n" !k !f;
          end
        done;
      if !quite_loop = false then begin
        p.(!k) <- (!k,conf.rang_appel_de.(!k)); 
        k := !k + 1;
      end
    done;
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide"

(* let algo ?(affiche_config=false) entree =
  if (entree_valide entree) then begin 
    ignore affiche_config;
    let k = ref 0 in
    let conf = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    while !k < entree.n do
      let h = ref !k in
      let f = ref (entree.liste_appel_de.(!h).(conf.rang_appel_de.(!h))) in
      while conf.rang_appel_de.(!h) < entree.n do
        if conf.fiance_de.(!f) = None then begin
          conf.fiance_de.(!f) <- Some !k 
        end
        else if entree.prefere.(!f) !k (Option.get conf.fiance_de.(!f))
        then conf.fiance_de.(!f) <- Some !k
      done;
      k := !k + 1;
    done;
  end
  else invalid_arg "L'entree n'est pas valide" *)


(* let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté" *)