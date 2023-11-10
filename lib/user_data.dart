import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  String alias = '';
  int limiteSuperior = 0;
  int juegosGanados = 0;

  void updateUserData(String newAlias, int newLimiteSuperior) {
    alias = newAlias;
    limiteSuperior = newLimiteSuperior;
    notifyListeners();
  }

  void incrementarJuegosGanados() {
    juegosGanados += 1;
    notifyListeners();
  }
}



