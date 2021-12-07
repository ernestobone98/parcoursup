open Definitions
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
          p.(!h) <- (!h,!f);
          print_configuration conf;
          h:= (-1) ;
        end 
      else if entree.prefere.(!f) !h (Option.get conf.fiance_de.(!f))
      then begin 
        let h_tmp = Option.get conf.fiance_de.(!f) in
        conf.fiance_de.(!f) <- Some !h;
        p.(!h) <- (!h,!f);
        h := h_tmp;
        conf.rang_appel_de.(!h) <- conf.rang_appel_de.(!h) + 1; 
        print_configuration conf;
      end 
      else begin
        conf.rang_appel_de.(!h) <- conf.rang_appel_de.(!h) + 1;
        print_configuration conf;
      end
    done;
    k := !k + 1;
  done; 
  Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide"


  (* cat _build/default/test/mariages_stables/knuth/test_knuth.output *)