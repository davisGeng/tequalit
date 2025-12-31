import 'package:flutter/material.dart';

import '../../../assets/app_theme.dart';

final class BasicDialog extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;

  const BasicDialog({super.key, this.radius = 15, this.padding = const EdgeInsets.all(30), required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: SingleChildScrollView(child: _buildContainer())),
    );
  }

  Widget _buildContainer() {
    final r = Radius.circular(radius);
    return Container(
        decoration: BoxDecoration(color: AppTheme.current.colors.background, borderRadius: BorderRadius.all(r)),
        width: 308,
        padding: padding,
        child: child);
  }
}
