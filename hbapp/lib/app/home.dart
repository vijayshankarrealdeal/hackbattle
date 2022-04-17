import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/api/gpt.dart';
import 'package:hbapp/app/bar/bar_ui.dart';
import 'package:hbapp/main_controller.dart';

import 'package:hbapp/table_ui.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const BarUpper(),
          Expanded(
            child: Row(
              children: [
                const LeftSideBar(),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.0),
                      child: ChangeNotifierProvider<GPT>(
                        create: (ctx) => GPT(),
                        child: Consumer<GPT>(builder: (context, dataGPT, _) {
                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CupertinoTheme(
                                        data: const CupertinoThemeData(
                                            brightness: Brightness.dark),
                                        child: CupertinoSearchTextField(
                                          placeholder: "Your Search",
                                          controller: dataGPT.controller,
                                        ),
                                      ),
                                    ),
                                    dataGPT.load
                                        ? const Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: CupertinoActivityIndicator(),
                                          )
                                        : CupertinoButton(
                                            child: Text(
                                              "Search",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button!
                                                  .copyWith(color: Colors.blue),
                                            ),
                                            onPressed: () => dataGPT.myQuery(),
                                          ),
                                  ],
                                ),
                              ),
                              Consumer<BarLogic>(builder: (context, data, _) {
                                if (data.numeric.isEmpty) {
                                  return Expanded(
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Trends+",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return data.selectedTab == TabSelect.table
                                    ? Expanded(
                                        child: dataGPT.dataFinal.isEmpty
                                            ? const SizedBox()
                                            : MyHomePage(
                                                data: dataGPT.dataFinal,
                                              ),
                                      )
                                    : data.selectedTab == TabSelect.graph
                                        ? Expanded(
                                            child: dataGPT.dataFinal.isEmpty
                                                ? const SizedBox()
                                                : data.giveGraph(
                                                    dataGPT.dataFinal, context),
                                          )
                                        : data.giveWidgets();
                              }),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                const SideBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
