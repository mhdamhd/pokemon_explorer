import 'package:flutter/material.dart';

class SlideUpRouteTransition extends PageRouteBuilder {
  final Widget page;

  SlideUpRouteTransition(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset(0, 0),
            ).animate(animation),
            child: child,
          ),
          transitionDuration: Duration(milliseconds: 300),
        );
}
