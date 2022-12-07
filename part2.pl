saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox) :- nl,
    write('Entrez le numéro du type de proposition que vous voulez démontrer :'), nl,
    write('1 Une instance donnée appartient a un concept donné.'), nl,
    write('2 Deux concepts qui n\'ont pas d\'éléments en commun (ils ont une intersection vide).'), nl,
    read(R),
    suite(R,Abi,Abi1,Tbox).

suite(1,Abi,Abi1,Tbox) :- acquisition_prop_type1(Abi,Abi1,Tbox), !.
suite(2,Abi,Abi1,Tbox) :- acquisition_prop_type2(Abi,Abi1,Tbox), !.
suite(R,Abi,Abi1,Tbox) :- nl, 
    write('Cette reponse est incorrecte.'), nl,
    saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).

input_prop_type1(I,CG) :-
    write('Ajoutons une instance de concept à la ABox :'), nl,
    write('Elle a la forme "I : C"'), nl,
    write('Entrez I :'),nl, 
    read(I),nl,
    write('Entrez C :'),nl, 
    read(CG),
    (instanciationC(I, CG) -> % if 
        write("Input correct")
        ; ( % else
        write('Erreur : I n\'est pas une instance déclarée ou C n\'est pas un concept'), nl,
        write('Veuillez recommencer'), nl
        % input_prop_type1(I, CG) % boucler ne semble pas fonctionner 
    )), nl.

acquisition_prop_type1(Abi,Abi1,Tbox) :- 
    input_prop_type1(I, CG), % User input
    transforme([(I,CG)], [(I, CG_dev_nnf)]), % Développement + nnf (comment developper avec les définitions de la Tbox sans envoyer la Tbox en param??)
    concat(Abi,[(I, CG_dev_nnf)], Abi1),
    write("Abi1"), write(Abi1)
    . % ajout de l'input de l'utilisateur dans la ABox


input_prop_type2(C1, C2) :-
    write('Ajoutons une proposition de la forme C1 ⊓ C2 ⊑ ⊥.'), nl,
    write('Entrez C1 :'),nl, 
    read(C1),nl,
    write('Entrez C2 :'),nl, 
    read(C2),
    (concept(and(C1, C2)) -> % if 
        write("Input correct")
        ; ( % else
        write('Erreur : C1 ou C2 n\'est pas un concept déclarée'), nl,
        write('Veuillez recommencer'), nl
        % input_prop_type2(C1, C2) % boucler ne semble pas fonctionner
    )), nl.

acquisition_prop_type2(Abi,Abi1,Tbox) :- 
    input_prop_type2(C1, C2), % User input
    % Développement + nnf (comment développer avec les définitions de la Tbox sans envoyer la Tbox en param??)
    genere(Random_CName),
    transforme([(Random_CName, and(C1, C2))], [(Random_CName, and(C1_dev_nnf, C2_dev_nnf))]),
    concat(Abi, [(Random_CName, and(C1_dev_nnf, C2_dev_nnf))], Abi1),
    write("Abi1"), write(Abi1)
    . % ajout de l'input de l'utilisateur dans la ABox
