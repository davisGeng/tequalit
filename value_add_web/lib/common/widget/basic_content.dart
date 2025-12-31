import 'package:flutter/material.dart';

final class BasicContent extends StatelessWidget {

  final EdgeInsetsGeometry padding;
  final Widget topChild;
  final Widget? bottomChild;

  const BasicContent({
    super.key,
    this.padding = const EdgeInsets.all(30),
    required this.topChild,
    this.bottomChild
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Expanded(child: topChild),
    ];
    final bottomChild = this.bottomChild;
    if (bottomChild != null) {
      children.add(bottomChild);
    }
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

}