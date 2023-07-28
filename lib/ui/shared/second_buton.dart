import 'package:flutter/material.dart';

import 'label.dart';

class SecondButton extends StatelessWidget {
  final Label label;
  final Function()? callback;
  final Color color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool outline;
  final double? outlineRadius;
  final Icon? icon;

  const SecondButton(
      {Key? key,
      required this.label,
      required this.callback,
      this.color = Colors.black,
      this.padding,
      this.margin,
      this.outline = false,
      this.outlineRadius,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: boxDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: callback != null ? () => Future.delayed(const Duration(milliseconds: 500), callback) : null,
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 7.5, vertical: 1.5),
            margin: margin ?? const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon == null
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: icon,
                      ),
                label
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration? get boxDecoration {
    return outline == false
        ? null
        : BoxDecoration(
            border: Border.all(color: callback == null ? Colors.grey : color, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(outlineRadius ?? 30)));
  }
}
