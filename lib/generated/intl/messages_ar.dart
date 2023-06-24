// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(count) => "على الأكثر ${count} يجب أن تكون";

  static String m1(count) => "على الأقل ${count} يجب أن تكون";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "anErrorOccured": MessageLookupByLibrary.simpleMessage("حدث خطأ ما"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "emailIsNotValid":
            MessageLookupByLibrary.simpleMessage("البريد الالكتروني غير صالح"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "language": MessageLookupByLibrary.simpleMessage("اللغة"),
        "maxLengthValidator": m0,
        "minLengthValidator": m1,
        "mobileIsNotValid":
            MessageLookupByLibrary.simpleMessage("رقم الموبايل غير صالح"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "تحقق من جودة الاتصال بالانترنت"),
        "requiredField":
            MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب !"),
        "sessionExpired":
            MessageLookupByLibrary.simpleMessage("انتهت صلاحية الجلسة")
      };
}
