import 'dart:io';

class Fonctions {
  //Fonction permettante de saisir un entier.
  static int SaisirInt(String s) {
    bool valide = false;
    int i = 0;
    while (!valide) {
      print("Veuillez saisir le $s");
      try {
        i = int.parse(stdin.readLineSync().toString());
        valide = true;
      } catch (e) {
        print("Erreur dans la saisie du $s !");
      }
    }
    return i;
  }

  static String SaisirString() {
    //Fonction permettante de saisir un String.
    bool valide = false;
    String i = "";
    while (!valide) {
      try {
        i = stdin.readLineSync().toString();
        valide = true;
      } catch (e) {
        print("Erreur dans la saisie de votre chaine de caractère !");
      }
    }
    return i;
  }

  static String ReversedString(String i) {
    //Fonction permettante d'inverser une chaine de caractère.
    String reversed = "";
    for (int x = i.length; x != 0; x--) {
      reversed += i.substring(x - 1, x);
    }
    return reversed;
  }

  static String CompareTailleMot(String i, String j) {
    //Fonction permettante de comparer la longueur de deux chaines de caractère.
    String reponse = "";
    if (i.length == j.length) {
      reponse = "Les deux mots sont de la même taille";
    }
    if (i.length < j.length) {
      reponse = "\"$j\" est long que \"$i\"";
    } else {
      reponse = "\"$i\" est long que \"$j\"";
    }
    return reponse;
  }

  static String triangle(int taille) {
    //Fonction permettante générer un triangle.
    String reponse = "";
    for (int i = 1; i <= taille; i++) {
      for (int j = i; j != 0; j--) {
        reponse += "*";
      }
      reponse += "\n";
    }
    return reponse;
  }

  static String carre(int taille) {
    //Fonction permettante générer un carré.
    String reponse = "";
    for (int i = 1; i <= taille; i++) {
      for (int j = 1; j <= taille; j++) {
        reponse += "*";
      }
      reponse += "\n";
    }
    return reponse;
  }

  static String rectangle(int longueur, int largeur) {
    //Fonction permettante générer un rectangle.
    String reponse = "";
    for (int i = 1; i <= largeur; i++) {
      for (int j = 1; j <= longueur; j++) {
        reponse += "*";
      }
      reponse += "\n";
    }
    return reponse;
  }

  static int saisirIntervalle(int min, int max, int nb) {
    //Fonction permettante resaisir un chiffre si celui-ci n'est pas dans une intervalle.
    bool estdanslinter = false;
    while (estdanslinter != true) {
      if (nb < min || nb > max) {
        print("Votre saisie n'est pas un nombre compris entre $min et $max !");
        nb = SaisirInt("à nouveau votre valeur");
      } else {
        estdanslinter = true;
      }
    }
    return nb;
  }

  static int sommeTab(List<int> tab) {
    //Fonction permettante de retourner la somme des valeurs d'un tableau.
    int reponse = 0;
    for (int j = 0; j < tab.length; j++) {
      reponse += tab[j];
    }
    return reponse;
  }

  static int MinTab(List<int> tab) {
    //Fonction permettante de retourner la valeur minimale d'un tableau.
    int min = tab[0];
    for (int j = 0; j < tab.length; j++) {
      if (tab[j] < min) {
        min = tab[j];
      }
    }
    return min;
  }

  static int MaxTab(List<int> tab) {
    //Fonction permettante de retourner la valeur maximale d'un tableau.
    int max = tab[0];
    for (int j = 0; j < tab.length; j++) {
      if (tab[j] > max) {
        max = tab[j];
      }
    }
    return max;
  }
}
