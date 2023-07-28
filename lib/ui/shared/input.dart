import 'package:consbank/styles/styles.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? label;
  final bool obscure;
  final bool outline;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;
  final TextStyle? fontStyle;

  const Input(
      {Key? key,
      this.label,
      required this.controller,
      this.type = TextInputType.text,
      this.obscure = false,
      this.outline = false,
      this.validator,
      this.padding,
      this.fontStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: padding ?? const EdgeInsets.only(top: 3, left: 20, bottom: 3, right: 20),
        decoration: getBoxDecorator() as Decoration?,
        child: TextFormField(
          autocorrect: false,
          keyboardType: type,
          obscureText: obscure,
          controller: controller,
          style: TextStyle(letterSpacing: obscure ? 3.5 : .8),
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              labelText: label,
              labelStyle: fontStyle ??
                  TextStyle(fontSize: 21, fontWeight: FontWeight.bold, letterSpacing: .8, color: ConsbankColors.primaryLigth)),
          validator: validator,
        ));
  }

  getBoxDecorator() {
    return !outline

        // without outline
        ? BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(15)), boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(3, 2),
              blurRadius: 5,
              spreadRadius: 0.5,
            )
          ])

        // with outline
        : BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          );
  }
}
