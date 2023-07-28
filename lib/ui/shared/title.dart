import 'package:flutter/material.dart';

class ConsTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry margin;
  final Color color;

  const ConsTitle({Key? key, required this.text, required this.margin, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: color,
          )),
    );
  }
}
