import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/dashboard/fraud/fraud_logic.dart';
import 'package:hbapp/dashboard/fraud/table_ui.dart';
import 'package:hbapp/widget/text_default.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ManKaClass {
  final String name;
  final num n;
  final Color color;

  ManKaClass(this.name, this.color, this.n);
}

class FraudUI extends StatelessWidget {
  const FraudUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FraudLogic>(builder: (context, data, _) {
        num postive = 0;
        num negative = 0;
        for (var e in data.data) {
          if (e.fraud == 0) {
            postive++;
          } else {
            negative++;
          }
        }
        List<ManKaClass> l = [
          ManKaClass("Safe", CupertinoColors.activeGreen, postive),
          ManKaClass("Fraud", CupertinoColors.destructiveRed, negative)
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradinentTextGive(text: "Risks And Frauds", colors: [
                  Colors.orange.shade700,
                  Colors.pink,
                  Colors.red,
                ]),
                Row(
                  children: [
                    CupertinoButton(
                        onPressed: () => data.turns(true),
                        child: Text(
                          "Chart",
                          style: Theme.of(context).textTheme.button,
                        )),
                    CupertinoButton(
                        onPressed: () => data.turns(false),
                        child: Text("Table",
                            style: Theme.of(context).textTheme.button)),
                  ],
                ),
              ],
            ),
            Expanded(
              child: data.turn
                  ? Row(
                      children: [
                        Expanded(
                          child: SfCircularChart(
                            palette: [
                              Colors.blue.shade900,
                              Colors.pink.shade900,
                            ],
                            tooltipBehavior: TooltipBehavior(enable: true),
                            legend: Legend(
                                position: LegendPosition.bottom,
                                alignment: ChartAlignment.center,
                                title: LegendTitle(
                                    text: "Fraud Status",
                                    textStyle:
                                        Theme.of(context).textTheme.bodyMedium),
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            series: [
                              PieSeries<ManKaClass, String>(
                                enableTooltip: true,
                                dataSource: l,
                                xValueMapper: (data, _) => data.name,
                                yValueMapper: (data, _) => data.n,
                                dataLabelMapper: (data, _) => data.name,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SfCircularChart(
                            tooltipBehavior: TooltipBehavior(enable: true),
                            palette: [
                              Colors.blue.shade900,
                              Colors.pink.shade900,
                            ],
                            legend: Legend(
                                position: LegendPosition.bottom,
                                alignment: ChartAlignment.center,
                                title: LegendTitle(
                                    text: "Late Delivery Risk",
                                    textStyle:
                                        Theme.of(context).textTheme.bodyMedium),
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            series: [
                              PieSeries<LateDRisk, String>(
                                enableTooltip: true,
                                dataSource: data.data1,
                                xValueMapper: (data, _) =>
                                    data.lateDeliveryRisk == 0
                                        ? 'Safe'
                                        : 'Late',
                                yValueMapper: (data, _) => data.count,
                                dataLabelMapper: (data, _) =>
                                    data.lateDeliveryRisk == 0
                                        ? 'Safe'
                                        : 'Late',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : FraudTable(
                      data: data.data,
                    ),
            ),
          ],
        );
      }),
    );
  }
}


// Scaffold(
//       appBar: AppBar(),
//       body:
//     );