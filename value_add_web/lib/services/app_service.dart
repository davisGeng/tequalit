import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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

  static final checkedPermissions = [Permission.location, Permission.camera, Permission.photos];

  static final bluetoothPermissions = <Permission>[Permission.bluetooth];

  /// 获取权限状态
  Map<Permission, PermissionStatus> get permissionStatus => _permissionStatus;
  final Map<Permission, PermissionStatus> _permissionStatus = {};

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

  /// 请求系统权限
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }

  /// 打开系统设置页
  Future<void> openAppSettings(AppSettingsType type) async {
    return await AppSettings.openAppSettings(type: type);
  }

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
      DeviceService.instance.sleepLowPowerDevice();
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
    await _updatePermissionStatus();
    await _updateWifiInfo();
  }

  Future<void> _updateDeviceInfo() async {
    final plugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      _isPhysicalDevice = info.isPhysicalDevice;
    } else if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      _isPhysicalDevice = info.isPhysicalDevice;
      if (info.version.sdkInt > 30) {
        Log.i('Android device sdkInt: ${info.version.sdkInt}');
        bluetoothPermissions.addAll([
          Permission.bluetoothScan,
          Permission.bluetoothAdvertise,
          Permission.bluetoothConnect,
        ]);
        checkedPermissions.addAll(bluetoothPermissions);
      }
    } else {
      _isPhysicalDevice = false;
    }
  }

  Future<void> _updatePermissionStatus() async {
    for (final permission in checkedPermissions) {
      final status = await permission.status;
      _permissionStatus[permission] = status;
      // Log.t('${permission.toString()}, status: $status');
    }
  }

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

  // Future<void> initConnectivity() async {
  //   List<ConnectivityResult> results;
  //   try {
  //     results = await _connectivity.checkConnectivity();
  //     _updateConnectionStatus(results);
  //   } on PlatformException catch (e) {
  //     Log.e('Couldn\'t check connectivity status: $e');
  //   }
  // }
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
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return "$version + 25.10.30.21.30";
  }
}

extension AppServiceNavigate on AppService {
  Future<void> _waitForRefreshingDone() async {
    while (!Get.isRegistered<DeviceListController>()) {
      Log.d("Notification > wait device controller .");
      await Future.delayed(const Duration(milliseconds: 50));
    }

    final controller = Get.find<DeviceListController>();
    if (!controller.hasRefreshed) {
      Log.d("Notification > wait on refersh .");
      await controller.refreshDevices();
    }
    await controller.waitForRefreshingDone();
  }

  Future<void> navigateDoorbell(NotificationMessage notificationMessage) async {
    String? thirdPartDeviceId = notificationMessage.thirdPartDeviceId;
    String? messageId = notificationMessage.messageId;
    Log.d("Notification to doorbell thirdPartDeviceId=$thirdPartDeviceId, messageId=$messageId .");
    if (thirdPartDeviceId != null && messageId != null) {
      Log.d("Notification > waiting for device refresh .");
      await _waitForRefreshingDone();
      var device = DeviceService.instance.getDeviceByThirdPartDeviceId(thirdPartDeviceId);
      if (device == null) {
        Log.e("Notification > device not found .");
        return;
      }

      Log.e("Notification > go to doorbell page .");
      Get.toNamed(
        DeviceListPaths.doorbell,
        arguments: {ArgumentsConstants.deviceId: device.deviceId, ArgumentsConstants.messageId: messageId},
      );
    }
  }

  Future<void> navigateEvent(NotificationMessage notificationMessage) async {
    await _waitForRefreshingDone();

    if (Get.context == null) {
      Log.w("Notification > application is not running, cache it.");
      return;
    }

    String? deviceId = notificationMessage.deviceId;
    String? thirdPartDeviceId = notificationMessage.thirdPartDeviceId;

    Device? device;
    if (deviceId != null) {
      Log.d("Notification > get device by id:$deviceId.");
      device = DeviceService.instance.getDeviceByDeviceId(deviceId);
    } else if (thirdPartDeviceId != null) {
      Log.d("Notification > get device by thirdPartDeviceId:$thirdPartDeviceId.");
      device = DeviceService.instance.getDeviceByThirdPartDeviceId(thirdPartDeviceId);
    }

    if (device == null) {
      Log.e("Notification > device not found.");
      return;
    }

    Log.d("Notification > ${Get.currentRoute} .");
    if (Get.currentRoute != MainTabsPaths.main) {
      Log.d("Notification > close all routes until main.");
      Get.until((route) => Get.currentRoute == MainTabsPaths.main);
    }

    if (!Get.isRegistered<EventListController>()) {
      Log.e("Notification > event list controller not found.");
      return;
    }

    Log.d("Notification > jump to event page .");
    var selectedDateTime = DateTime.fromMillisecondsSinceEpoch(notificationMessage.timestamp);
    Get.find<EventListController>().updateOptionDevice(
      device,
      selectedDateTime: selectedDateTime,
      loadData: true,
      tagetEventTime: notificationMessage.timestamp,
    );
    Get.find<MainTabsController>().onTapBottomNavigationBar(1);
  }
}
