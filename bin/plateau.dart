import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'A Functions.dart';
import 'case.dart';

class Plateau {
  List<List<Case>> _plateau = List.generate(10, (i) => List.generate(10, (j) => Case(false)));
  Plateau();

  afficherPlateau() {
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

  initCoordonnees() {
    print("Souhaitez-vous saisir des cellules vivantes ? y/n");
    String choix = Fonctions.SaisirString();
    if (choix != "n" && choix != "y") {
      print("Saisie invalide");
      initCoordonnees();
    }
    if (choix == "y") {
      int coorI = Fonctions.saisirIntervalle(1, this._plateau.length, Fonctions.SaisirInt("numéro de la ligne"));
      int coorJ = Fonctions.saisirIntervalle(1, this._plateau.length, Fonctions.SaisirInt("numéro de la colonne"));
      if (this._plateau[coorI - 1][coorJ - 1].getetat() == true) {
        print("La case est déjà vivante !");
        initCoordonnees();
      } else {
        this._plateau[coorI - 1][coorJ - 1].changeetat();
        initCoordonnees();
      }
    }
    if (choix == "n") {
      print("Voici le tableau :");
    }
  }

  List<List<Case>> transfer(List<List<Case>> plat1, List<List<Case>> plat2) {
    for (int i = 0; i < plat1.length; i++) {
      for (int j = 0; j < plat1[i].length; j++) {
        plat2[i][j] = plat1[i][j];
      }
    }
    return plat2;
  }

  int nombreVoisin(int x, int y) {
    List<List<Case>> plateauu =
        List.generate(this._plateau.length + 2, (i) => List.generate(this._plateau.length + 2, (j) => Case(false)));
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        plateauu[i + 1][j + 1] = this._plateau[i][j];
      }
    }

    int nbvoisins = 0;
    x += 1;
    y += 1;
    print("Analyse de la case ${x};${y}");
    if (plateauu[x - 1][y + 1].getetat() == true) {
      // ↗
      nbvoisins++;
      print("Un voisin en ${x - 1};${y + 1}");
    }
    if (plateauu[x + 1][y + 1].getetat() == true) {
      // ↘
      nbvoisins++;
      print("Un voisin en ${x + 1};${y + 1}");
    }
    if (plateauu[x - 1][y - 1].getetat() == true) {
      // ↖
      nbvoisins++;
      print("Un voisin en ${x - 1};${y - 1}");
    }
    if (plateauu[x + 1][y - 1].getetat() == true) {
      // ↙
      nbvoisins++;
      print("Un voisin en ${x + 1};${y - 1}");
    }
    if (plateauu[x][y - 1].getetat() == true) {
      // ⬅
      nbvoisins++;
      print("Un voisin en ${x};${y - 1}");
    }
    if (plateauu[x][y + 1].getetat() == true) {
      // ➡
      nbvoisins++;
      print("Un voisin en ${x};${y + 1}");
    }
    if (plateauu[x - 1][y].getetat() == true) {
      // ⬆
      nbvoisins++;
      print("Un voisin en ${x - 1};${y}");
    }
    if (plateauu[x + 1][y].getetat() == true) {
      // ⬇
      nbvoisins++;
      print("Un voisin en ${x + 1};${y}");
    }
    print("Voisins totaux : ${nbvoisins}\n------------------------------------------");
    return nbvoisins;
  }

  List<List<Case>> generationSuivante() {
    List<List<Case>> _plateautempo =
        transfer(this._plateau, List.generate(10, (o) => List.generate(10, (p) => Case(false))));
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        if (this._plateau[i][j].getetat() == true) {
          if (nombreVoisin(i, j) == 1) {
            this._plateautempo[i][j].changeetat();
          }
        }
      }
    }

    print('Plat this');
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

    print('Plat vide');
    for (int i = 0; i < this._plateautempo.length; i++) {
      for (int j = 0; j < this._plateautempo[i].length; j++) {
        if (this._plateautempo[i][j].getetat() == true) {
          stdout.write("● ");
        } else {
          stdout.write("○ ");
        }
      }
      print("");
    }
    return this._plateau;
  }
}
