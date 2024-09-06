import 'package:flutter/material.dart';

class AppColorManager {
  static const mainColor = Color(0xFF0F1827);
  static const secondColor =  Color(0xff04A2F6);
  static const mainColorDark = Color(0xFF090E17);
  static const mainColorLight = Color(0xFF223659);
  static const textColor = Color(0xFF132332);
  static const black = Color(0xFF000000);
  static const ampere = Color(0xFFFFC107);
  static const grey = Color(0xFF848484);
  static const lightGray = Color(0xFFFBFBFB);
  static const lightGrayAb = Color(0xFFABABAB);
  static const lightGrayEd = Color(0xFFEDEDED);
  static const offWhit = Color(0xFFD9D9D9);
  static const whit = Color(0xFFFFFFFF);
  static const red = Color(0xFFC60000);
  static const redPrice = Color(0xFF910202);
  static const cardColor = Color(0xFFF9F9FB);
  static const blue = Color(0xFF0D479E);
  static const c8f = Color(0xFF8F7752);
  static const tableHeader = Color(0x250F1827);

  static const dividerColor = Color(0xFFE2E8F0);
  static const f1 = Color(0xFFf1f1f1);
  static const f9 = Color(0xFFf9f9f9);
  static const f6 = Color(0xFFf6f6f6);
  static const f3 = Color(0xFFf3f3f3);
  static const e4 = Color(0xFF4E5053);
  static const ac = Color(0xFFACACAC);
  static const ee = Color(0xFFEEEEEE);
  static const d9 = Color(0xFFD9D9D9);

  static const fc = Color(0xFFFCFCFC);
  static const c50 = Color(0xFF505050);
  static const c6e = Color(0xFF6E6E6E);

  static const f8 = Color(0xFFF8F8F8);

  static const darkBlue = Color(0xFF1E3354);

  static const shadowColor = Color(0x191A1A43);

  static const borderColor =  Color(0x33919EAB);

  static const warning = Color(0xFFEAB308);

}

Color getColorFromHex(String hexColor) {
  String formattedHexColor =
      hexColor.replaceAll("#", ""); // Remove the '#' character if present
  if (formattedHexColor.length == 6) {
    formattedHexColor =
        "FF$formattedHexColor"; // Add the alpha value if it's missing
  }
  int colorValue =
      int.parse(formattedHexColor, radix: 16); // Parse the hex color string
  return Color(colorValue);
}

bool isColorDark(Color color) {
  final luminance =
      (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue) / 255;
  return luminance < 0.5;
}

Color getCheckColor(Color color) {
  if (isColorDark(color)) {
    return Colors.white;
  } else {
    return AppColorManager.grey;
  }
}
