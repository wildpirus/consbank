import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final EdgeInsets? margin;
  final TextStyle? style;
  final TextAlign align;
  final TextOverflow? overflow;
  final double? heigth;
  final bool softWrap;
  final bool useScrollBar;

  const Label({
    Key? key,
    required this.text,
    this.margin,
    this.align = TextAlign.left,
    this.softWrap = true,
    this.overflow,
    this.heigth,
    this.style,
    this.useScrollBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: heigth,
      child: useScrollBar
          ? Scrollbar(
              child: SingleChildScrollView(
                child: Text(
                  text,
                  softWrap: softWrap,
                  textAlign: align,
                  overflow: overflow,
                  maxLines: 5,
                  style: style,
                ),
              ),
            )
          : Text(
              text,
              softWrap: softWrap,
              textAlign: align,
              overflow: overflow,
              maxLines: 5,
              style: style,
            ),
    );
  }
}
