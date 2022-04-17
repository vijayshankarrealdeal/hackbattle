import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/dashboard/products/most_famous_logic.dart';
import 'package:hbapp/dashboard/products/table_ui.dart';
import 'package:hbapp/model/most_sold_item.dart';
import 'package:hbapp/widget/text_default.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FamousUI extends StatelessWidget {
  const FamousUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MostFamousLogic>(builder: (context, data, _) {
        return data.data.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GradinentTextGive(
                        text: "Latest Trends",
                        colors: [Color(0xffDA44bb), Color(0xff8921aa)],

                        //   text: "Products", colors: [
                        //   Color(0xff833ab4),
                        //   Color(0xfffd1d1d),
                        //   Color(0xfffcb045),
                        // ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                CupertinoIcons.up_arrow,
                                color: CupertinoColors.activeGreen,
                                size: 13,
                              ),
                              SizedBox(height: 5),
                              Icon(
                                CupertinoIcons.down_arrow,
                                color: CupertinoColors.destructiveRed,
                                size: 13,
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GradinentTextGive(
                                  fontSize: 13,
                                  text: data.data.first.productName.trim(),
                                  colors: const [
                                    Color(0xff833ab4),
                                    Color(0xfffd1d1d),
                                    Color(0xfffcb045),
                                  ]),
                              const SizedBox(height: 5),
                              GradinentTextGive(
                                  fontSize: 13,
                                  text: data.data.last.productName,
                                  colors: const [
                                    Color(0xff833ab4),
                                    Color(0xfffd1d1d),
                                    Color(0xfffcb045),
                                  ]),
                            ],
                          ),
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
                        ? ListView(
                            controller: ScrollController(),
                            children: [
                              Text("Products",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.72,
                                child: SfCartesianChart(series: [
                                  HistogramSeries<FamousItems, String>(
                                    dataSource: data.data,
                                    dataLabelMapper: (FamousItems data, _) =>
                                        data.productName.substring(0, 9) + '..',
                                    yValueMapper: (FamousItems data, _) =>
                                        data.productPrice,
                                    binInterval: 3,
                                    showNormalDistributionCurve: true,
                                    curveColor:
                                        const Color.fromARGB(186, 0, 153, 255),
                                    borderWidth: 2,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    color: Colors.blue.shade900,
                                  ),
                                ]),
                              ),
                              Text("Category Name",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.72,
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: [
                                    BarSeries<TopTenCatName, String>(
                                      dataSource: data.data1,
                                      xValueMapper: (data, _) =>
                                          data.categoryName,
                                      yValueMapper: (data, _) => data.count,
                                      color: Colors.blue.shade900,
                                    ),
                                  ],
                                ),
                              ),
                              Text("Customer City",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.72,
                                child: SfPyramidChart(
                                  legend: Legend(isVisible: true),
                                  palette: const [
                                    Color(0xFf3875e3),
                                    Color(0xFf3268ca),
                                    Color(0xff2b5bb0),
                                    Color(0xff254e97),
                                    Color(0xff1f417e),
                                    Color(0xff193465),
                                    Color(0xff13274c),
                                    Color(0xff0c1a32),
                                    Color(0xff060d19),
                                    Color(0xff000000),
                                  ],
                                  series: PyramidSeries<TopTenCatName, String>(
                                    dataSource: data.data2,
                                    xValueMapper: (data, _) =>
                                        data.categoryName,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    yValueMapper: (data, _) =>
                                        data.count > 10000 ? 8000 : data.count,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : FamousItemTable(
                            data: data.data,
                          ),
                  )
                ],
              );
      }),
    );
  }
}
