import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:hbapp/model/most_sold_item.dart';

class MostFamousLogic extends ChangeNotifier {
  List<FamousItems> data = [];
  List<TopTenCatName> data1 = [];
  List<TopTenCatName> data2 = [];

  bool turn = true;
  Future<void> getMostFamousItemsData() async {
    notifyListeners();

    try {
      final url = Uri.parse('http://127.0.0.1:8000/insight/mostsolditem');
      final response = await http.get(url);
      List l = json.decode(response.body);
      data = l.map((e) => FamousItems.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> getTop10CatName() async {
    notifyListeners();

    try {
      final url = Uri.parse('http://127.0.0.1:8000/trends/topCatName');
      final response = await http.get(url);
      List l = json.decode(response.body);

      data1 = l[0]
          .map<TopTenCatName>((e) => TopTenCatName.fromJson(e))
          .toList()
          .reversed
          .toList();
      data2 = l[1]
          .map<TopTenCatName>((e) => TopTenCatName.fromJson(e))
          .toList()
          .reversed
          .toList();
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

class TopTenCatName {
  TopTenCatName({
    required this.count,
    required this.categoryName,
  });
  late final num count;
  late final String categoryName;

  TopTenCatName.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    categoryName = json['category_name'] ?? json['customer_city'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['category_name'] = categoryName;
    return _data;
  }
}
