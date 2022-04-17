import 'package:flutter/cupertino.dart';

class PlaygroundLogic extends ChangeNotifier {
  String first = '';
  String second = '';
  void accept1(String val) {
    first = val;
    notifyListeners();
  }

  void accept2(String val) {
    second = val;
    notifyListeners();
  }
}
