part of app_res;

class AppColors {
  AppColors._();
 // colors
  static Color primaryColor = const Color(0xFF63B2F2);
  static Color secondaryColor = const Color(0xFF0D47A1);
  static Color tertiaryColor = const Color(0xFFF26363);
  static Color accentColor = Colors.white;
  static Color redColor = const Color(0xFFE11E1E);

  // helpers

  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
