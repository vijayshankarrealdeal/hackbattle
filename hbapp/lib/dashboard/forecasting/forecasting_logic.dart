import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AutoGenerateForecast {
  AutoGenerateForecast({
    required this.date,
    required this.sales,
  });
  late final String date;
  late final num sales;

  AutoGenerateForecast.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sales = json['sales'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['sales'] = sales;
    return _data;
  }
}

class ForecastLogic extends ChangeNotifier {
  List<AutoGenerateForecast> data = [];

  bool turn = true;
  Future<void> getForecast() async {
    notifyListeners();
    try {
      final url = Uri.parse('http://127.0.0.1:8000/insight/forecasting');
      final response = await http.get(url);
      List l = json.decode(response.body);
      data = l.map((e) => AutoGenerateForecast.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  void turns(bool x) {
    turn = x;
    notifyListeners();
  }
}
