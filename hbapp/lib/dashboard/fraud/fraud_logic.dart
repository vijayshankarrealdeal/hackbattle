import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hbapp/model/fraud_model.dart';
import 'package:http/http.dart' as http;

class FraudLogic extends ChangeNotifier {
  List<FraudData> data = [];
  List<LateDRisk> data1 = [];

  bool turn = true;
  Future<void> getFraudData() async {
    notifyListeners();
    try {
      final url =
          Uri.parse('http://127.0.0.1:8000/riskFraud/getforecastfraud/');
      final response = await http.get(url);
      List l = json.decode(response.body);
      data = l[0].map<FraudData>((e) => FraudData.fromJson(e)).toList();
      data1 = l[1].map<LateDRisk>((e) => LateDRisk.fromJson(e)).toList();

      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  void turns(bool x) {
    turn = x;
    notifyListeners();
  }
}

class LateDRisk {
  LateDRisk({
    required this.count,
    required this.lateDeliveryRisk,
  });
  late final num count;
  late final num lateDeliveryRisk;

  LateDRisk.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    lateDeliveryRisk = json['late_delivery_risk'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['category_name'] = lateDeliveryRisk;
    return _data;
  }
}
