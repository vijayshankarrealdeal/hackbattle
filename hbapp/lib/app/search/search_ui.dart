import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/api/gpt.dart';
import 'package:provider/provider.dart';

class SearchUI extends StatelessWidget {
  const SearchUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GPT>(
      create: (ctx) => GPT(),
      child: Consumer<GPT>(builder: (context, dataGPT, _) {
        return Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Expanded(
                child: CupertinoSearchTextField(
                  placeholder: "Your Search",
                  controller: dataGPT.controller,
                ),
              ),
              dataGPT.load
                  ? const Padding(
                      padding: EdgeInsets.all(18.0),
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
                    )
            ],
          ),
        );
      }),
    );
  }
}
