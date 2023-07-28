import 'package:consbank/styles/styles.dart';
import 'package:flutter/material.dart';

final arryGrandient = [ConsbankColors.primaryLigth, ConsbankColors.primary];

final gradientPrimaryDecorator =
    BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.topRight, colors: arryGrandient));

final boxDecorator = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    boxShadow: <BoxShadow>[
      BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 1), blurRadius: 2, spreadRadius: 1)
    ]);
