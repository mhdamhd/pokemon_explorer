import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final bool circular;
  final double horizontalMargin;
  final double verticalMargin;
  final bool isList;
  final bool isGrid;
  final int listNum;
  final bool horizontal;

  const ShimmerLoader(
      {Key? key,
      this.height = 120,
      this.width = 50,
      this.radius = 10,
      this.circular = false,
      this.horizontalMargin = 5,
      this.verticalMargin = 5,
      this.isList = false,
        this.isGrid = false,
      this.listNum = 4,
      this.horizontal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget shimmerElement = Shimmer.fromColors(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: verticalMargin),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: circular ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: circular ? null : BorderRadius.circular(radius)),
          height: height,
          width: width,
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100);
    if (isList) {
      return SizedBox(
        height: horizontal ? height : null,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
          children: List.generate(listNum, (index) => shimmerElement),
        ),
      );
    }
    return shimmerElement;
  }
}
