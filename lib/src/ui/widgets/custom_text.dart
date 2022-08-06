import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final int? maxLine;
  final TextOverflow? textOverflow;

  const CustomText(
      {super.key,
      required this.text,
      this.fontWeight = FontWeight.normal,
      this.fontSize,
      this.maxLine,
      this.color,
      this.textOverflow});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Text(
      text,
      maxLines: maxLine,
      overflow: textOverflow,
      style: GoogleFonts.quicksand(
        fontSize: fontSize ?? responsive.dp(1.5),
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color,
      ),
    );
  }
}
