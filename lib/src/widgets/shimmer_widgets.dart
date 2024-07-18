import 'package:assignment/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidgets extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerWidgets({super.key, required this.height, required this.width, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: ColorConstants.white,
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final Widget child;
  final int count;
  final bool shrinkWrap;
  final bool? primary;
  final Axis? scrollDirection;

  const ShimmerList({
    super.key,
    required this.child,
    required this.count,
    this.shrinkWrap = false,
    this.primary,
    this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      primary: primary,
      scrollDirection: scrollDirection ?? Axis.vertical,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return child;
      },
      itemCount: count,
    );
  }
}
