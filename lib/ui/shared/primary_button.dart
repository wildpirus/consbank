import 'package:flutter/material.dart';
import 'package:consbank/styles/styles.dart';

import 'label.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final Function()? callback;
  final double textSize;
  final EdgeInsets? padding;
  final Color? color;
  final bool outline;
  final double width;
  final bool loading;
  final String? message;

  const PrimaryButton(
      {Key? key,
      required this.text,
      required this.callback,
      this.outline = false,
      this.textSize = 16,
      this.padding,
      this.color,
      this.width = double.infinity,
      this.message,
      this.loading = false})
      : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  );

  @override
  Widget build(BuildContext context) {
    return (!widget.outline ? nornalButton(context) : outlineButton(context)) as Widget;
  }

  @override
  void dispose() {
    try {
      _controller.dispose();
    } catch (_) {}
    super.dispose();
  }

  nornalButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: widget.color,
        backgroundColor: widget.loading ? widget.color?.withOpacity(.5) ?? widget.color : widget.color,
        elevation: 1,
        disabledForegroundColor: Colors.black.withOpacity(0.38),
        disabledBackgroundColor: Colors.black.withOpacity(0.12),
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 15),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onPressed: () => {if (!widget.loading && widget.callback != null) widget.callback!()},
      child: SizedBox(
        width: widget.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !widget.loading
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: RotationTransition(
                      turns: _animation,
                      child: const Icon(Icons.refresh_rounded, size: 20, color: Colors.white),
                    ),
                  ),
            Label(
              text: widget.text,
              align: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: widget.textSize,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  outlineButton(BuildContext context) {
    return TextButton(
      onPressed: widget.loading ? null : widget.callback,
      style: TextButton.styleFrom(
        textStyle: TextStyle(color: ConsbankColors.accent),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: widget.color ?? ConsbankColors.accent, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
      ),
      child: Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 15),
        width: widget.width,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !widget.loading
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: RotationTransition(
                          turns: _animation,
                          child: Icon(Icons.refresh_rounded, size: 20, color: widget.color ?? Colors.black),
                        ),
                      ),
                Label(
                  text: widget.text,
                  align: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.color ?? Colors.black,
                        fontSize: widget.textSize,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            if (widget.message != null)
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: ConsbankColors.accentBackground,
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(50), left: Radius.circular(50)),
                  ),
                  child: Text(
                    widget.message!,
                    style: TextStyle(color: ConsbankColors.accent),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
