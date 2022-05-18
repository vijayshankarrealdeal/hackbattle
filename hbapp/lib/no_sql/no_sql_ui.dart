import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hbapp/main_controller.dart';
import 'package:hbapp/model/no_sql.dart';
import 'package:hbapp/no_sql/more_details.dart';
import 'package:hbapp/no_sql/nosql_logic.dart';
import 'package:provider/provider.dart';

class NoSqlUI extends StatelessWidget {
  const NoSqlUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<BarLogic>(builder: (context, _data, _) {
            return CupertinoButton(
                child: Text(
                  "Change to SQL",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () => _data.getDataTypes('s'));
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider<NoSqlLogic>(
          create: (ctx) => NoSqlLogic(),
          child: Consumer<NoSqlLogic>(builder: (context, _data, _) {
            return _data.load
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const  Icon(CupertinoIcons.arrow_up,
                              color: CupertinoColors.activeGreen),
                          Text(
                            _data.data.first.trending,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _data.data.first.data.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FutureProvider<
                                              List<SecondDataPage>>.value(
                                            initialData:const [],
                                            value: _data.secondNoSql(_data
                                                .data.first.data[index].id),
                                            child: Provider<Data>.value(
                                              value: _data.data.first.data[index],
                                              child: const NoSqlMoreDetail(),
                                            ),
                                          )),
                                );
                              },
                              leading: Text(
                                _data.data.first.data[index].name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              trailing: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      _data.data.first.data[index].pos
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: CupertinoColors.white),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(CupertinoIcons.arrow_up,
                                        color: Colors.green),
                                    const SizedBox(width: 15),
                                    Text(
                                      _data.data.first.data[index].neg
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: CupertinoColors.white),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(CupertinoIcons.arrow_down,
                                        color: Colors.red),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    ]),
                  );
          }),
        ),
      ),
    );
  }
}
