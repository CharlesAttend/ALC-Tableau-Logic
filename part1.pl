% Pour le linter qui casse les pieds
:- dynamic cnamen/1.
:- dynamic cnamena/1.
:- dynamic iname/1.
:- dynamic rname/1.
:- discontiguous verif_Concept/1.

% Vérification sémantique : 
% Prédicat "Alphabet"
verif_Concept(C) :- cnamea(C), !. % Vérification des concepts atomique
verif_Concept(CG) :- cnamena(CG), !. % Vérification des concepts non atomique
verif_Instance(I) :- iname(I), !. % Vérification des identificateurs d'instance
verif_Role(R) :- rname(R), !. % Vérification des identificateurs de rôle.

% On vérifie la grammaire de la logique ALC (sujet I.3)
verif_Concept(not(C)) :- verif_Concept(C), !.
verif_Concept(and(C1, C2)) :- verif_Concept(C1), verif_Concept(C2), !.
verif_Concept(or(C1, C2)) :- verif_Concept(C1), verif_Concept(C2), !.
verif_Concept(some(R, C)) :- verif_Role(R), verif_Concept(C), !.
verif_Concept(all(R, C)) :- verif_Role(R), verif_Concept(C), !.

% Vérification syntaxique
% Pour la Tbox
verif_Equiv(CA, CG) :- verif_Concept(CA), verif_Concept(CG), !.
verif_Tbox([(CA, CG) | Q]) :- 
    verif_Concept(anything), 
    verif_Concept(nothing), 
    verif_Equiv(CA, CG), 
    verif_Tbox(Q).
verif_Tbox([]).

% Pour la Abox
verif_Inst(I, CG) :- verif_Instance(I), verif_Concept(CG), !.
verif_InstR(I1, I2, R) :- verif_Instance(I1), verif_Instance(I2), verif_Role(R), !.

verif_AboxC([]).
verif_AboxC([(I, CG) | Q]) :- verif_Inst(I, CG), verif_AboxC(Q), !.

verif_AboxR([]).
verif_AboxR([(I1, I2, R) | Q]) :- verif_InstR(I1, I2, R), verif_AboxR(Q), !.

verif_Abox([AboxC | AboxR]) :- verif_AboxC(AboxC), verif_AboxR(AboxR), !.

% Auto-référencement
% verif_Autoref(Lcc,Lca) vrai ssi les concept non atomique de Lcc ne sont pas auto-référencé
verif_Autoref([], Lca).
verif_Autoref([C|L], Lca) :-
	equiv(C, Def_C),
	pautoref(C, Def_C, Lca),
	verif_Autoref(L, Lca).

% pautoref(C, Def_C, Lca) vrai ssi le concept non atomique C n'est pas dans la def récursive Def_C
pautoref(C, Def_C, Lca) :-
	member(Def_C, Lca).
	
pautoref(C, and(D1,D2), Lca) :-
	pautoref(C, D1, Lca),
	pautoref(C, D2, Lca).
	
pautoref(C, or(D1,D2), Lca) :-
	pautoref(C, D1, Lca),
	pautoref(C, D2, Lca).

pautoref(C, all(R,D), Lca) :-
	pautoref(C,D,Lca).
	
pautoref(C, some(R,D), Lca) :-
	pautoref(C,D,Lca).
	
pautoref(C, not(D), Lca) :-
	pautoref(C,D,Lca).
	
% developpe(C,D) vrai ssi D est le développement atomique de C
developpe(C, C) :- cnamea(C).

developpe(C, D) :- 
	equiv(C, E),
	developpe(E, D), 
	!.

developpe(not(C), not(D)) :- developpe(C, D), !.

developpe(or(C1,C2), or(D1,D2)) :- 
	developpe(C1, D1), 
	developpe(C2, D2),
	!.

developpe(and(C1,C2),and(D1,D2)) :- 
	developpe(C1,D1),
	developpe(C2,D2),
	!.

developpe(some(R,C), some(R,D)) :- developpe(C, D), !.

developpe(all(R,C), all(R,D)) :- developpe(C, D), !.

% remplacement des box
transforme([], []).
transforme([(X,C) | L], [(X,D) | M]) :- 
	developpe(C, E),
	nnf(E, D),
	transforme(L, M).
