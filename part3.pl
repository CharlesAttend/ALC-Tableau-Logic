%tri box
tri_Abox([],[],[],[],[],[]).
tri_Abox([(I,some(R,C))|L],[(I,some(R,C))|Lie],Lpt,Li,Lu,Ls) :-
	tri_Abox(L,Lie,Lpt,Li,Lu,Ls),!.
tri_Abox([(I,all(R,C))|L],Lie,[(I,all(R,C))|Lpt],Li,Lu,Ls) :-
	tri_Abox(L,Lie,Lpt,Li,Lu,Ls),!.
tri_Abox([(I,and(C1,C2))|L],Lie,Lpt,[(I,and(C1,C2))|Li],Lu,Ls) :-
	tri_Abox(L,Lie,Lpt,Li,Lu,Ls),!.
tri_Abox([(I,or(C1,C2))|L],Lie,Lpt,Li,[(I,or(C1,C2))|Lu],Ls) :-
	tri_Abox(L,Lie,Lpt,Li,Lu,Ls),!.
tri_Abox([A|L],Lie,Lpt,Li,Lu,[A|Ls]) :-
	tri_Abox(L,Lie,Lpt,Li,Lu,Ls),!.
	
%evolue
evolue((I,some(R,C)),Lie,Lpt,Li,Lu,Ls,Lie,Lpt,Li,Lu,Ls):-
	member((I,some(R,C)),Lie).
evolue((I,some(R,C)),Lie,Lpt,Li,Lu,Ls,[(I,some(R,C))|Lie],Lpt,Li,Lu,Ls).

evolue((I,all(R,C)),Lie,Lpt,Li,Lu,Ls,Lie,Lpt,Li,Lu,Ls):-
	member((I,all(R,C)),Lpt).
evolue((I,all(R,C)),Lie,Lpt,Li,Lu,Ls,Lie,[(I,all(R,C))|Lpt],Li,Lu,Ls).

evolue((I,and(C1,C2)),Lie,Lpt,Li,Lu,Ls,Lie,Lpt,Li,Lu,Ls):-
	member((I,and(C1,C2)),Li).
evolue((I,and(C1,C2)),Lie,Lpt,Li,Lu,Ls,Lie,Lpt,[(I,and(C1,C2))|Li],Lu,Ls).

evolue((I,or(C1,C2)),Lie,Lpt,Li,Lu,Ls,Lie,Lpt,Li,Lu,Ls):-
	member((I,or(C1,C2)),Lu).
evolue((I,or(C1,C2)),Lie,Lpt,Li,Lu,Ls,Lie,Lpt,Li,[(I,or(C1,C2))|Lu],Ls).

evolue(A,Lie,Lpt,Li,Lu,Ls,Lie,Lpt,Li,Lu,Ls):-
	member(A,Ls).
evolue(A,Lie,Lpt,Li,Lu,Ls,Lie,Lpt,Li,Lu,[A|Ls]).

%test de clash
non_clash([]).
non_clash([(I,C)|Ls]) :- 
	nnf(not(C),NC),
	\+ member((I,NC),Ls),
	non_clash(Ls).
	
%affichage
affiche_Ls([]).
affiche_concept(some(R,C)) :-
	write('\u2203'),
	write(R),
	write('.'),
	affiche_concept(C).
affiche_concept(all(R,C)) :-
	write('\u2200'),
	write(R),
	write('.'),
	affiche_concept(C).
affiche_concept(and(C1,C2)) :-
	affiche_concept(C1),
	write('\u2A05'),
	affiche_concept(C2).
affiche_concept(or(C1,C2)) :-
	affiche_concept(C1),
	write('\u2A06'),
	affiche_concept(C2).
affiche_concept(not(C)) :-
	write('\u00AC'),
	affiche_concept(C).
affiche_concept(anything) :-
	write('\u22A4').
affiche_concept(nothing) :-
	write('\u22A5').
affiche_concept(C) :-
	write(C).
	
affiche_Abi([]).
affiche_Abi([(I,C)|L]):-
	write(I),write(':'),affiche_concept(C),nl,
	affiche_Abi(L).

affiche_Abr([]).
affiche_Abr([(I1,I2,R)|L]) :-
	write('<'),write(I1),write(','),write(I2),write('>:'),
	write(R),nl,
	affiche_Abr(L).

affiche_evolution_Abox(Ls1,Lie1,Lpt1,Li1,Lu1,Abr1,Ls2,Lie2,Lpt2,Li2,Lu2,Abr2):-
	write("Etat de départ :"),nl,
	affiche_Abi(Ls1),
	affiche_Abi(Lie1),
	affiche_Abi(Lpt1),
	affiche_Abi(Lu1),
	affiche_Abr(Abr1),
	nl,
	write("Etat d'arrivée :"),nl,
	affiche_Abi(Ls2),
	affiche_Abi(Lie2),
	affiche_Abi(Lpt2),
	affiche_Abi(Lu2),
	affiche_Abr(Abr2).
