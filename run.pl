premiere_etape(Tbox, Abi, Abr) :-
    load_files('part1.pl'),

    % Vérification de la Tbox
    write('Vérification de la TBox ...'), nl,
    verif_Tbox(Tbox),
    write('Vérification de la TBox réussi'), nl,
    
    % Vérification de la Abox
    write('Vérification de la ABox ...'), nl,
    verif_Abox([Abi | Abr]),
    write('Vérification de la ABox réussi'), nl.

deuxieme_etape(Abi,Abi1,Tbox) :-
    saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).
    saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox) :- nl,
        write('Entrez le numero du type de proposition que vous voulez demontrer :'), nl,
        write('1 Une instance donnee appartient a un concept donne.'), nl,
        write('2 Deux concepts n"ont pas d"elements en commun(ils ont une intersection vide).'), nl,
        read(R),
        suite(R,Abi,Abi1,Tbox).
    suite(1,Abi,Abi1,Tbox) :- acquisition_prop_type1(Abi,Abi1,Tbox), !.
    suite(2,Abi,Abi1,Tbox) :- acquisition_prop_type2(Abi,Abi1,Tbox), !.
    suite(R,Abi,Abi1,Tbox) :- nl, write('Cette reponse est incorrecte.'), nl,
    saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).

programe :-
    % load_files('part2.pl'),
    % load_files('part3.pl'),
    % load_test_files([]),
    % run_tests,
    
    % Import des Box
    load_files('T-A_Box.pl'),
    setof((CA, CG), equiv(CA, CG), Tbox),       % Récupération de la TBox
    setof((I1, I2), inst(I1, I2), Abi),         % Récupération de Abi
    setof((I1, I2, R), instR(I1, I2, R), Abr),   % Récupération de Abr
    premiere_etape(Tbox, Abi, Abr),             % Call de la première partie
    
    
    % deuxieme_etape(Abi,Abi1,Tbox),
    % troisieme_etape(Abi1,Abr),
    
    write('Programe terminé !').
programe.