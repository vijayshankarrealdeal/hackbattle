import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hbapp/main_controller.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BarLogic>(
      builder: (ctx, data, _) {
        return data.giveMyDashboard();
      },
    );
  }
}
