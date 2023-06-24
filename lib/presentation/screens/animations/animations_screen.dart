import 'package:pokemon_explorer/presentation/widgets/animated_shape_widget.dart';
import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon_explorer/res/enums.dart';

class AnimationsScreen extends StatelessWidget {
  static const String routeName = '/animations';
  final String name;

  AnimationsScreen({Key? key, required this.name}) : super(key: key);

  final shapeKey = GlobalKey<AnimatedShapeWidgetState>();
  List<Shape> shapes = [Shape.square, Shape.roundedSquare, Shape.circle];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animations',
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: 50.h),
            Text(
              name,
              style: Styles.label1.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 100.h),
            Center(
              child: AnimatedShapeWidget(
                  height: 1000.r,
                  width: 1000.r,
                  initialShape: Shape.square,
                  key: shapeKey),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: shapes
                  .map((shape) => GestureDetector(
                        onTap: () {
                          shapeKey.currentState?.changeShape(shape);
                        },
                        child: AnimatedShapeWidget(
                          initialShape: shape,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
