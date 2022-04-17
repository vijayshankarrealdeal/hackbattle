import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hbapp/dashboard/forecasting/forecasting_logic.dart';
import 'package:hbapp/dashboard/fraud/fraud_logic.dart';
import 'package:hbapp/dashboard/monthly_ana/month_analysic_logic.dart';
import 'package:hbapp/dashboard/products/most_famous_logic.dart';
import 'package:hbapp/icons/my_flutter_app_icons.dart';
import 'package:hbapp/main_controller.dart';
import 'package:hbapp/widget/icons_button.dart';
import 'package:provider/provider.dart';

class BarUpper extends StatelessWidget {
  const BarUpper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BarLogic>(
      builder: (context, data, _) {
        return Container(
          color: CupertinoColors.darkBackgroundGray,
          height: MediaQuery.of(context).size.height * 0.055,
          child: data.mixed.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButtonApp(
                      callback: () => data.showLeftBar(),
                      icons: !data.leftBar
                          ? CupertinoIcons.bars
                          : CupertinoIcons.pin,
                      color: CupertinoColors.white,
                    ),
                    (data.selectedTab == TabSelect.graph ||
                            data.selectedTab == TabSelect.trends)
                        ? Row(
                            children: [
                              IconButtonApp(
                                callback: () =>
                                    data.selectChart(GraphList.line),
                                icons: FontAwesomeIcons.chartLine,
                                color: CupertinoColors.white,
                              ),
                              IconButtonApp(
                                callback: () => data.selectChart(GraphList.pie),
                                icons: CupertinoIcons.chart_pie,
                                color: CupertinoColors.white,
                              ),
                              IconButtonApp(
                                callback: () => data.selectChart(GraphList.bar),
                                icons: FontAwesomeIcons.chartBar,
                                color: CupertinoColors.white,
                              ),
                              IconButtonApp(
                                callback: () =>
                                    data.selectChart(GraphList.scatter),
                                icons: MyFlutterApp.scatter_plot_1,
                                color: CupertinoColors.white,
                              ),
                              IconButtonApp(
                                callback: () =>
                                    data.selectChart(GraphList.bubble),
                                icons: FontAwesomeIcons.circle,
                                color: CupertinoColors.white,
                              ),
                              IconButtonApp(
                                callback: () =>
                                    data.selectChart(GraphList.histogram),
                                icons: Icons.bar_chart,
                                color: CupertinoColors.white,
                              ),
                            ],
                          )
                        : data.selectedTab == TabSelect.dashboard &&
                                data.mixed.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () => data.selectDashBoardTab(
                                        DashBoardItemSelect.products),

                                    // data.selectDashBoardTab(
                                    //     DashBoardItemSelect.latestTrends),
                                    child: Text("Latest Trends",
                                        style:
                                            Theme.of(context).textTheme.button),
                                  ),
                                  TextButton(
                                    onPressed: () => data.selectDashBoardTab(
                                        DashBoardItemSelect.forecasting),
                                    child: Text("Forecasting",
                                        style:
                                            Theme.of(context).textTheme.button),
                                  ),
                                  // TextButton(
                                  //   onPressed: () => data.selectDashBoardTab(
                                  //       DashBoardItemSelect.products),
                                  //   child: Text("Prodcuts",
                                  //       style:
                                  //           Theme.of(context).textTheme.button),
                                  // ),
                                  TextButton(
                                    onPressed: () => data.selectDashBoardTab(
                                        DashBoardItemSelect.mAna),
                                    child: Text("Daily Analytics",
                                        style:
                                            Theme.of(context).textTheme.button),
                                  ),
                                  TextButton(
                                    onPressed: () => data.selectDashBoardTab(
                                        DashBoardItemSelect.frauds),
                                    child: Text("Frauds",
                                        style:
                                            Theme.of(context).textTheme.button),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                    Row(
                      children: [
                        // IconButtonApp(
                        //   callback: () => data.selectTab(TabSelect.table),
                        //   icons: CupertinoIcons.settings,
                        //   color: CupertinoColors.white,
                        // ),
                        data.mixed.isNotEmpty
                            ? Row(
                                children: [
                                  data.load
                                      ? const CupertinoActivityIndicator()
                                      : IconButtonApp(
                                          callback: () async {
                                            data.loadBegin();
                                            await Future.wait([
                                              Provider.of<FraudLogic>(context,
                                                      listen: false)
                                                  .getFraudData(),
                                              Provider.of<MostFamousLogic>(
                                                      context,
                                                      listen: false)
                                                  .getMostFamousItemsData(),
                                              Provider.of<MostFamousLogic>(
                                                      context,
                                                      listen: false)
                                                  .getTop10CatName(),
                                              Provider.of<MonthAnaLogic>(
                                                      context,
                                                      listen: false)
                                                  .getDailyAna(),
                                              Provider.of<ForecastLogic>(
                                                      context,
                                                      listen: false)
                                                  .getForecast(),
                                            ]);

                                            data.loadstop();
                                          },
                                          icons: CupertinoIcons.refresh,
                                          color: CupertinoColors.white,
                                        ),
                                  IconButtonApp(
                                    callback: () => data.showRightBar(),
                                    icons: CupertinoIcons.eye,
                                    color: data.showData
                                        ? CupertinoColors.systemPurple
                                        : const Color.fromARGB(255, 70, 70, 70),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        );
      },
    );
  }
}

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BarLogic>(
      builder: (context, data, _) {
        return data.showData
            ? Container(
                color: CupertinoColors.darkBackgroundGray,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: ScrollController(),
                          itemCount:
                              data.mixed.isEmpty ? 1 : data.mixed.length + 2,
                          itemBuilder: (context, index) {
                            return index == 0
                                ? Text("Numeric Data",
                                    style:
                                        Theme.of(context).textTheme.headline5)
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Draggable<String>(
                                      data: data.numeric[index - 1].toString(),
                                      feedback: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade900,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor:
                                                    CupertinoColors.activeBlue,
                                                radius: 3,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(data.numeric[index - 1],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2)
                                            ],
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade900,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor:
                                                    CupertinoColors.activeGreen,
                                                radius: 3,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(data.numeric[index - 1],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      const Divider(color: CupertinoColors.white),
                      Expanded(
                        child: ListView.builder(
                          controller: ScrollController(),
                          itemCount: data.mixed.length + 1,
                          itemBuilder: (context, index) {
                            return index == 0
                                ? Text("Category Data",
                                    style:
                                        Theme.of(context).textTheme.headline5)
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Draggable(
                                      data: data.mixed[index - 1].toString(),
                                      feedback: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange.shade900,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const CircleAvatar(
                                                  backgroundColor:
                                                      CupertinoColors
                                                          .activeBlue,
                                                  radius: 4,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(data.mixed[index - 1],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2)
                                              ],
                                            ),
                                          )),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade900,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: CupertinoColors
                                                    .activeOrange,
                                                radius: 4,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(data.mixed[index - 1],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

class LeftSideBar extends StatelessWidget {
  const LeftSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SideBarWidgets> menu = [
      SideBarWidgets(
        name: "DashBoard",
        icon: CupertinoIcons.app,
        selectTab: TabSelect.dashboard,
      ),
      SideBarWidgets(
        name: "Table",
        icon: CupertinoIcons.table,
        selectTab: TabSelect.table,
      ),
      SideBarWidgets(
        name: "Graph",
        icon: CupertinoIcons.graph_square,
        selectTab: TabSelect.graph,
      ),
      SideBarWidgets(
          name: "Playground",
          icon: CupertinoIcons.play,
          selectTab: TabSelect.trends),
      SideBarWidgets(
        name: "Connect",
        icon: CupertinoIcons.folder,
        selectTab: TabSelect.connect,
      ),
    ];
    return Consumer<BarLogic>(builder: (context, data, _) {
      return data.leftBar
          ? Container(
              color: CupertinoColors.darkBackgroundGray,
              width: MediaQuery.of(context).size.width * 0.15,
              child: ListView.builder(
                  itemCount: menu.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8),
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        color: data.selectedTab == menu[i].selectTab
                            ? Colors.blue.shade900
                            : Colors.black,
                        onPressed: () => menu[i].selectTab == TabSelect.connect
                            ? alertMessage(context)
                            : data.selectTab(menu[i].selectTab),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                menu[i].icon,
                                size: MediaQuery.of(context).size.height * 0.03,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                menu[i].name,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          : const SizedBox.shrink();
    });
  }
}

class SideBarWidgets {
  final String name;
  final IconData icon;
  final TabSelect selectTab;

  SideBarWidgets(
      {required this.name, required this.icon, required this.selectTab});
}
