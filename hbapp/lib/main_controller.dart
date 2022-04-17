import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/app/graph/graph_lib.dart';
import 'package:hbapp/dashboard/dashboard.dart';
import 'package:hbapp/dashboard/forecasting/forecast.dart';
import 'package:hbapp/dashboard/forecasting/forecasting_logic.dart';
import 'package:hbapp/dashboard/fraud/fraud_logic.dart';
import 'package:hbapp/dashboard/fraud/fraud_ui.dart';
import 'package:hbapp/dashboard/latest_trend/latest_trends.dart';
import 'package:hbapp/dashboard/monthly_ana/month_analysic_logic.dart';
import 'package:hbapp/dashboard/monthly_ana/monthly_ana.dart';
import 'package:hbapp/dashboard/products/most_famous_logic.dart';
import 'package:hbapp/dashboard/products/products.dart';
import 'package:hbapp/playground/play_start.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

enum TabSelect { connect, dashboard, graph, table, trends }
enum GraphList { line, bar, pie, scatter, bubble, histogram }
enum DashBoardItemSelect { forecasting, products, mAna, frauds }

enum ConnectionTypeX { sql, nosql }

class BarLogic extends ChangeNotifier {
  TabSelect selectedTab = TabSelect.dashboard;
  GraphList selectedGraph = GraphList.line;
  DashBoardItemSelect defaultFirstPage = DashBoardItemSelect.products;
  ConnectionTypeX defaultX = ConnectionTypeX.sql;

  bool load = false;

  void loadBegin() {
    load = true;
    notifyListeners();
  }

  void loadstop() {
    load = false;
    notifyListeners();
  }

  List<String> numeric = [];
  List<String> mixed = [];
  Future<void> getDataTypes(String data) async {
    if (data == 's') {
      defaultX = ConnectionTypeX.sql;
    } else {
      defaultX = ConnectionTypeX.nosql;
    }
    notifyListeners();
    try {
      final url = Uri.parse('http://127.0.0.1:8000/datatype/$data');
      final response = await http.get(url);
      numeric.clear();
      mixed.clear();
      Map<String, dynamic> ss = json.decode(response.body);
      ss.forEach((key, value) {
        if (value == "integer" || value == "numeric") {
          numeric.add(key);
        } else {
          mixed.add(key);
        }
      });
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Widget giveWidgets() {
    if (selectedTab == TabSelect.dashboard) {
      return const Expanded(
        child: DashBoard(),
      );
    }
    if (selectedTab == TabSelect.trends) {
      return const Expanded(
        child: PlayGroundMain(),
      );
    }
    return const SizedBox.shrink();
  }

  Widget giveMyDashboard() {
    if (defaultFirstPage == DashBoardItemSelect.forecasting) {
      return const Forecasting();
    }
    if (defaultFirstPage == DashBoardItemSelect.products) {
      return const FamousUI();
    }
    if (defaultFirstPage == DashBoardItemSelect.mAna) {
      return const MonthlyAnalysis();
    }
    if (defaultFirstPage == DashBoardItemSelect.frauds) {
      return const FraudUI();
    }
    return const LatestTrends();
  }

  Widget giveGraph(List<Map<String, dynamic>> data, BuildContext context) {
    if (data[0].keys.length != 2) {
      return Expanded(
        child: Center(
          child: Text(' Need at least two for plotting',
              style: Theme.of(context).textTheme.headline6),
        ),
      );
    }
    if (selectedGraph == GraphList.scatter) {
      return CartesianChartScatterX(data: data);
    }
    if (selectedGraph == GraphList.bar) {
      return CartesianChartBarX(data: data);
    }
    if (selectedGraph == GraphList.pie) {
      return CartesianChartPieX(data: data);
    }
    if (selectedGraph == GraphList.bubble) {
      return CartesianChartBubbleX(data: data);
    }
    if (selectedGraph == GraphList.histogram) {
      return CartesianChartHistogramX(data: data);
    }
    if (selectedGraph == GraphList.line) {
      return CartesianChartLineX(data: data);
    }
    return CartesianChartLineX(data: data);
  }

  void selectDashBoardTab(DashBoardItemSelect item) {
    defaultFirstPage = item;
    notifyListeners();
  }

  void selectTab(TabSelect select) {
    selectedTab = select;
    notifyListeners();
  }

  void selectChart(GraphList select) {
    selectedGraph = select;
    notifyListeners();
  }

  bool showData = true;
  void showRightBar() {
    showData = !showData;
    notifyListeners();
  }

  bool leftBar = true;
  void showLeftBar() {
    leftBar = !leftBar;
    notifyListeners();
  }
}

void alertMessage(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Consumer<BarLogic>(builder: (context, data, _) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: CupertinoColors.darkBackgroundGray,
            ),
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.height * 0.55,
            child: data.load
                ? const Center(
                    child: CupertinoActivityIndicator(radius: 40),
                  )
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        CupertinoButton(
                            color: Colors.blue.shade900,
                            child: Text("  Structured Data  ",
                                style: Theme.of(context).textTheme.button),
                            onPressed: () async {
                              data.loadBegin();
                              await Future.wait([
                                data.getDataTypes('s'),
                                Provider.of<FraudLogic>(context, listen: false)
                                    .getFraudData(),
                                Provider.of<MostFamousLogic>(context,
                                        listen: false)
                                    .getMostFamousItemsData(),
                                Provider.of<MostFamousLogic>(context,
                                        listen: false)
                                    .getTop10CatName(),
                                Provider.of<MonthAnaLogic>(context,
                                        listen: false)
                                    .getDailyAna(),
                                Provider.of<ForecastLogic>(context,
                                        listen: false)
                                    .getForecast(),
                              ]);

                              data.loadstop();
                              Navigator.pop(context);
                            }),
                        const Spacer(),
                        CupertinoButton(
                            color: Colors.blue.shade900,
                            child: Text("Unstructured Data",
                                style: Theme.of(context).textTheme.button),
                            onPressed: () {}),
                        const Spacer(),
                        CupertinoButton(
                            child: Text("Back",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        color: CupertinoColors.destructiveRed)),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  ),
          ),
        );
      });
    },
  );
}
