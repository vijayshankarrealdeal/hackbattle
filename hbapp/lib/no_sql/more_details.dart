import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/dashboard/fraud/fraud_ui.dart';
import 'package:hbapp/model/no_sql.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NoSqlMoreDetail extends StatelessWidget {
  const NoSqlMoreDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      appBar: AppBar(),
      body: Consumer2<List<SecondDataPage>, Data>(
        builder: (context, _data, _dataMain, _) {
          num postive = 0;
          num negative = 0;
          for (var e in _data) {
            if (e.label == 'POSITIVE') {
              postive++;
            } else {
              negative++;
            }
          }
          List<ManKaClass> l = [
            ManKaClass("Postive Review", CupertinoColors.activeGreen, postive),
            ManKaClass(
                "Negative Review", CupertinoColors.destructiveRed, negative)
          ];
          return _data.isEmpty
              ? const Center(child: CupertinoActivityIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                _dataMain.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            series: [
                                              BarSeries(
                                                dataSource: _data,
                                                xValueMapper:
                                                    (SecondDataPage data, _) =>
                                                        data.rating.toString(),
                                                yValueMapper:
                                                    (SecondDataPage data, _) =>
                                                        data.rating,
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                        isVisible: true),
                                                color: Colors.blue.shade900,
                                              ),
                                            ]),
                                        Text(
                                          "Ratings",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SfCircularChart(
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          legend: Legend(
                                              isVisible: true,
                                              overflowMode:
                                                  LegendItemOverflowMode.wrap),
                                          series: [
                                            PieSeries<ManKaClass, String>(
                                              enableTooltip: true,
                                              dataSource: l,
                                              xValueMapper: (data, _) =>
                                                  data.name,
                                              yValueMapper: (data, _) => data.n,
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                      isVisible: true),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Reviews",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Categories",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _dataMain.categories.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: Chip(
                                        label:
                                            Text(_dataMain.categories[index])),
                                  ),
                                  scrollDirection: Axis.horizontal,
                                ),
                              )
                            ],
                          )),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Reviews",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: _data[index].label == 'POSITIVE'
                                    ? Colors.blue.shade900
                                    : Colors.red.shade900,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: _data[index].color,
                                      child: Text(
                                        _data[index]
                                            .username
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: AutoSizeText(_data[index].text))
                                  ],
                                ),
                              )),
                        );
                      }, childCount: _data.length),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
