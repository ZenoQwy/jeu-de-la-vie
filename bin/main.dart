import 'dart:io';

import 'A Functions.dart';
import 'plateau.dart';
import 'case.dart';

void main(List<String> arguments) {
  Plateau plat1 = Plateau();

  plat1.initCoordonnees();
  plat1.afficherPlateau();
  plat1.generationSuivante();
  //plat1.afficherPlateau();

  // print(plat1.nombreVoisin(
  //     Fonctions.saisirIntervalle(1, plat1.getlongueur(), Fonctions.SaisirInt("numéro de la ligne")),
  //     Fonctions.saisirIntervalle(1, plat1.getlongueur(), Fonctions.SaisirInt("numéro de la colonne"))));
}













