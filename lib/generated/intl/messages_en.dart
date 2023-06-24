// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) => "must be at most ${count}";

  static String m1(count) => "must be at least ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "anErrorOccured":
            MessageLookupByLibrary.simpleMessage("An error occured"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "emailIsNotValid":
            MessageLookupByLibrary.simpleMessage("Email is not valid"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "maxLengthValidator": m0,
        "minLengthValidator": m1,
        "mobileIsNotValid":
            MessageLookupByLibrary.simpleMessage("Mobile is not valid"),
        "noInternetConnection":
            MessageLookupByLibrary.simpleMessage("No Internet"),
        "requiredField": MessageLookupByLibrary.simpleMessage("required !"),
        "sessionExpired":
            MessageLookupByLibrary.simpleMessage("Session expired")
      };
}
