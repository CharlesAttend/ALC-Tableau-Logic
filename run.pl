premiere_etape(Tbox, Abi, Abr) :-
    load_files('part1.pl'),
    load_files('helper.pl'),
    load_files('T-A_Box.pl'),
    % Test 
    % load_files('./Test/T-A_Box_erreur_syntaxe1.pl'),
    % load_files('./Test/T-A_Box_erreur_syntaxe2.pl'),
    % load_files('./Test/T-A_Box_erreur_syntaxe3.pl'),
    % load_files('./Test/T-A_Box_erreur_cyclique.pl'),


    setof((CA, CG), equiv(CA, CG), Tboxt),       % Récupération de la TBoxt
    setof((I1, I2), inst(I1, I2), Abit),         % Récupération de Abit
    setof((I1, I2, R), instR(I1, I2, R), Abr),   % Récupération de Abrt

    % Vérification de la Tbox
    write('[LOG] Vérification de la TBox ...'), nl,
    (verif_Tbox(Tboxt) ->
        write('[LOG] Vérification de la TBox réussi'), nl;
        write('[ERREUR] Il y a erreur de syntaxe dans la TBox'), nl, halt),
    
    % Vérification de la Abox
    write('[LOG] Vérification de la ABox ...'), nl,
    (verif_Abox([Abit | Abr]) ->
        write('[LOG] Vérification de la ABox réussi'), nl;
        write('[ERREUR] Il y a erreur de syntaxe dans la ABox'), nl, halt),

    % Vérification des auto-référencements
    setof(X, cnamena(X), Lcc),    % Récupération de la liste des concepts non atomiques
    setof(Y, cnamea(Y), Lca),     % Récupération de la liste des concepts atomiques
    (verif_Autoref(Lcc) ->
        write('[LOG] Il n\'y a pas auto-référencement dans la TBox'), nl ;
        write('[ERREUR] Il y a auto-référencement dans la TBox'), nl, halt),

    write('[LOG] Transformation des boxs en développant les concepts complexes puis mise sous forme normale négative...'), nl,
    transforme(Abit, Abi),
    % write('abi:'), write(Abi), nl,
    % write('abit:'), write(Abit),nl,
    transforme(Tboxt, Tbox),
    % write('Tbox:'), write(Tbox), nl,
    % write('Tboxt:'), write(Tboxt),nl,
    write('[LOG] Transformation terminée'),nl.
    
deuxieme_etape(Abi,Abi1,Tbox) :-
    load_files('part2.pl'),
    saisie_et_traitement_prop_a_demontrer(Abi,Abi1,Tbox).

troisieme_etape(Abi,Abr) :-
    load_files('part3.pl'),
    tri_Abox(Abi,Lie,Lpt,Li,Lu,Ls),
    resolution(Lie,Lpt,Li,Lu,Ls,Abr).

programme :-
    % load_files('part3.pl'),
    % load_test_files([]),
    % run_tests,
    
    premiere_etape(Tbox, Abi, Abr),             % Call de la première partie
    deuxieme_etape(Abi,Abi1,Tbox),
    troisieme_etape(Abi1,Abr),
    write('[LOG] Programme terminé !').
programme.
