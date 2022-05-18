import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/playground/playground_logic.dart';
import 'package:hbapp/table_ui.dart';
import 'package:provider/provider.dart';

class PlayGroundMain extends StatelessWidget {
  const PlayGroundMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PlaygroundLogic>(
        builder: (context, data, _) {
          return Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: ListView.builder(
                  itemCount: data.widgetMore.length + 1,
                  itemBuilder: (ctx, index) {
                    return index == 0
                        ? CupertinoButton(
                            child: Text("Add new dimenssion",
                                style: Theme.of(context).textTheme.button),
                            onPressed: () => data.addMoreDim())
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Stack(
                              children: [
                                DragTarget<String>(
                                  onAccept: (val) =>
                                      data.accept(val, index - 1),
                                  builder: (context, candiates, rejects) {
                                    return Container(
                                      height: 45,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: candiates.isNotEmpty
                                            ? Colors.grey.shade900
                                            : Colors.pink.shade900,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: candiates.isEmpty
                                          ? Container()
                                          : const SizedBox(),
                                    );
                                  },
                                  onWillAccept: (value) {
                                    return true;
                                  },
                                ),
                                Positioned(
                                  top: 2,
                                  left: 2,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          splashRadius: 5,
                                          padding: EdgeInsets.zero,
                                          onPressed: () =>
                                              data.removeItem(index - 1),
                                          icon: const Icon(
                                            CupertinoIcons.clear_circled,
                                            size: 20,
                                          )),
                                      Text(
                                        data.widgetMore[index - 1].text.length <
                                                20
                                            ? data.widgetMore[index - 1].text
                                            : data.widgetMore[index - 1].text
                                                    .substring(0, 20) +
                                                '...',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: data.load
                            ? const CupertinoActivityIndicator()
                            : CupertinoButton(
                                color: Colors.indigo.shade900,
                                child: Text("Generate",
                                    style: Theme.of(context).textTheme.button),
                                onPressed: () => data.myQuery(),
                              ),
                      ),
                      Expanded(
                        child: data.realation.isEmpty
                            ? const SizedBox.shrink()
                            : MyHomePage(
                                data: data.realation,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
