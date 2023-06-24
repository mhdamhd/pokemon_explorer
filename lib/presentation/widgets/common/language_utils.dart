import 'package:pokemon_explorer/presentation/widgets/common/common.dart';
import 'package:flutter/material.dart';

class LanguageAlertDialog extends StatelessWidget {
  final String? dialogTitle;

  final Color? primaryColor;
  final Color? accentColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final VoidCallback? englishCallback;
  final VoidCallback? arabicCallback;
  final TextStyle? style;
  final TextStyle? titleTextStyle;

  const LanguageAlertDialog(
      {Key? key,
      this.dialogTitle,
      this.primaryColor,
      this.accentColor,
      this.buttonWidth,
      this.buttonHeight,
      this.englishCallback,
      this.arabicCallback,
      this.titleTextStyle,
      required this.style})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        dialogTitle ??
            (Localizations.localeOf(context).languageCode == 'ar'
                ? 'اللغة'
                : 'Language'),
        style: titleTextStyle ?? Theme.of(context).textTheme.headline4,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LanguageButton(
                label: 'العربية',
                style: Localizations.localeOf(context).languageCode == 'ar'
                    ? style?.copyWith(color: accentColor) ??
                        Theme.of(context).textTheme.button
                    : style?.copyWith(color: primaryColor) ??
                        Theme.of(context).textTheme.button,
                color: Localizations.localeOf(context).languageCode == 'ar'
                    ? primaryColor
                    : accentColor,
                enableBorder:
                    Localizations.localeOf(context).languageCode != 'ar',
                borderColor: primaryColor,
                onTap: arabicCallback ?? () {},
              ),
              LanguageButton(
                label: 'English',
                style: Localizations.localeOf(context).languageCode == 'en'
                    ? style?.copyWith(color: accentColor) ??
                        Theme.of(context).textTheme.button
                    : style?.copyWith(color: primaryColor) ??
                        Theme.of(context).textTheme.button,
                color: Localizations.localeOf(context).languageCode == 'en'
                    ? primaryColor
                    : accentColor,
                enableBorder:
                    Localizations.localeOf(context).languageCode != 'en',
                borderColor: primaryColor,
                onTap: englishCallback ?? () {},
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class LanguageModal extends StatelessWidget {
  final String? dialogTitle;

  final Color? primaryColor;
  final Color? accentColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final VoidCallback? englishCallback;
  final VoidCallback? arabicCallback;
  final TextStyle? style;
  final TextStyle? titleTextStyle;

  const LanguageModal(
      {Key? key,
      this.dialogTitle,
      this.primaryColor,
      this.accentColor,
      this.buttonWidth,
      this.buttonHeight,
      this.englishCallback,
      this.arabicCallback,
      this.titleTextStyle,
      @required this.style})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedModalBottomSheet(
      radius: 15,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            dialogTitle ??
                (Localizations.localeOf(context).languageCode == 'ar'
                    ? 'الرجاء اختيار لغتك'
                    : 'Select your language please'),
            style: titleTextStyle ?? Theme.of(context).textTheme.headline4,
          ),
          const Divider(
            color: Colors.grey,
            height: 40,
            endIndent: 50,
            indent: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 20,
              ),
              LanguageButton(
                label: 'العربية',
                style: Localizations.localeOf(context).languageCode == 'ar'
                    ? style?.copyWith(color: accentColor) ??
                        Theme.of(context).textTheme.button
                    : style?.copyWith(color: primaryColor) ??
                        Theme.of(context).textTheme.button,
                color: Localizations.localeOf(context).languageCode == 'ar'
                    ? primaryColor
                    : accentColor,
                enableBorder:
                    Localizations.localeOf(context).languageCode != 'ar',
                borderColor: primaryColor,
                onTap: arabicCallback ?? () {},
              ),
              const SizedBox(),
              LanguageButton(
                label: 'English',
                style: Localizations.localeOf(context).languageCode == 'en'
                    ? style?.copyWith(color: accentColor) ??
                        Theme.of(context).textTheme.button
                    : style?.copyWith(color: primaryColor) ??
                        Theme.of(context).textTheme.button,
                color: Localizations.localeOf(context).languageCode == 'en'
                    ? primaryColor
                    : accentColor,
                enableBorder:
                    Localizations.localeOf(context).languageCode != 'en',
                borderColor: primaryColor,
                onTap: englishCallback ?? () {},
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final double? width;
  final String? label;
  final VoidCallback? onTap;
  final Color? color;

  final Color? borderColor;
  final bool? enableBorder;
  final TextStyle? style;

  const LanguageButton(
      {Key? key,
      this.width,
      this.label,
      this.onTap,
      this.color,
      this.borderColor,
      this.enableBorder,
      this.style})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          shape: enableBorder!
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: borderColor ?? Colors.white),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
          elevation: 4,
        ),
        child: Text(
          label ?? '',
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
