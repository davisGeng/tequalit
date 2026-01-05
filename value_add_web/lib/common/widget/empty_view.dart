import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../assets/app_theme.dart';
import '../../assets/assets.gen.dart';
import 'basic_button.dart';

class EmptyView extends StatefulWidget {
  EdgeInsetsGeometry? padding;
  Image? topImage = Assets.images.imgNoDevice.image(width: 146, height: 132);
  bool? showBtn;
  bool? bottomBtn;
  bool? btnUseWidthDoubleInfinity; //按钮宽度是否自适应
  double? bottomBtnHorizontalPadding;
  double? bottomBtnTopPadding;
  Color? bottomParentBgColor;
  String? description;

  String? btnTitle;
  VoidCallback? onTap;
  EmptyView({
    this.topImage,
    this.showBtn = false,
    this.bottomBtn = false,
    this.btnUseWidthDoubleInfinity = false,
    this.bottomBtnHorizontalPadding = 24.0,
    this.bottomBtnTopPadding = 16,
    this.bottomParentBgColor = Colors.transparent,
    this.description = "",
    this.btnTitle,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 30),
  });

  @override
  State<EmptyView> createState() => _EmptyView();
}

final class _EmptyView extends State<EmptyView> {
  double bottomNavPadding = 18;
  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   updateBottomBtnNavPadding();
    // }
    super.initState();
  }

  // Future updateBottomBtnNavPadding() async {

  //   // bool isThree = await BottomNavigationDetector.isThreeButtonNavigationEnabled();

  //   // double temBottomNavPadding = await OtherUtils.getBottomNavPadding();
  //   setState(() {
  //     if (isThree) {
  //       bottomNavPadding = 16;
  //     } else {
  //       bottomNavPadding = 50;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // isClassicNavigation(context);
    return _buildEmptyView(context);
  }

  Widget _buildEmptyView(BuildContext context) {
    double btnHeight = BasicButtonStyle.black1.defaultHeight;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            padding: EdgeInsets.zero,

            color: Colors.transparent,
            alignment: widget.bottomBtn == true ? Alignment.topCenter : Alignment.center,
            child:
                widget.bottomBtn == true
                    ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            padding: widget.padding,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.topImage ?? Assets.images.imgNoDevice.image(width: 146, height: 132),
                                Text(
                                  widget.description ?? "",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: AppTheme.current.textStyles.bodyText1Gray,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (widget.showBtn == true)
                          Container(
                            padding: EdgeInsets.only(
                              left: widget.bottomBtnHorizontalPadding ?? 24,
                              right: widget.bottomBtnHorizontalPadding ?? 24,
                              top: widget.bottomBtnTopPadding ?? 16,
                              bottom: bottomNavPadding,
                            ),
                            decoration: BoxDecoration(color: widget.bottomParentBgColor),
                            child: BasicButton(
                              style: BasicButtonStyle.black1,
                              title: widget.btnTitle ?? '',
                              onPressed: widget.onTap,
                              useWidthDoubleInfinity: widget.btnUseWidthDoubleInfinity,
                              boxPadding:
                                  widget.btnUseWidthDoubleInfinity == true
                                      ? null
                                      : const EdgeInsets.only(left: 15, right: 15),
                              width: widget.btnUseWidthDoubleInfinity == true ? double.infinity : 126,
                            ),
                          ),
                        // .marginOnly(bottom: bottomBtnMargin ?? 0),
                      ],
                    )
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.topImage ?? Assets.images.imgNoDevice.image(width: 146, height: 132),
                        Text(
                          widget.description ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppTheme.current.textStyles.bodyText1Gray,
                        ).paddingOnly(bottom: 15, top: 0),
                        if (widget.showBtn == true)
                          BasicButton(
                            style: BasicButtonStyle.black1,
                            title: widget.btnTitle ?? '',
                            onPressed: widget.onTap,
                            useWidthDoubleInfinity: widget.btnUseWidthDoubleInfinity,
                            boxPadding:
                                widget.btnUseWidthDoubleInfinity == true
                                    ? null
                                    : const EdgeInsets.only(left: 15, right: 15),
                            width: widget.btnUseWidthDoubleInfinity == true ? double.infinity : 126,
                          ),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
