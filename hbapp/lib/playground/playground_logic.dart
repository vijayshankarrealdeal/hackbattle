import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaygroundLogic extends ChangeNotifier {
  String first = '';
  String second = '';
  List<Map<String, dynamic>> realation = [];
  bool load = false;

  List<AddMoreDim> widgetMore = [];

  void addMoreDim() {
    widgetMore.add(AddMoreDim(text: '', callback: () {}));
    notifyListeners();
  }

  void accept(String val, int index) {
    widgetMore[index].text = val;

    notifyListeners();
  }

  void removeItem(int index) {
    widgetMore.remove(widgetMore[index]);
    notifyListeners();
  }

  void myQuery() async {
    load = true;
    realation.clear();
    notifyListeners();
    try {
      String _query = 'insight from ';
      for (var element in widgetMore) {
        _query += element.text;
      }
      _query = _query.substring(0, _query.length - 1);

      final url = Uri.parse('http://127.0.0.1:8000/$_query');
      final response = await http.get(url);
      realation = (json.decode(response.body) as List)
          .map((dynamic e) => e as Map<String, dynamic>)
          .toList();
      load = false;
      notifyListeners();
    } catch (e) {
      load = false;
      notifyListeners();
    }
  }
}

class AddMoreDim {
  String text;
  final Function callback;

  AddMoreDim({required this.text, required this.callback});
}
