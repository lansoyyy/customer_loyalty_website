import 'package:flutter/material.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? fontSize;
  final double? height;
  final double? radius;
  final Color color;
  final Color? textColor;

  const ButtonWidget(
      {super.key,
      this.radius = 100,
      required this.label,
      this.textColor = Colors.white,
      required this.onPressed,
      this.width = 300,
      this.fontSize = 18,
      this.height = 60,
      this.color = bayanihanBlue});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)),
        minWidth: width,
        height: height,
        color: color,
        onPressed: onPressed,
        child: TextWidget(
          text: label,
          fontSize: fontSize!,
          color: textColor,
          fontFamily: 'Bold',
        ));
  }
}
