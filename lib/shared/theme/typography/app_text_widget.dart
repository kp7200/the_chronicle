import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_text_type.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    required this.text,
    this.type = AppTextType.body,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.fontStyle,
    this.decoration,
  });

  final String text;
  final AppTextType type;

  // Optional overrides
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;

  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final baseStyle = _getBaseStyle(context);

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
      style: baseStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  TextStyle _getBaseStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (type) {
      case AppTextType.display:
        return textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700);
      case AppTextType.headline:
        return GoogleFonts.cinzel(
          textStyle: textTheme.headlineSmall,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        );
      case AppTextType.title:
        return textTheme.titleMedium!;
      case AppTextType.body:
        return textTheme.bodyMedium!;
      case AppTextType.label:
        return textTheme.labelLarge!;
      case AppTextType.caption:
        return textTheme.bodySmall!;
    }
  }
}
