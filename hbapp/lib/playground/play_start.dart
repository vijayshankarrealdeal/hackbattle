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
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 200,
                        child: Stack(
                          children: [
                            DragTarget<String>(
                              onAccept: (val) => data.accept1(val),
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
                                      : const SizedBox(
                                          height: 40,
                                          width: 200,
                                        ),
                                );
                              },
                              onWillAccept: (value) {
                                return true;
                              },
                            ),
                            Center(
                              child: Text(
                                data.first,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 25),
                      SizedBox(
                        height: 45,
                        width: 200,
                        child: Stack(
                          children: [
                            DragTarget<String>(
                              onAccept: (val) => data.accept2(val),
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
                                      : const SizedBox(
                                          height: 40,
                                          width: 200,
                                        ),
                                );
                              },
                              onWillAccept: (value) {
                                return true;
                              },
                            ),
                            Center(
                              child: Text(
                                data.second,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  data.load
                      ? const CupertinoActivityIndicator()
                      : CupertinoButton(
                          color: Colors.indigo.shade900,
                          child: Text("Genrate",
                              style: Theme.of(context).textTheme.button),
                          onPressed: () => data.myQuery(),
                        )
                ],
              ),
              Expanded(
                child: data.realation.isEmpty
                    ? const SizedBox.shrink()
                    : MyHomePage(
                        data: data.realation,
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
