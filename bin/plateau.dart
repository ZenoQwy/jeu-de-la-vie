import 'dart:io';
import 'A Functions.dart';
import 'case.dart';

class Plateau {
  List<List<Case>> _plateau = List.generate(10, (i) => List.generate(10, (j) => Case(false)));
  Plateau(); //Instancation du plateau

  afficherPlateau() { //afficher les éléments du plateau ● si la cellule est vivante ○ si morte
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        if (this._plateau[i][j].getetat() == true) {
          stdout.write("● ");
        } else {
          stdout.write("○ ");
        }
      }
      print("");
    }
  }
    
  // permet de définir par l'utilisateur, les cases vivantes du plateau
  initCoordonnees() { 
    print("Souhaitez-vous saisir des cellules vivantes ? y/n");
    String choix = Fonctions.SaisirString();
    //si l'utilisateur répondre autre chose que oui (y) ou non (n)
    if (choix != "n" && choix != "y") { 
      print("Saisie invalide");
      initCoordonnees();
    }
    // si l'utilisateur répond oui
    if (choix == "y") { 
      // demande de la coordonnée x ( ligne )
      int coorI = Fonctions.saisirIntervalle(1, this._plateau.length, Fonctions.SaisirInt("numéro de la ligne")); 
      // demande de la coordonnée x ( ligne )
      int coorJ = Fonctions.saisirIntervalle(1, this._plateau.length, Fonctions.SaisirInt("numéro de la colonne"));
      if (this._plateau[coorI - 1][coorJ - 1].getetat() == true) { 
        // si la case désirée est déjà vivante 
        print("La case est déjà vivante !");
        initCoordonnees();
      } else { 
        // si la case n'est pas déjà vivante
        this._plateau[coorI - 1][coorJ - 1].changeetat();
        initCoordonnees();
      }
    }
    // si l'utilisateur répond non 
    if (choix == "n") { 
      print("Voici le tableau :");
    }
  }

  //prend en parametree deux plateau et transfer le cotenu du premier dans le deuxième plateau
  List<List<Case>> transfer(List<List<Case>> plat1, List<List<Case>> plat2) {
    for (int i = 0; i < plat1.length; i++) {
      for (int j = 0; j < plat1[i].length; j++) {
        plat2[i][j] = plat1[i][j];
      }
    }
    return plat2;
  }

  //calcule le nombre de voisins d'une cellule donnée
  int nombreVoisin(int x, int y) {
    //création d'une plateau plus grand de 2 ( un une ligne en + à chaque bord ) afin de faciliter le calcul des voisins dans les bords
    List<List<Case>> plateauu = List.generate(this._plateau.length + 2, (i) => List.generate(this._plateau.length + 2, (j) => Case(false))); 
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        plateauu[i + 1][j + 1] = this._plateau[i][j];
      }
    }
    /*                               Plateau de la fonction          Visuel de à quoi ressemblerai un plateau initial plein    
      Plateau initial                ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    ○ ○ ○ ○ ○ ○ ○ ○ ○ ○              ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ● ● ● ● ● ● ● ● ● ● ○
    -                                ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○                  ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○ ○  
    */

    int nbvoisins = 0;
    //Le plateau de la fonction cause un décalage donc on augmente de 1 les indices
    x += 1;
    y += 1;
    print("Analyse de la case ${x};${y}");
    if (plateauu[x - 1][y + 1].getetat() == true) {
      //   ?
      // ↗
      nbvoisins++;
      print("Un voisin en ${x - 1};${y + 1}");
    }
    if (plateauu[x + 1][y + 1].getetat() == true) {
      // ↘
      //   ?
      nbvoisins++;
      print("Un voisin en ${x + 1};${y + 1}");
    }
    if (plateauu[x - 1][y - 1].getetat() == true) {
      // ?
      //   ↖
      nbvoisins++;
      print("Un voisin en ${x - 1};${y - 1}");
    }
    if (plateauu[x + 1][y - 1].getetat() == true) {
      //   ↙
      // ?
      nbvoisins++;
      print("Un voisin en ${x + 1};${y - 1}");
    }
    if (plateauu[x][y - 1].getetat() == true) {
      // ? ⬅
      nbvoisins++;
      print("Un voisin en ${x};${y - 1}");
    }
    if (plateauu[x][y + 1].getetat() == true) {
      // ➡ ?
      nbvoisins++;
      print("Un voisin en ${x};${y + 1}");
    }
    if (plateauu[x - 1][y].getetat() == true) {
      // ?
      // ⬆
      nbvoisins++;
      print("Un voisin en ${x - 1};${y}");
    }
    if (plateauu[x + 1][y].getetat() == true) {
      // ⬇
      // ?
      nbvoisins++;
      print("Un voisin en ${x + 1};${y}");
    }
    print("Voisins totaux : ${nbvoisins}\n------------------------------------------");
    return nbvoisins;
  }

  //fonction permettant de changer de donner un nouveau plateau en fonction des règles du jeu établies.
  List<List<Case>> generationSuivante() {
    //creation d'un plateau provisoir coorrespondant à la copie ( ou trasfert ) du plateau initial dans ce plateau provisoire de meme taille
    List<List<Case>> plateautempo = transfer(this._plateau, List.generate(10, (o) => List.generate(10, (p) => Case(false))));
    //parcours du plateau initial
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        //si la case du plateau à l'indince [i][j] est vivante
        if (this._plateau[i][j].getetat() == true) {
          //si cette même case détient un seul voisins
          //PS : Afin de faciliter mes test, je ne réalise pas ceux-ci avec les vrais règles du jeu.
          if (nombreVoisin(i, j) == 1) {
            //on fait mourir la case MAIS dans le plateau temporaire
            this.plateautempo[i][j].changeetat();
          }
        }
      }
    }

    print('Plat initial'); //affichage pour les tests
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        if (this._plateau[i][j].getetat() == true) {
          stdout.write("● ");
        } else {
          stdout.write("○ ");
        }
      }
      print("");
    }

    print('Plat temporaire'); //affichage pour les tests
    for (int i = 0; i < plateautempo.length; i++) {
      for (int j = 0; j < plateautempo[i].length; j++) {
        if (plateautempo[i][j].getetat() == true) {
          stdout.write("● ");
        } else {
          stdout.write("○ ");
        }
      }
      print("");
    }
    // transfer(plateautempo,this._plateau)
    // return this._plateau;
  }
}

/* Chose à taper dans le terminal pour les tests apres avoir lancé le programme.

>>> y
>>> 1
>>> 1
>>> y 
>>> 1
>>> 2
>>> n

  Plateau donné :                  Résultat reçu :              Résultat attendu :
● ● ○ ○ ○ ○ ○ ○ ○ ○             ○ ● ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○  ==> Les deux cellules sont censé mourir étant donné qu'elles ont un seul voisins chacunes.
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○
○ ○ ○ ○ ○ ○ ○ ○ ○ ○             ○ ○ ○ ○ ○ ○ ○ ○ ○ ○            ○ ○ ○ ○ ○ ○ ○ ○ ○ ○

*/