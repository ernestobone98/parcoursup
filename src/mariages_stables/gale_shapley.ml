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
    let conf : configuration = {rang_appel_de = Array.make entree.n 0 ; fiance_de = Array.make entree.n None } in 
    let single_men = ref [] in
    let pretendants = ref [] in (*c'est une liste de femmes. Les indices on peut dire qu'ils réprésent les hommes e.g. index/homme 0 1 2 *)
    (*                                                                                                            femme qu'il veut 2 1 1*)
    let p : (homme*femme) array = Array.make entree.n (0,0) in
    let pretendants_dune_femme = ref [] in
    single_men := List.init entree.n (fun x -> x); 

    while !single_men <> [] do
      
      for i = 0 to ((entree.n)-1) do
        if conf.fiance_de.(i) <> None then single_men := remove (Option.get conf.fiance_de.(i)) !single_men;
      done; 
                                                                                      
      for i = 0 to ((List.length !single_men)-1) do (*Reenvoie une liste avec le rang_appel_de pour chaque homme i*)
        pretendants := !pretendants @ [entree.liste_appel_de.(List.nth !single_men i).(conf.rang_appel_de.(List.nth !single_men i))];
      done; 
      
      (*pour toute femme x ayant reçu au moins une nouvelle proposition*)
      for i = 0 to ((List.length (remove_from_left !pretendants))-1) do (*On parcours la liste de toutes les femmes qui ont au moins 1 pretendant*)
        pretendants_dune_femme :=  (find (List.nth !pretendants i) (list_to_array !pretendants)); (*Si les hommes 0,3 preferent la femme c alors la liste = [0;3]*) 
                                                                                                  
        while (List.length !pretendants_dune_femme <> 0) do
          let current_men = List.hd !pretendants_dune_femme in
          pretendants_dune_femme := List.tl !pretendants_dune_femme;
          if conf.fiance_de.(List.nth !pretendants i) = None then begin
            conf.fiance_de.(List.nth !pretendants i) <- Some current_men;
          end else begin
            if entree.prefere.(List.nth !pretendants i) current_men (Option.get conf.fiance_de.(List.nth !pretendants i)) then begin
              conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) <- conf.rang_appel_de.(Option.get conf.fiance_de.(List.nth !pretendants i)) + 1;
              conf.fiance_de.(List.nth !pretendants i) <- Some current_men;
            end else conf.rang_appel_de.(current_men) <- conf.rang_appel_de.(current_men) + 1;
          end
        done; 

      done;
      
      if List.length !single_men > 0 then
        print_configuration conf;
      pretendants := []; (*il faut vider la liste. Sinon on aura les aciens pretendants a chaque iteration*) 

    done;
    
    for i = 0 to (entree.n-1) do
      p.(i) <- ((Option.get conf.fiance_de.(i)),i);
    done;
    
    Array.to_list p;
  end else invalid_arg "L'entree n'est pas valide"