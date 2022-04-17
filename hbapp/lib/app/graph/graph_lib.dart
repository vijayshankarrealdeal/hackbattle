import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CartesianChartBarX extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CartesianChartBarX({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(primaryXAxis: CategoryAxis(), series: [
      BarSeries(
        dataSource: data,
        xValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[0]],
        yValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[1]],
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        color: Colors.blue.shade900,
      ),
    ]);
  }
}

class CartesianChartLineX extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CartesianChartLineX({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(primaryXAxis: CategoryAxis(), series: [
      LineSeries(
        dataSource: data,
        xValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[0]],
        yValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[1]],
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        color: Colors.blue.shade900,
      ),
    ]);
  }
}

class CartesianChartScatterX extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CartesianChartScatterX({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(primaryXAxis: CategoryAxis(), series: [
      ScatterSeries(
        dataSource: data,
        xValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[0]],
        yValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[1]],
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        color: Colors.blue.shade900,
      ),
    ]);
  }
}

class CartesianChartPieX extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CartesianChartPieX({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: [
        PieSeries(
          enableTooltip: true,
          dataSource: data,
          xValueMapper: (data, _) => data[data.keys.toList()[0]],
          yValueMapper: (data, _) => data[data.keys.toList()[1]],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class CartesianChartBubbleX extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CartesianChartBubbleX({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(primaryXAxis: CategoryAxis(), series: [
      BubbleSeries(
        dataSource: data,
        xValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[0]],
        yValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[1]],
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        color: Colors.blue.shade900,
      ),
    ]);
  }
}

class CartesianChartHistogramX extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CartesianChartHistogramX({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(series: [
      HistogramSeries(
        dataSource: data,
        yValueMapper: (Map<String, dynamic> data, _) =>
            data[data.keys.toList()[1]],
        binInterval: 20,
        showNormalDistributionCurve: true,
        curveColor: const Color.fromARGB(186, 0, 153, 255),
        borderWidth: 3,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        color: Colors.blue.shade900,
      ),
    ]);
  }
}
