import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SnackBarMessage {
  static const SUCCESS = 1;
  static const DANGER = 2;
  static const PRIMARY = 3;

  final int type;
  final double marginBottom;
  final String message;
  final Duration? duration;
  final dynamic exception;
  final StackTrace? stack;

  SnackBarMessage({required this.type, required this.message, this.duration, this.marginBottom = 10, this.exception, this.stack});

  show() async {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        margin: EdgeInsets.only(bottom: marginBottom, left: 7, right: 7),
        icon: Icon(
          iconContent,
          color: Colors.white,
        ),
        boxShadows: kElevationToShadow[8],
        colorText: Colors.white,
        backgroundGradient: RadialGradient(
          colors: colorTypeContent,
          center: Alignment.topLeft,
          radius: 2,
        ),
        forwardAnimationCurve: Curves.easeOutBack,
        duration: duration ?? const Duration(seconds: 4),
        isDismissible: true);
  }

  List<Color> get colorTypeContent {
    switch (type) {
      case SUCCESS:
        return [const Color(0xff57805E), const Color(0xffA5C585)];
      case DANGER:
        return [const Color(0xffB52857), const Color(0xffE13858)];
      case PRIMARY:
      default:
        return [const Color(0xff43C3EC), const Color(0xff60C0C6)];
    }
  }

  IconData get iconContent {
    switch (type) {
      case SUCCESS:
        return Icons.check_outlined;
      case DANGER:
        return Icons.close;
      case PRIMARY:
      default:
        return Icons.info_outline;
    }
  }

  String get title {
    switch (type) {
      case SUCCESS:
        return "Enhorabuena";
      case DANGER:
        return "Hay un problema";
      case PRIMARY:
      default:
        return "Información";
    }
  }
}
