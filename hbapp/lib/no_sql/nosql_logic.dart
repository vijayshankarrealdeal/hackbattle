import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hbapp/model/no_sql.dart';
import 'package:http/http.dart' as http;

class NoSqlLogic extends ChangeNotifier {
  NoSqlLogic() {
    noSql();
  }
  bool load = false;

  void loadBegin() {
    load = true;
    notifyListeners();
  }

  void loadstop() {
    load = false;
    notifyListeners();
  }

  List<NoSqlModel> data = [];
  List<SecondDataPage> data2 = [];

  Future<void> noSql() async {
    loadBegin();
    final url = Uri.parse('http://127.0.0.1:8000/nosql/first/');
    final response = await http.get(url);

    final result = json
        .decode(response.body)
        .map<NoSqlModel>((e) => NoSqlModel.fromJson(e))
        .toList();
    data = result;
    loadstop();
    notifyListeners();
  }

  Future<List<SecondDataPage>> secondNoSql(String id) async {
    final _rand = Random();
    final List<Color> _colors = [
      Colors.blue.shade200,
      Colors.red.shade200,
      Colors.purple.shade200,
      Colors.green.shade200,
      Colors.teal.shade200,
      Colors.orange.shade200,
      Colors.pink.shade200,
    ];
    try {
      loadBegin();
      final url = Uri.parse('http://127.0.0.1:8000/nosql/second/$id');
      final response = await http.get(url);

      final result = json
          .decode(response.body)
          .map<SecondDataPage>((e) => SecondDataPage.fromJson(e))
          .toList();

      result.forEach((element) {
        element.color = _colors[_rand.nextInt(_colors.length)];
      });
      loadstop();
      notifyListeners();
      return result;
    } catch (e) {
      return [];
    }
  }
}
