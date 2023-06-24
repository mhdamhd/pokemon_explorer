part of app_res;

class Styles {
  Styles._();

  static const String _fontFamily = "Inter";

  static TextStyle get label1 => const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.white);

  static TextStyle get label2 => const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white);

  static TextStyle get label3 => const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white);

  static TextStyle get errorStyle => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        color: Colors.red,
      );
}
