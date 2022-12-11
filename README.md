# Projet de LRC en Prolog
Projet de l'UE Logique et représentation des connaissances du S1 du Master DAC. 

# To Do
- ~~Faire des tests unitaires ? On pourrait être sur de pas broken une features en en ajoutant une autre~~
- Utiliser `spy/1` https://www.cs.bham.ac.uk/~pjh/prolog_course/using_sicstus/debugging_sicstus.html

Si je comprend bien le sujet, on doit : 
## Partie 1
- [X] Implémenter une correction sémantique : par exemple vérifier qu'un rôle est bien un rôles et qu'il est employer comme un rôle partout. (Sujet p.11)
    - [X] Checker la présence de `cnamea(anything).` et `cnamea(nothing).`
    - [X] Transformer `Vérif_Concept` en `Concept/1` pour respecter la consigne (si c'est bien `verif_concept` qu'il faut rename....)
    - [X] Penser a faire passer l'input de l'user par ces fonctions
- [X] `autoref` qui doit vérifier la T-box acyclique
    - [X] Est-ce qu'on doit pas raise une erreur si il y a autoref ?
- [X] `traitement_Tbox` : Remplacer chaque expression de la TBox par : celle de comportant que des concept atomique (en remplaçant les definitions) et mise sous forme normale négative (Part I remarque 3)
- [X] `traitement_Abox` : Same (Part I remarque 4)
- [ ] Changer les paramètres pour qu'on recoivent la ABox, Tbox en param comme demandé en consigne
- [X] Rename `transforme` en `traitement ABox` et `Traitement_TBox`
- [X] Est-ce que `transforme` a été testé car je crois de dans les Box fournis y'a rien a développer de base

## Partie 2
- [ ] Vérifier que `transforme` fait son taf avec une liste de taille 1

## Partie 3
- [ ] 

## Rapport : 
- [ ] **Bien relire le code listé pour être sur de pas avoir laisser des prints ou commentaire**