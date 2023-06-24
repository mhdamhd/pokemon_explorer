import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon_explorer/presentation/utils/helpers.dart';
import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/material.dart';

class ButtonErrorWidget extends StatelessWidget {
  final String? message;
  final String? iconPath;
  final TextStyle? textStyle;
  final TextStyle? buttonTextStyle;
  final VoidCallback? onPressed;
  final bool? enableButton;

  const ButtonErrorWidget({
    super.key,
    this.message,
    this.iconPath,
    this.textStyle,
    required this.onPressed,
    this.buttonTextStyle,
    this.enableButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.error),
          SizedBox(
            height: 45.h,
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              message ??
                  (Helpers.isRTL(context)
                      ? 'حدث خطأ ما ، يرجى إعادة المحاولة لاحقاً'
                      : 'An error occured, please try again later'),
              style: textStyle ??
                  Styles.label2.copyWith(
                    color: AppColors.primaryColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          if (enableButton!)
            TextButton(
              onPressed: onPressed ?? () {},
              child: Text(
                Helpers.isRTL(context) ? 'إعادة المحاولة' : "Try Again",
                style: Styles.label3.copyWith(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
    );
  }
}

class LabelErrorWidget extends StatelessWidget {
  final String? message;
  final String? iconPath;
  final TextStyle? textStyle;

  const LabelErrorWidget({
    super.key,
    this.message,
    this.iconPath,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.error),
          SizedBox(
            height: 45.h,
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              message ??
                  (Helpers.isRTL(context)
                      ? 'حدث خطأ ما ، يرجى إعادة المحاولة لاحقاً'
                      : 'An error occured, please try again later'),
              style: textStyle ??
                  Styles.label2.copyWith(
                    color: AppColors.primaryColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
