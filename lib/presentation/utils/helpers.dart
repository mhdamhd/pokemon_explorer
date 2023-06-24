import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Helpers {
  Helpers._();
  static bool isRTL(BuildContext context) {
    return Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode);
  }

  static bool isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }
}
