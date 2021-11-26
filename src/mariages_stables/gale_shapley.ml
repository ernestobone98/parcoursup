open Definitions

let cons_uniq xs x = if List.mem x xs then xs else x :: xs

let remove_from_left xs = List.rev (List.fold_left cons_uniq [] xs)   (*Permet d'eliminer les repetitions*)

let remove n l = List.filter (function x -> x <> n) l     (*Enleve l'elem n de la liste l*)

let list_to_array lst = 
  let a = Array.make (List.length lst) 0 in
  for i = 0 to ((List.length lst)-1) do
    a.(i) <- List.nth lst i;
  done;
  a;;

let find x arr = 
  let lst = ref [] in
  for i = 0 to ((Array.length arr)-1) do
  if x = arr.(i) then lst := !lst@[i];
  done;
  !lst;;


let algo ?(affiche_config=true) entree =
  if entree_valide entree then begin

    ignore affiche_config;
    let n = ref entree.n in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let single_men = ref [] in
    let pretendants = ref [] in (*c'est une liste de femmes. Les indices on peut dire qu'ils réprésent les hommes e.g. index/homme 0 1 2 *)
    (*                                                                                                            femme qu'il veut 2 1 1*)
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    single_men := List.init entree.n (fun x -> x);

    while !n > 0 do

      single_men := List.filter (fun x -> conf.fiance_de.(x) = None) !single_men; (*Liste d'hommes celibs*)
      for i = 0 to ((List.length !single_men)-1) do (*Reenvoie une liste avec le rang_appel_de pour chaque homme i*)
        pretendants := !pretendants @ [entree.liste_appel_de.(List.nth !single_men i).(conf.rang_appel_de.(List.nth !single_men i))];
      done;
      
      (*pour toute femme x ayant reçu au moins une nouvelle proposition*)
      for i = 0 to ((List.length !pretendants)-1) do (*On parcours la liste de toutes les femmes qui ont au moins 1 pretendant*)
        let pretendants_dune_femme = ref (find i (list_to_array !pretendants)) in (*Si les hommes 0,3 preferent la femme c alors la liste = [0;3]*)
        (*la boucle essaie de parcourir touts les pretendants d'une femme pour trouver son meilleur choix. à voir si marche (Je pense pas)*)
        for j = 0 to ((List.length !pretendants_dune_femme)-2) do (*Boucle pour obtenir le meilleur choix de la femme entre ceux qui proposent*)
          if conf.fiance_de.(List.nth !pretendants i) = None then begin
            conf.fiance_de.(List.nth !pretendants i) <- Some (List.nth !pretendants_dune_femme j);
            p.(i) <- (i,List.nth !pretendants i);
          end else if entree.prefere.(List.nth !pretendants i) (List.nth !pretendants_dune_femme j) (Option.get conf.fiance_de.(List.nth !pretendants i)) then begin
            conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) <- conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) + 1;
            conf.fiance_de.(List.nth !pretendants i) <- Some (List.nth !pretendants_dune_femme j);
            p.(i) <- (i,List.nth !pretendants i);
          end else conf.rang_appel_de.(List.nth !pretendants_dune_femme j) <- conf.rang_appel_de.(List.nth !pretendants_dune_femme j) + 1;
        done;

      done;

      List.iter (Printf.printf "%d ") !pretendants; (*Juste pour debugger*)
      pretendants := []; (*il faut vider la liste. Sinon on aura les aciens pretendants a chaque iteration*)
      single_men := [];
      n := !n - 1;      (*On a eu un marriage donc -1 couple encore n-1 couples à marrier*)

    done;
    Array.to_list p;
  end else invalid_arg "L'entree n'est pas valide"


(* let algo ?(affiche_config=true) entree =
  if entree_valide entree then begin
    ignore affiche_config;
    let n = ref entree.n in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let single_men = ref [] in
    let pretendants = ref [] in
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    single_men := List.init entree.n (fun x -> x);
    while !n > 0 do
      single_men := List.filter (fun x -> conf.fiance_de.(x) = None) !single_men; (*Liste d'hommes celibs*)
      for i = 0 to ((List.length !single_men)-1) do (*Devuelve una lista con el rang_appel_de cada hombre i*)
        pretendants := !pretendants @ [entree.liste_appel_de.(List.nth !single_men i).(conf.rang_appel_de.(List.nth !single_men i))];
      done;
      (*pour toute femme x ayant reçu au moins une nouvelle proposition*)
      for i = 0 to ((List.length !pretendants)-1) do
        let pretendants_dune_femme = ref [] in
        pretendants_dune_femme := List.filter (fun x -> if x = (List.nth !pretendants i) then true else false) !pretendants_dune_femme;
        
      done;
      pretendants := []; (*il faut vider la liste. Sinon on aura les aciens pretendants a chaque iteration*)
      single_men := [];
      n := !n - 1;
    done;
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide" *)


(* let algo ?(affiche_config=true) entree =
  if entree_valide entree then begin
    ignore affiche_config;
    let n = ref entree.n in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let single_men = ref [] in
    let pretendants = ref [] in
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    single_men := List.init entree.n (fun x -> x);
    while !n > 0 do
      single_men := List.filter (fun x -> conf.fiance_de.(x) = None) !single_men; (*Liste d'hommes celibs*)
      for i = 0 to ((List.length !single_men)-1) do (*Devuelve una lista con el rang_appel_de cada hombre i*)
        pretendants := !pretendants @ [entree.liste_appel_de.(List.nth !single_men i).(conf.rang_appel_de.(List.nth !single_men i))];
      done;
      (*pour toute femme x ayant reçu au moins une nouvelle proposition*)
      for i = 0 to ((List.length !pretendants)-1) do
        (* let pretendants_dune_femme = [] in *)
        if conf.fiance_de.(List.nth !pretendants i) = None then begin
          conf.fiance_de.(List.nth !pretendants i) <- Some i;
          p.(i) <- (i,List.nth !pretendants i);
        end
        else if entree.prefere.(List.nth !pretendants i) i (Option.get conf.fiance_de.(List.nth !pretendants i)) then
        begin
          conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) <- conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) + 1;
          conf.fiance_de.(List.nth !pretendants i) <- Some i;
          p.(i) <- (i,List.nth !pretendants i);
        end
      done;
      pretendants := []; (*il faut vider la liste. Sinon on aura les aciens pretendants a chaque iteration*)
      single_men := [];
      n := !n - 1;
    done;
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide" *)


(* let algo2 ?(affiche_config=true) entree =
  if entree_valide entree then begin
    ignore affiche_config;
    let n = ref entree.n in
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let single_men = ref [] in
    let pretendants = ref [] in
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    single_men := List.init entree.n (fun x -> x);
    while !n > 0 do
      single_men := List.filter (fun x -> conf.fiance_de.(x) = None) !single_men; (*Liste d'hommes celibs*)
      for i = 0 to ((List.length !single_men)-1) do (*Devuelve una lista con el rang_appel_de cada hombre i*)
        pretendants := !pretendants @ [entree.liste_appel_de.(List.nth !single_men i).(conf.rang_appel_de.(List.nth !single_men i))];
      done;
      (*pour toute femme x ayant reçu au moins une nouvelle proposition*)
      for i = 0 to ((List.length !pretendants)-1) do 
        let pretendants_dune_femme = ref (find i (Array.to_list a)) in
        if (List.length !pretendants_dune_femme) >= 2 then begin
          for j = 0 to ((List.length !pretendants_dune_femme)-2) do 
            (*No es j y j+1. Creo que hay que hacer un while en lugar del for*)
            if conf.fiance_de.(List.nth !pretendants i) = None then begin
              if entree.prefere.(List.nth !pretendants i) (List.nth !pretendants_dune_femme j) (List.nth !pretendants_dune_femme (j+1)) then begin
                conf.fiance_de.(List.nth !pretendants i) <- (List.nth !pretendants_dune_femme j);
              end else conf.fiance_de.(List.nth !pretendants i) <- (List.nth !pretendants_dune_femme (j+1));
            end if entree.prefere.(List.nth !pretendants i) (List.nth !pretendants_dune_femme j) (Option.get conf.fiance_de.(List.nth !pretendants i)) then begin
                (*Si prefiere el nuevo que propone*)
                conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) <- conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) + 1;
              end else (*Si prefiere su actual pareja*)
          done;
        end else if (List.length pretendants_dune_femme) = 1 then begin
          conf.fiance_de.(List.nth !pretendants i) <- (Some (List.nth !pretendants_dune_femme j));
        end
      done;
      List.iter (Printf.printf "%d ") !pretendants;
      pretendants := []; (*il faut vider la liste. Sinon on aura les aciens pretendants a chaque iteration*)
      single_men := [];
      n := !n - 1;
    done;
    Array.to_list p;
  end
  else invalid_arg "L'entree n'est pas valide" *)