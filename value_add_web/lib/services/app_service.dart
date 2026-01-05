import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'log_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract mixin class AppServiceObserver {
  /// App恢复前台
  void onAppResume() {}

  /// App进入后台
  void onAppPause() {}

  /// App信息更新后
  void onAppInfoUpdated() {}
}

final class AppService extends GetxService with WidgetsBindingObserver {
  static AppService get instance => Get.find();

  final List<AppServiceObserver> _observers = [];

  late final bool _isPhysicalDevice;

  /// 是否物理设备
  bool get isPhysicalDevice => _isPhysicalDevice;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxBool isNetworkAvailable = false.obs;
  bool _wasPreviouslyConnected = false;

  // 无通知权限时展示
  final RxBool showNotificationWithoutPermission = true.obs;

  // static final checkedPermissions = [Permission.location, Permission.camera, Permission.photos];

  // static final bluetoothPermissions = <Permission>[Permission.bluetooth];

  /// 获取权限状态
  // Map<Permission, PermissionStatus> get permissionStatus => _permissionStatus;
  // final Map<Permission, PermissionStatus> _permissionStatus = {};

  /// 获取Wifi名称，需要location权限
  String get ssid => _ssid;
  String _ssid = '';

  Future<AppService> init() async {
    await _updateDeviceInfo();
    await _update();
    await _checkConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    return this;
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    Get.closeCurrentSnackbar();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _updateLifecycleState(state);
  }

  void addObserver(AppServiceObserver observer) => _observers.add(observer);

  void removeObserver(AppServiceObserver observer) => _observers.remove(observer);


  /// 打开系统设置页


  Future<void> _updateLifecycleState(AppLifecycleState state) async {
    // Log.t('AppLifeCycle: $state');
    for (final observer in _observers) {
      if (state == AppLifecycleState.resumed) {
        observer.onAppResume();
      } else if (state == AppLifecycleState.paused) {
        observer.onAppPause();
      }
    }

    if (state == AppLifecycleState.paused) {
      Log.d('AppLifeCycle app paused...');
      // DeviceService.instance.sleepLowPowerDevice();
    }
    if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(seconds: 1), () async {
        await _checkConnectivity();
        await _update();
        for (final observer in _observers) {
          observer.onAppInfoUpdated();
        }
      });
    }
  }

  Future<void> _update() async {
    // await _updatePermissionStatus();
    await _updateWifiInfo();
  }

  Future<void> _updateDeviceInfo() async {

  }

  // Future<void> _updatePermissionStatus() async {
  //   for (final permission in checkedPermissions) {
  //     final status = await permission.status;
  //     _permissionStatus[permission] = status;
  //     // Log.t('${permission.toString()}, status: $status');
  //   }
  // }

  Future<void> _updateWifiInfo() async {
    final info = NetworkInfo();
    String ssid = await info.getWifiName() ?? '';
    if (ssid.startsWith('"')) {
      ssid = ssid.substring(1);
    }
    if (ssid.endsWith('"')) {
      ssid = ssid.substring(0, ssid.length - 1);
    }
    _ssid = ssid;
    // Log.t('Wi-Fi Name: $_ssid');
  }


  Future<void> _checkConnectivity() async {
    try {
      List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (e) {
      Log.d('检查网络连接失败: $e');
      _updateStatus(false);
    }
  }

  _updateStatus(bool result) {
    if (isNetworkAvailable.value != result) {
      isNetworkAvailable.value = result;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    bool currentlyConnected = results.any((result) => result != ConnectivityResult.none);

    if (isNetworkAvailable.value != currentlyConnected) {
      _updateStatus(currentlyConnected);

      if (!currentlyConnected) {
        Log.e("No internet connection available.");
        _wasPreviouslyConnected = false;
      } else if (!_wasPreviouslyConnected) {
        String message = "Active connections: ${results.map((r) => r.toString()).join(', ')}";
        Log.i(message);
        _wasPreviouslyConnected = true;
        Future.delayed(const Duration(seconds: 1), () async {
          await _update();
          for (final observer in _observers) {
            observer.onAppInfoUpdated();
          }
        });
      }
    }

    for (final observer in _observers) {
      observer.onAppInfoUpdated();
    }
  }

  Future<String> getPlatformState() async {

    return "25.10.30.21.30";
  }
}


