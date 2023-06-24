import 'package:pokemon_explorer/generated/l10n.dart';

class TextInputValidator {
  final int maxLength;
  final int minLength;
  List<InputValidator> validators;

  TextInputValidator(
      {required this.validators, this.maxLength = 20, this.minLength = 8});

  String? validate(String? input) {
    if (input != null) {
      String trimmedInput = input.trim();
      if (validators.contains(InputValidator.requiredField)) {
        if (trimmedInput.isEmpty) {
          return S.current.requiredField;
        }
      }
      if (validators.contains(InputValidator.email)) {
        if (!RegExp(r'^[A-Z0-9._%+-]+@[A-Z0-9._]+\.[A-Z]{2,4}$',
                caseSensitive: false)
            .hasMatch(trimmedInput)) {
          return S.current.emailIsNotValid;
        }
      }
      if (validators.contains(InputValidator.minLength)) {
        if (trimmedInput.length < minLength) {
          return S.current.minLengthValidator(minLength);
        }
      }
      if (validators.contains(InputValidator.maxLength)) {
        if (trimmedInput.length > maxLength) {
          return S.current.minLengthValidator(maxLength);
        }
      }
      if (validators.contains(InputValidator.mobile)) {
        if (RegExp(r'^09[0-9]{8}$').hasMatch(trimmedInput)) {
          return S.current.mobileIsNotValid;
        }
      }
    }

    return null;
  }

  static String? validateDropDown(int? value) {
    if (value == -1) {
      return S.current.requiredField;
    }
    return null;
  }

  static String? validateDropDownString(String? value) {
    if (value == '') {
      return S.current.requiredField;
    }
    return null;
  }
}

enum InputValidator { email, requiredField, minLength, maxLength, mobile }
