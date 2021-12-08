type formation = {
  nom_formation : string ;
  capacite : int 
}

type voeu = {
  rang_repondeur : int option ;
  nom_candidat : string ;
  nom_formation : string
}

type commission = {
  nom_formation : string;
  fonction_comparaison : string -> string -> bool
}

type candidat = {
  nom_candidat : string ;
  voeu_en_attente : string list;
  proposition : string list 
}

type session = {
  mutable candidat : candidat list;
  mutable formation : formation list;
  mutable voeu : voeu list;
  mutable commission : commission list
} 

let nouvelle_session () = {
  candidat = [] ;
  formation = [] ;
  voeu = [];
  commission = [] 
}

let ajoute_candidat session ~nom_candidat = 
  if session.candidat = [] then 
    session.candidat <- [{nom_candidat = nom_candidat ; voeu_en_attente = [] ; proposition = []}] 
  else 
  session.candidat <- session.candidat @ [{nom_candidat = nom_candidat ; voeu_en_attente = [] ; proposition = []}]

let ajoute_formation session ~nom_formation ~capacite =
  if session.formation = [] then 
    session.formation <- [{nom_formation = nom_formation ; capacite = capacite}]
  else
    session.formation <- session.formation @ [{nom_formation = nom_formation ; capacite = capacite}] 


let ajoute_voeu session ~rang_repondeur ~nom_candidat ~nom_formation = 
  let rec aux (v: voeu list) = match v with 
  | [] -> session.voeu <- [{rang_repondeur=rang_repondeur ;nom_candidat=nom_candidat ; nom_formation = nom_formation }]
  | [x] -> 
    if x.nom_candidat = nom_candidat && x.nom_formation = nom_formation && rang_repondeur < x.rang_repondeur then 
      session.voeu <- [{rang_repondeur=rang_repondeur ;nom_candidat=nom_candidat ; nom_formation = nom_formation }]
  | hd::tl -> 
      session.voeu <- [hd] @ tl ; aux tl 
    in aux session.voeu 

let ajoute_commission session ~nom_formation ~fonction_comparaison = 
  ignore session;
  ignore nom_formation;
  ignore fonction_comparaison;
  failwith "non implémenté"

let reunit_commissions session =
  ignore session;
  failwith "non implémenté"

let nouveau_jour session =
  ignore session;
  failwith "non implémenté"

let renonce session ~nom_candidat ~nom_formation = 
  ignore session;
  ignore nom_candidat;
  ignore nom_formation;
  failwith "non implémenté"

let consulte_propositions session ~nom_candidat =
  ignore session;
  ignore nom_candidat;
  failwith "non implémenté"

let consulte_voeux_en_attente session ~nom_candidat = 
  ignore session;
  ignore nom_candidat;
  failwith "non implémenté" 
