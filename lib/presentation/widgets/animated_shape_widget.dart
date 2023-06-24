import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon_explorer/res/enums.dart';

class AnimatedShapeWidget extends StatefulWidget {
  final Shape initialShape;
  final double? width;
  final double? height;

  const AnimatedShapeWidget(
      {super.key, required this.initialShape, this.height, this.width});

  @override
  AnimatedShapeWidgetState createState() => AnimatedShapeWidgetState();
}

class AnimatedShapeWidgetState extends State<AnimatedShapeWidget> {
  late Shape _currentShape;

  @override
  void initState() {
    super.initState();
    _currentShape = widget.initialShape;
  }

  void changeShape(Shape shape) {
    setState(() {
      _currentShape = shape;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width ?? 200.r,
      height: widget.height ?? 200.r,
      decoration: _currentShape.decoration(widget.height ?? 200.r),
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
