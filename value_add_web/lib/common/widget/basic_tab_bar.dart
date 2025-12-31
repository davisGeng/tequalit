import 'package:flutter/material.dart';

import '../../assets/app_theme.dart';

class BasicTabBar extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabs;
  final Function(int) onTabChanged;

  const BasicTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.transparent,
      child: TabBar(
        controller: controller,
        tabs: tabs,
        onTap: onTabChanged,
        labelStyle: TextStyle(color: AppTheme.current.colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            TextStyle(color: AppTheme.current.colors.gray1, fontSize: 16, fontWeight: FontWeight.w400),
        indicatorColor: AppTheme.current.colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        dividerHeight: 0,
      ),
    );
  }
}
