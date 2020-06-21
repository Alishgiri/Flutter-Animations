import 'package:flutter/material.dart';
import 'package:flutter_animation/animations/shimmer/shimmer_paint.dart';

class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration period;
  final Gradient gradient;
  Shimmer({
    Key key,
    this.child,
    this.gradient,
    this.period = const Duration(seconds: 1),
  }) : super(key: key);
  _Shimmer createState() => _Shimmer();
}

class _Shimmer extends State<Shimmer> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.period)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ShimmerPaint(
      child: widget.child,
      gradient: widget.gradient,
      percent: controller.value,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
