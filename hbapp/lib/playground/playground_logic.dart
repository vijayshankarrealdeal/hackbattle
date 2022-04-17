import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PlaygroundLogic extends ChangeNotifier {
  String first = '';
  String second = '';
  List<Map<String, dynamic>> realation = [];
  bool load = false;

  void accept1(String val) {
    first = val;
    notifyListeners();
  }

  void accept2(String val) {
    second = val;
    notifyListeners();
  }

  void myQuery() async {
    load = true;
    realation.clear();
    notifyListeners();
    try {
      final url = Uri.parse(
          'http://127.0.0.1:8000/relation between $first and $second');
      final response = await http.get(url);
      print(response.body);
      realation = (json.decode(response.body) as List)
          .map((dynamic e) => e as Map<String, dynamic>)
          .toList();
      load = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
