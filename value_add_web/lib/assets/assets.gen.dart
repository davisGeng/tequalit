/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/icon_basic_button_arrow_blue.png
  AssetGenImage get iconBasicButtonArrowBlue =>
      const AssetGenImage('assets/images/icon_basic_button_arrow_blue.png');

  /// File path: assets/images/icon_basic_button_arrow_disabled.png
  AssetGenImage get iconBasicButtonArrowDisabled =>
      const AssetGenImage('assets/images/icon_basic_button_arrow_disabled.png');

  /// File path: assets/images/icon_basic_button_arrow_red.png
  AssetGenImage get iconBasicButtonArrowRed =>
      const AssetGenImage('assets/images/icon_basic_button_arrow_red.png');

  /// File path: assets/images/icon_check_box_selected.png
  AssetGenImage get iconCheckBoxSelected =>
      const AssetGenImage('assets/images/icon_check_box_selected.png');

  /// File path: assets/images/icon_check_box_unselected.png
  AssetGenImage get iconCheckBoxUnselected =>
      const AssetGenImage('assets/images/icon_check_box_unselected.png');

  /// File path: assets/images/icon_checkbox_single_selected.png
  AssetGenImage get iconCheckboxSingleSelected =>
      const AssetGenImage('assets/images/icon_checkbox_single_selected.png');

  /// File path: assets/images/icon_service_4g.png
  AssetGenImage get iconService4g =>
      const AssetGenImage('assets/images/icon_service_4g.png');

  /// File path: assets/images/icon_service_ai.png
  AssetGenImage get iconServiceAi =>
      const AssetGenImage('assets/images/icon_service_ai.png');

  /// File path: assets/images/icon_service_cloud.png
  AssetGenImage get iconServiceCloud =>
      const AssetGenImage('assets/images/icon_service_cloud.png');

  /// File path: assets/images/icon_service_cloud_banner.png
  AssetGenImage get iconServiceCloudBanner =>
      const AssetGenImage('assets/images/icon_service_cloud_banner.png');

  /// File path: assets/images/icon_service_cloud_box_selected.png
  AssetGenImage get iconServiceCloudBoxSelected =>
      const AssetGenImage('assets/images/icon_service_cloud_box_selected.png');

  /// File path: assets/images/icon_service_cloud_effect.png
  AssetGenImage get iconServiceCloudEffect =>
      const AssetGenImage('assets/images/icon_service_cloud_effect.png');

  /// File path: assets/images/icon_service_credit_card.png
  AssetGenImage get iconServiceCreditCard =>
      const AssetGenImage('assets/images/icon_service_credit_card.png');

  /// File path: assets/images/icon_service_data4g_banner.png
  AssetGenImage get iconServiceData4gBanner =>
      const AssetGenImage('assets/images/icon_service_data4g_banner.png');

  /// File path: assets/images/icon_service_effect.png
  AssetGenImage get iconServiceEffect =>
      const AssetGenImage('assets/images/icon_service_effect.png');

  /// File path: assets/images/icon_service_paypal.png
  AssetGenImage get iconServicePaypal =>
      const AssetGenImage('assets/images/icon_service_paypal.png');

  /// File path: assets/images/icon_service_right_arrow.png
  AssetGenImage get iconServiceRightArrow =>
      const AssetGenImage('assets/images/icon_service_right_arrow.png');

  /// File path: assets/images/img_default.png
  AssetGenImage get imgDefault =>
      const AssetGenImage('assets/images/img_default.png');

  /// File path: assets/images/img_device_connect_empty.png
  AssetGenImage get imgDeviceConnectEmpty =>
      const AssetGenImage('assets/images/img_device_connect_empty.png');

  /// File path: assets/images/img_device_connect_error.png
  AssetGenImage get imgDeviceConnectError =>
      const AssetGenImage('assets/images/img_device_connect_error.png');

  /// File path: assets/images/img_no_device.png
  AssetGenImage get imgNoDevice =>
      const AssetGenImage('assets/images/img_no_device.png');

  /// File path: assets/images/success.png
  AssetGenImage get success => const AssetGenImage('assets/images/success.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        iconBasicButtonArrowBlue,
        iconBasicButtonArrowDisabled,
        iconBasicButtonArrowRed,
        iconCheckBoxSelected,
        iconCheckBoxUnselected,
        iconCheckboxSingleSelected,
        iconService4g,
        iconServiceAi,
        iconServiceCloud,
        iconServiceCloudBanner,
        iconServiceCloudBoxSelected,
        iconServiceCloudEffect,
        iconServiceCreditCard,
        iconServiceData4gBanner,
        iconServiceEffect,
        iconServicePaypal,
        iconServiceRightArrow,
        imgDefault,
        imgDeviceConnectEmpty,
        imgDeviceConnectError,
        imgNoDevice,
        success
      ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
