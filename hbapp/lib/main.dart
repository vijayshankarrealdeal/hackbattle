import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hbapp/app/home.dart';
import 'package:hbapp/dashboard/forecasting/forecasting_logic.dart';
import 'package:hbapp/dashboard/fraud/fraud_logic.dart';
import 'package:hbapp/dashboard/monthly_ana/month_analysic_logic.dart';
import 'package:hbapp/dashboard/products/most_famous_logic.dart';
import 'package:hbapp/main_controller.dart';
import 'package:hbapp/no_sql/no_sql_ui.dart';
import 'package:hbapp/playground/playground_logic.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(const Size(1800, 1000));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FraudLogic>(create: (ctx) => FraudLogic()),
        ChangeNotifierProvider<BarLogic>(create: (ctx) => BarLogic()),
        ChangeNotifierProvider<MostFamousLogic>(
            create: (ctx) => MostFamousLogic()),
        ChangeNotifierProvider<MonthAnaLogic>(create: (ctx) => MonthAnaLogic()),
        ChangeNotifierProvider<ForecastLogic>(create: (ctx) => ForecastLogic()),
        ChangeNotifierProvider<PlaygroundLogic>(
            create: (ctx) => PlaygroundLogic()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            iconTheme: IconThemeData(
              color: CupertinoColors.activeBlue, //change your color here
            ),
            backgroundColor: CupertinoColors.darkBackgroundGray,
          ),
          iconTheme: const IconThemeData(color: CupertinoColors.white),
          scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
          brightness: Brightness.dark,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).primaryTextTheme.copyWith(),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<BarLogic>(builder: (context, _data, _) {
          if (_data.defaultX == ConnectionTypeX.sql) {
            return const HomePage();
          } else {
            return const NoSqlUI();
          }
        }),
      ),
    );
  }
}
