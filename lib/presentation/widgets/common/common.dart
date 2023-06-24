import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedModalBottomSheet extends StatelessWidget {
  final Widget? content;
  final double? radius;

  const RoundedModalBottomSheet({Key? key, this.content, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff737373),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius ?? 15),
            topLeft: Radius.circular(radius ?? 15),
          ),
        ),
        child: content ?? const SizedBox(),
      ),
    );
  }
}

class CenteredCircularProgressIndicator extends StatelessWidget {
  const CenteredCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
      ),
    );
  }
}

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? callback;
  final String label;
  final Color? color;

  const AppElevatedButton({
    required this.callback,
    required this.label,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.r),
          ),
        ),
        onPressed: callback,
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              label,
              style: Styles.label1.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyCard extends StatelessWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(60.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No Items to Display',
                style: Styles.label1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
