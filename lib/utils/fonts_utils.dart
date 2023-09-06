part of 'utils.dart';

class FontsUtils {
  static TextStyle poppins(
          {FontWeight? fontWeight, Color? color, double? fontSize}) =>
      GoogleFonts.poppins(
        fontSize: fontSize,
        color: color ?? ColorsUtils.textColor,
        fontWeight: fontWeight,
      );
}
