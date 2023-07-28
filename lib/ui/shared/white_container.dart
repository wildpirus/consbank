import 'package:flutter/material.dart';

class WhiteContainer extends StatelessWidget {
  final Widget child;
  final double? height;

  const WhiteContainer({Key? key, required this.child, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
            color: const Color(0xffFBFBFB),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(80)),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withOpacity(0.3), offset: const Offset(10, 0), blurRadius: 10)]),
        child: child);
  }
}
