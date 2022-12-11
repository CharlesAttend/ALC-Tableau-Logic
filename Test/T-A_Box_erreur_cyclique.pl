% Test T-Box avec cycle sur sculpture et sculpteur 
cnamena(sculpture).
rname(creePar).
equiv(sculpture, and(objet, all(creePar,sculpteur))).


% Concepts atomique, rôles & instances
cnamea(personne).
cnamea(livre).
cnamea(objet).
% cnamea(sculpture).
cnamea(anything).
cnamea(nothing).
cnamena(auteur).
cnamena(editeur).
cnamena(sculpteur).
cnamena(parent).
iname(michelAnge).
iname(david).
iname(sonnets).
iname(vinci).
iname(joconde).
rname(aCree).
rname(aEcrit).
rname(aEdite).
rname(aEnfant).

% T-Box
equiv(sculpteur,and(personne,some(aCree,sculpture))).
equiv(auteur,and(personne,some(aEcrit,livre))).
equiv(editeur,and(personne,and(not(some(aEcrit,livre)),some(aEdite,livre)))).
equiv(parent,and(personne,some(aEnfant,anything))).

% A-Box
inst(michelAnge,personne).
inst(david,sculpture).
inst(sonnets,livre).
inst(vinci,personne).
inst(joconde,objet).
instR(michelAnge,david,aCree).
instR(michelAnge,sonnets,aEcrit).
instR(vinci,joconde,aCree).
