import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonthAnaLogic extends ChangeNotifier {
  DateTime selectedDate = DateTime(2016, 1, 1);
  List<BenifitPerOrderDAna> data = [];
  List<RegionAndProductNameCount> data1 = [];
  List<CustomerSegmentAna> data2 = [];
  List<TransferTypeCustomer> data3 = [];
  bool turn = true;
  Future<void> getDailyAna() async {
    List<CustomerSegmentAna> _ss = [];
    // ignore: unused_local_variable
    List<TransferTypeCustomer> _ssy = [];
    notifyListeners();
    try {
      final url = Uri.parse(
          'http://127.0.0.1:8000/insight/dailyana/${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');
      final response = await http.get(url);
      List l = json.decode(response.body);
      data = l[0]
          .map<BenifitPerOrderDAna>((e) => BenifitPerOrderDAna.fromJson(e))
          .toList();
      data1 = l[1]
          .map<RegionAndProductNameCount>(
              (e) => RegionAndProductNameCount.fromJson(e))
          .toList();
      data2 = l[2]
          .map<CustomerSegmentAna>((e) => CustomerSegmentAna.fromJson(e))
          .toList();
      Map<String, num> xx = {
        'Consumer': 0,
        'Corporate': 0,
        'Home Office': 0,
      };
      for (var e in data2) {
        xx[e.customerSegment] = xx[e.customerSegment]! + e.count;
      }
      xx.forEach((e, y) {
        _ss.add(
            CustomerSegmentAna(count: y, customerSegment: e, orderRegion: ''));
      });
      data2.clear();
      data2 = _ss;

      ////
      data3 = l[3]
          .map<TransferTypeCustomer>((e) => TransferTypeCustomer.fromJson(e))
          .toList();

      // Map<String, num> xy = {
      //   'Consumer': 0,
      //   'Corporate': 0,
      //   'Home Office': 0,
      // };
      // for (var e in data3) {
      //   xy[e.transferType] = xy[e.transferType]! + e.count;
      // }
      // xx.forEach((e, y) {
      //   _ssy.add(
      //       TransferTypeCustomer(count: y, customerSegment: e, orderRegion: ''));
      // });
      // data2.clear();
      // data2 = _ss;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2017, 12, 30),
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
      getDailyAna();
      notifyListeners();
    }
  }

  void turns(bool x) {
    turn = x;
    notifyListeners();
  }
}

class TransferTypeCustomer {
  TransferTypeCustomer({
    required this.transferType,
    required this.orderRegion,
    required this.count,
  });
  late final String transferType;
  late final String orderRegion;
  late final num count;

  TransferTypeCustomer.fromJson(Map<String, dynamic> json) {
    transferType = json['transfer_type'];
    orderRegion = json['order_country'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transfer_type'] = transferType;
    _data['order_country'] = orderRegion;
    _data['count'] = count;
    return _data;
  }
}

class BenifitPerOrderDAna {
  BenifitPerOrderDAna({
    required this.productName,
    required this.benefitPerOrder,
  });
  late final String productName;
  late final num benefitPerOrder;

  BenifitPerOrderDAna.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    benefitPerOrder = json['benefit_per_order'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_name'] = productName;
    _data['benefit_per_order'] = benefitPerOrder;
    return _data;
  }
}

class RegionAndProductNameCount {
  RegionAndProductNameCount({
    required this.productName,
    required this.orderRegion,
    required this.count,
  });
  late final String productName;
  late final String orderRegion;
  late final num count;

  RegionAndProductNameCount.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    orderRegion = json['order_country'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_name'] = productName;
    _data['order_country'] = orderRegion;
    _data['count'] = count;
    return _data;
  }
}

class CustomerSegmentAna {
  CustomerSegmentAna({
    required this.customerSegment,
    required this.orderRegion,
    required this.count,
  });
  late final String customerSegment;
  late final String orderRegion;
  late final num count;

  CustomerSegmentAna.fromJson(Map<String, dynamic> json) {
    customerSegment = json['customer_segment'];
    orderRegion = json['order_country'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customer_segment'] = customerSegment;
    _data['order_country'] = orderRegion;
    _data['count'] = count;
    return _data;
  }
}
