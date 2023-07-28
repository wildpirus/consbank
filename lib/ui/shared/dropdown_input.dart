import 'package:flutter/material.dart';

class DropdownInput extends StatelessWidget {
  final String? label;
  final List<String> items;
  final Object? value;
  final Function(Object?)? onChanged;
  final bool obscure;
  final bool isRequired;
  final bool outline;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;

  const DropdownInput({
    Key? key,
    this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.obscure = false,
    this.outline = false,
    this.validator,
    this.padding,
    this.isRequired = false,
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
            margin: const EdgeInsets.only(bottom: 15),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            decoration: getBoxDecorator() as Decoration?,
            child: DropdownButton(
              hint: const Text('Select Weight Goal'),
              items: dropdownItems,
              focusColor: const Color(0xFFD8F3DC),
              value: value,
              onChanged: onChanged,
              isExpanded: true,
              underline: const SizedBox(),
            ))
      ],
    );
  }

  get dropdownItems {
    return items.map((item) {
      return DropdownMenuItem<int>(
        value: items.indexOf(item),
        child: Text(item),
      );
    }).toList();
  }

  getBoxDecorator() {
    return !outline

        // without outline
        ? BoxDecoration(
            color: Colors.white,
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
