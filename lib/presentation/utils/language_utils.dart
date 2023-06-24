import 'package:animations/animations.dart';
import 'package:pokemon_explorer/logic/cubit/app_config/app_config_cubit.dart';
import 'package:pokemon_explorer/presentation/widgets/common/language_utils.dart';
import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//   depends on [provider] , [animations]

import 'package:provider/provider.dart';

class LanguageUtils {
  LanguageUtils._();

  static Future<T?> showLangaugeModal<T>(
      {required BuildContext context,
      VoidCallback? englishCallback,
      VoidCallback? arabicCallback,
      Color? primaryColor,
      Color? accentColor,
      TextStyle? titleTextStyle,
      TextStyle? textStyle}) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => LanguageModal(
        titleTextStyle: titleTextStyle ?? Styles.label2,
        primaryColor: primaryColor ?? Colors.blue,
        accentColor: accentColor ?? Colors.white,
        style: textStyle ?? Styles.label3,
        englishCallback: englishCallback ??
            () {
              if (Localizations.localeOf(context).languageCode != 'en') {
                context.read<AppConfigCubit>().setLocale('en');

                Navigator.pop(context);
              }
            },
        arabicCallback: arabicCallback ??
            () {
              if (Localizations.localeOf(context).languageCode != 'ar') {
                context.read<AppConfigCubit>().setLocale('ar');
                Navigator.pop(context);
              }
            },
      ),
    );
  }

  static Future<T?> showLanguageDialog<T>(
      {required BuildContext context,
      VoidCallback? englishCallback,
      VoidCallback? arabicCallback,
      Color? primaryColor,
      Color? accentColor,
      TextStyle? titleTextStyle,
      TextStyle? textStyle}) {
    return showModal<T>(
      context: context,
      builder: (context) => LanguageAlertDialog(
        titleTextStyle: titleTextStyle ?? Styles.label2,
        primaryColor: primaryColor ?? Colors.blue,
        accentColor: accentColor ?? Colors.white,
        style: textStyle ?? Styles.label3,
        englishCallback: englishCallback ??
            () {
              if (Localizations.localeOf(context).languageCode != 'en') {
                context.read<AppConfigCubit>().setLocale('en');

                Navigator.pop(context);
              }
            },
        arabicCallback: arabicCallback ??
            () {
              if (Localizations.localeOf(context).languageCode != 'ar') {
                context.read<AppConfigCubit>().setLocale('ar');

                Navigator.pop(context);
              }
            },
      ),
    );
  }
}
