import 'package:flutter/material.dart';

class Input2 extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool obscure;
  final bool isRequired;
  final bool outline;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;
  final bool readOnly;
  final void Function(String)? onChanged;

  const Input2({
    Key? key,
    this.label,
    required this.controller,
    this.type = TextInputType.text,
    this.obscure = false,
    this.outline = false,
    this.validator,
    this.padding,
    this.isRequired = false,
    this.hint,
    this.readOnly = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                Text(
                  label!,
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
                if (isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
            decoration: getBoxDecorator() as Decoration?,
            child: TextFormField(
              readOnly: readOnly,
              autocorrect: false,
              keyboardType: type,
              obscureText: obscure,
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(letterSpacing: obscure ? 3.5 : .8),
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              validator: validator,
            )),
        if (hint != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              hint!,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        const SizedBox(height: 15)
      ],
    );
  }

  getBoxDecorator() {
    return !outline

        // without outline
        ? BoxDecoration(
            color: readOnly ? Colors.grey[400] : Colors.white,
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(3, 2),
                blurRadius: 5,
                spreadRadius: 0.5,
              )
            ],
          )

        // with outline
        : BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          );
  }
}
