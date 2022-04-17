import 'package:flutter/material.dart';
import 'package:hbapp/widget/text_default.dart';

class LatestTrends extends StatelessWidget {
  const LatestTrends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradinentTextGive(
        text: "Latest Trends",
        colors: [Color(0xffDA44bb), Color(0xff8921aa)],
      ),
    );
  }
}
