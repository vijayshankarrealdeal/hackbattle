import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/dashboard/monthly_ana/month_analysic_logic.dart';
import 'package:hbapp/widget/text_default.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MonthlyAnalysis extends StatelessWidget {
  const MonthlyAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MonthAnaLogic>(builder: (context, data, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradinentTextGive(
                  text: "Daily Analysis",
                  colors: [
                    Colors.blue.shade900,
                    const Color(0xff11998E),
                    const Color(0xff38EF7D),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            "${data.selectedDate.month}-${data.selectedDate.day}-${data.selectedDate.year}"),
                        IconButton(
                          onPressed: () {
                            data.selectDate(context);
                          },
                          icon: const Icon(CupertinoIcons.calendar),
                        ),
                      ],
                    ),
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
            data.turn
                ? Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: SfCartesianChart(
                                legend: Legend(),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                    text: "Benifit Per Order",
                                    textStyle:
                                        Theme.of(context).textTheme.caption,
                                  ),
                                ),
                                primaryXAxis: CategoryAxis(
                                  labelRotation: 12,
                                  title: AxisTitle(
                                      textStyle:
                                          Theme.of(context).textTheme.caption,
                                      text:
                                          "Product Name (Sold on ${data.selectedDate.month}-${data.selectedDate.day}-${data.selectedDate.year})"),
                                  labelStyle:
                                      Theme.of(context).textTheme.caption,
                                ),
                                series: [
                                  LineSeries(
                                    dataSource: data.data,
                                    xValueMapper: (BenifitPerOrderDAna data,
                                            _) =>
                                        data.productName.substring(0, 8) + '..',
                                    yValueMapper:
                                        (BenifitPerOrderDAna data, _) =>
                                            data.benefitPerOrder,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    color: Colors.blue.shade900,
                                  ),
                                ]),
                          ),
                        ),
                        const Divider(
                          height: 12.0,
                          color: CupertinoColors.black,
                        ),
                        Text("Orders and Order Region",
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.72,
                          child: SfMaps(
                            layers: [
                              MapShapeLayer(
                                  source: MapShapeSource.asset(
                                    'assets/world_map.json',
                                    shapeDataField: 'name',
                                    dataCount: data.data1.length,
                                    primaryValueMapper: (int index) =>
                                        data.data1[index].orderRegion,
                                    shapeColorValueMapper: (int index) =>
                                        data.data1[index].count,
                                    shapeColorMappers: [
                                      MapColorMapper(
                                          from: 0,
                                          to: 2,
                                          color: Colors.purple.shade100,
                                          text: '{0},{2}'),
                                      MapColorMapper(
                                          from: 2,
                                          to: 4,
                                          color: Colors.purple.shade200,
                                          text: '4'),
                                      MapColorMapper(
                                          from: 4,
                                          to: 6,
                                          color: Colors.purple.shade300,
                                          text: '6'),
                                      MapColorMapper(
                                          from: 6,
                                          to: 7,
                                          color: Colors.purple.shade400,
                                          text: '7'),
                                      MapColorMapper(
                                          from: 7,
                                          to: 10,
                                          color: Colors.purple.shade500,
                                          text: '10'),
                                      MapColorMapper(
                                          from: 10,
                                          to: 20,
                                          color: Colors.purple.shade700,
                                          text: '20'),
                                      MapColorMapper(
                                          from: 20,
                                          to: 30,
                                          color: Colors.purple.shade700,
                                          text: '30'),
                                      MapColorMapper(
                                          from: 30,
                                          to: 40,
                                          color: Colors.purple.shade800,
                                          text: '40'),
                                      MapColorMapper(
                                          from: 40,
                                          to: 50,
                                          color: Colors.purple.shade900,
                                          text: '>50'),
                                    ],
                                  ),
                                  legend: const MapLegend.bar(MapElement.shape,
                                      position: MapLegendPosition.bottom,
                                      segmentSize: Size(55.0, 9.0)),
                                  strokeColor: Colors.black),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 12.0,
                          color: CupertinoColors.black,
                        ),
                        Text("Customer Segment",
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.72,
                          child: SfCircularChart(
                            tooltipBehavior: TooltipBehavior(enable: true),
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            series: [
                              PieSeries<CustomerSegmentAna, String>(
                                enableTooltip: true,
                                dataSource: data.data2,
                                xValueMapper: (data, _) => data.customerSegment,
                                yValueMapper: (data, _) => data.count,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 12.0,
                          color: CupertinoColors.black,
                        ),
                        Text("Transfer Type",
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.72,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: [
                              BarSeries<TransferTypeCustomer, String>(
                                dataSource: data.data3,
                                xValueMapper: (data, _) => data.transferType,
                                yValueMapper: (data, _) => data.count,
                                color: Colors.blue.shade900,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        );
      }),
    );
  }
}



//  SfCircularChart(
                          //   tooltipBehavior: TooltipBehavior(enable: true),
                          //   legend: Legend(
                          //       isVisible: true,
                          //       overflowMode: LegendItemOverflowMode.wrap),
                          //   series: [
                          //     PieSeries<RegionAndProductNameCount, String>(
                          //       enableTooltip: true,
                          //       dataSource: data.data1,
                          //       xValueMapper:
                          //           (RegionAndProductNameCount data, _) =>
                          //               data.orderRegion,
                          //       yValueMapper:
                          //           (RegionAndProductNameCount data, _) =>
                          //               data.count,
                          //       dataLabelMapper:
                          //           (RegionAndProductNameCount data, _) =>
                          //               data.orderRegion,
                          //       dataLabelSettings:
                          //           const DataLabelSettings(isVisible: true),
                          //     ),
                          //   ],
                          // ),