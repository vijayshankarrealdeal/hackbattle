import 'package:flutter/material.dart';

class IconButtonApp extends StatelessWidget {
  final Function callback;
  final IconData icons;
  final Color color;
  const IconButtonApp(
      {Key? key,
      required this.callback,
      required this.icons,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 10.0,
      padding: EdgeInsets.zero,
      onPressed: () => callback(),
      icon: Icon(
        icons,
        color: color,
        size: MediaQuery.of(context).size.height * 0.03,
      ),
    );
  }
}
