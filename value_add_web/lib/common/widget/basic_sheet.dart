import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final class BasicSheet extends StatelessWidget {

  final Color backgroundColor;
  final double radius;
  final Widget child;
  const BasicSheet({
    super.key,
    this.backgroundColor = Colors.white,
    this.radius = 15,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final r = Radius.circular(radius);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(topLeft: r, topRight: r)
      ),
      child: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: child
        ),
      ),
    );
  }
}