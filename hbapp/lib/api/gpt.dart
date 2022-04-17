import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class GPT extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> dataFinal = [];
  bool load = false;
  void myQuery() async {
    load = true;
    dataFinal.clear();
    notifyListeners();
    try {
      final url = Uri.parse('http://127.0.0.1:8000/${controller.text}');
      final response = await http.get(url);
      print(response.body);
      dataFinal = (json.decode(response.body) as List)
          .map((dynamic e) => e as Map<String, dynamic>)
          .toList();
      load = false;
      notifyListeners();
    } catch (e) {
      print(e);
      load = false;
      notifyListeners();
    }
  }
}
