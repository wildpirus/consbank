import 'package:flutter/material.dart';

class ConsbankColors {
  static Color primary = const Color(0xff5528f0);
  static Color primaryLigth = const Color(0xff9882e2);
  static Color secondary = const Color(0xff075AB6);
  static Color accent = const Color(0xff14C5C7);
  static Color yellow = const Color(0xffFBCA2D);
  static Color purple = const Color(0xff7680FF);
  static Color red = const Color(0xffFC5B6D);
  static Color green = const Color(0xff22AB42);
  static Color ligthGreen = const Color(0xff16C36A);
  static Color orange = const Color(0xffFD7318);
  static Color orangeOpaciy = const Color(0xffffeadc);
  static Color whiteSecondary = const Color(0xffF9F9F9);
  static Color greyBackground = const Color(0xfff8f8f8);
  static Color accentBackground = const Color(0x1e14c5c7);
  static List<Color> arryAccentGrandient = [const Color(0xff14C5C7), const Color(0xff64C3BD)];

  static Color deparmentColor(int deparmentId) {
    switch (deparmentId) {
      case 1:
        return const Color(0xff84D24C);
      case 2:
        return const Color(0xffB14497);
      case 3:
        return const Color(0xff63428F);
      case 4:
        return const Color(0xff14C5C7);
      case 5:
        return const Color(0xff418FDE);
      case 6:
        return const Color(0xff418FDE);
      default:
        return Colors.white;
    }
  }
}
