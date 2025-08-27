import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UIHelper {
  static text(
    String text, {
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      text,
      style: GoogleFonts.mooli(
        fontStyle: fontStyle,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  static image(
    String url, {
    Color? color,
    BoxFit fit = BoxFit.contain,
    double? height,
    double? width,
    bool isAsset = true,
    bool isLottie  =false,
  }) {
    return isAsset
        ? SvgPicture.asset(
          url,
          // ignore: deprecated_member_use
          color: color,
          fit: fit,
          height: height,
          width: width,
          errorBuilder:
              (context, error, stackTrace) => Icon(Icons.error, size: 50),
        )
        : Image.network(
          url,
          // ignore: deprecated_member_use
          color: color,
          fit: fit,
          height: height,
          width: width,
          errorBuilder:
              (context, error, stackTrace) =>
                  Center(child: Icon(Icons.error_outline, size: 50)),
        );
  }

  static button(VoidCallback onPressed, String text) {
    return TextButton(
      onPressed: onPressed,
      child: UIHelper.text(text, fontSize: 20, fontWeight: FontWeight.w700),
    );
  }
}
