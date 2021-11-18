open Definitions

(* let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
  ignore affiche_config;
  let k = ref 0 in 
  let n = entree.n in 
  let omega : (homme) = -1 in
  let conf = {rang_appel_de = Array.make n 0 ; fiance_de = Array.make n (Some homme)} in 
  let p : (homme*femme) array = Array.make n (0,0) in
  while !k < n do
    while !k <> (Option.get omega) do 
      let f = entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k)) in 
      if entree.prefere.(f) !k (Option.get conf.fiance_de.(f)) then begin
        conf.fiance_de.(f) <- (Some !k) ;
        k := (Option.get conf.fiance_de.(f));
      end;
      if !k <> (Option.get omega) then conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
      p.(!k) <- (!k,conf.rang_appel_de.(!k));
    done;
    k:= !k+1;
  done;
  Array.to_list p;
  end
else invalid_arg "L'entree n'est pas valide" *)



(* let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
  ignore affiche_config;
  let k = ref 0 in 
  let n = entree.n in 
  let omega : (homme option) = None in
  let conf = {rang_appel_de = Array.make n 0 ; fiance_de = Array.make n omega} in 
  let p : (homme*femme) array = Array.make n (0,0) in
  while !k < n do
    while !k <> (Option.get omega) do 
      let f = entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k)) in 
      if entree.prefere.(f) !k (Option.get conf.fiance_de.(f)) then begin
        conf.fiance_de.(f) <- (Some !k) ;
        k := (Option.get conf.fiance_de.(f));
      end;
      if !k <> (Option.get omega) then conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
      p.(!k) <- (!k,conf.rang_appel_de.(!k));
    done;
    k:= !k+1;
  done;
  Array.to_list p;
  end
else invalid_arg "L'entree n'est pas valide" *)







(* let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let n = entree.n in 
    let k = ref 0 in 
    let omega = None in 
    let conf = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n omega} in 
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    while !k < n do
      while !k <> (-1) do 
        let f = entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k)) in 
        if entree.prefere.(f) !k (conf.rang_appel_de.(f)) then begin
          let h_tmp = (Option.get conf.fiance_de.(f)) in 
          conf.fiance_de.(f) <- Some !k;
          k := h_tmp;
        end;
        if !k <> (aux omega) then 
          conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
      done; 
      k := !k +1;
       p.(!k) <- (!k,conf.rang_appel_de.(!k));
      (* Array.to_list p; *)
    
    done ;
    Array.to_list p;

  end
  else invalid_arg "L'entree n'est pas valide"  *)
(* let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let n = entree.n in 
    let k = ref 0 in 
    let omega = None in 
    let conf = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n omega } in 
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    while !k < n do
      while !k <> (aux omega) do 
        let f = entree.liste_appel_de.(!k).(conf.rang_appel_de.(!k)) in 
        if entree.prefere.(f) !k (conf.rang_appel_de.(f)) then begin
          let h_tmp = conf.fiance_de.(f) in 
          conf.fiance_de.(f) <- !k;
          k := h_tmp;
        end
        if !k <> (Some omega) then 
          conf.rang_appel_de.(!k) <- conf.rang_appel_de.(!k) + 1;
      done 
      k := !k +1;
      p.(!k) <- (!k,conf.rang_appel_de.(!k));
      Array.to_list p;
    
    done 

  end
else invalid_arg "L'entree n'est pas valide" *)








(* let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let k = ref 0 in
    let h: homme ref = ref 0 in
    let f: femme ref = ref 0 in
    let omega = ref (-1) in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n (Some !omega) } in 
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    f := entree.liste_appel_de.(!h).(conf.rang_appel_de.(!h));
    while !k < entree.n do
      while !h <> !omega do 
        f := entree.liste_appel_de.(!h).(conf.rang_appel_de.(!h));
        if (Option.get conf.fiance_de.(!f)) = !omega then begin
         h_de_base := !h;
         conf.fiance_de.(!f) <- (Some !h) ;
         h:= Option.get conf.fiance_de.(!f);
        end
        else
        if entree.prefere.(!f) !h (Option.get conf.fiance_de.(!f)) then begin
           let h_tmp = Option.get conf.fiance_de.(!f) in
           let h_de_base = !h in 
           (* conf.rang_appel_de.(!h) <- !f; *)
           conf.fiance_de.(!f) <- (Some !h);
           h := h_tmp;
           conf.rang_appel_de.(h_de_base) <- conf.rang_appel_de.(h_de_base)+1;
          end
      done;
    done;
    (*p.(!k) <- (!h,conf.rang_appel_de.(!h));*)
    k := !k + 1 ;
    h := !h_de_base + 1;
    Array.to_list p;
   
  end
else invalid_arg "L'entree n'est pas valide" *)

(*let choix x = function
  | (-1) -> None
  | _ -> Some x*)

  let aux x = match x with 
  | None -> -1
  | Some x -> x


let algo ?(affiche_config=true) entree =
  if (entree_valide entree) then begin
    ignore affiche_config;
    let k = ref 0 in
    let h: homme ref = ref 0 in
    let f: femme ref = ref 0 in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    while !k < entree.n do
      h:=!k;
      while !h <> -1 do
        f := entree.liste_appel_de.(!h).(conf.rang_appel_de.(!h));
        if conf.fiance_de.(!f) = None then 
          begin conf.fiance_de.(!f) <- Some !h;
            h:= (-1) ;
            print_configuration conf;
          end else if entree.prefere.(!f) !h (Option.get conf.fiance_de.(!f))
          then begin 
            let h_tmp = Option.get conf.fiance_de.(!f) in
            conf.fiance_de.(!f) <- Some !h;
            h := h_tmp;
            conf.rang_appel_de.(!h) <- conf.rang_appel_de.(!h) + 1; (* on peut le mettre au debut car le rang n'affecte pas l'homme*)
            print_configuration conf;  
          end else
            conf.rang_appel_de.(!h) <- conf.rang_appel_de.(!h) + 1;
          print_configuration conf;  
        
          
      done;
      for i=0 to entree.n-1 do
        p.(i) <- ((aux conf.fiance_de.(i)),i)
      done;
      k := !k + 1;
    done;
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide";


(* let algo ?(affiche_config=false) entree =
  ignore affiche_config;
  ignore entree;
  failwith "non implémenté" *)


  (* cat _build/default/test/mariages_stables/knuth/test_knuth.output *)