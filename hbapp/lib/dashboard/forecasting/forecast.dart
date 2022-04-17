import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/dashboard/forecasting/forecast_table_ui.dart';
import 'package:hbapp/dashboard/forecasting/forecasting_logic.dart';
import 'package:hbapp/widget/text_default.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Forecasting extends StatelessWidget {
  const Forecasting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ForecastLogic>(builder: (context, data, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradinentTextGive(
                  text: "Forecasting",
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade900,
                  ],
                ),
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
                  ? SfCartesianChart(
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(
                          text: "Monthy Forecast For Total Benifit Per Order",
                          textStyle: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                            textStyle: Theme.of(context).textTheme.caption,
                            text: "Months"),
                        labelStyle: Theme.of(context).textTheme.caption,
                      ),
                      series: [
                          LineSeries<AutoGenerateForecast, String>(
                            dataSource: data.data,
                            xValueMapper: (AutoGenerateForecast data, _) =>
                                data.date.substring(0, 10),
                            yValueMapper: (AutoGenerateForecast data, _) =>
                                data.sales,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            color: Colors.blue.shade900,
                            opacity: 0.9,
                            width: 5.0,
                          ),
                        ])
                  : ForecsatTable(
                      data: data.data,
                    ),
            ),
          ],
        );
      }),
    );
  }
}
