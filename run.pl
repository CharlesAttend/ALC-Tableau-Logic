premiere_etape(Tbox, Abi, Abr) :-
    load_files('part1.pl'),
    load_files('helper.pl'),
    load_files('T-A_Box.pl'),

    setof((CA, CG), equiv(CA, CG), Tboxt),       % Récupération de la TBoxt
    setof((I1, I2), inst(I1, I2), Abit),         % Récupération de Abit
    setof((I1, I2, R), instR(I1, I2, R), Abr),   % Récupération de Abrt

    % Vérification de la Tbox
    write('Vérification de la TBox ...'), nl,
    verif_Tbox(Tboxt),
    write('Vérification de la TBox réussi'), nl,
    
    % Vérification de la Abox
    write('Vérification de la ABox ...'), nl,
    verif_Abox([Abit | Abr]),
    write('Vérification de la ABox réussi'), nl,

    % Vérification des auto-référencements
    setof(X, cnamena(X), Lcc),    % Récupération de la liste des concepts atomiques
    setof(Y, cnamea(Y), Lca),     % Récupération de la liste des concepts non atomiques
    (verif_Autoref(Lcc, Lca) ->
        write('Il ny a pas auto-référencement dans la TBox');
        write('Il y a auto-référencement dans la TBox')),nl,
    % Est-ce qu'on doit pas raise une erreur si il y a autoref ?

    write('Transformation des boxs en développant les concepts complexes puis mise sous forme normale négative...'), nl,
    transforme(Abit,Abi), 
    transforme(Tboxt,Tbox),
    write('Transformation terminée').
    
deuxieme_etape(Abi,Abi1,Tbox) :-
    load_files('part2.pl'),
    saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).


programme :-
    % load_files('part3.pl'),
    % load_test_files([]),
    % run_tests,
    
    premiere_etape(Tbox, Abi, Abr),             % Call de la première partie
    % deuxieme_etape(Abi,Abi1,Tbox),
    % troisieme_etape(Abi1,Abr),
    
    write('Programme terminé !').
programme.
