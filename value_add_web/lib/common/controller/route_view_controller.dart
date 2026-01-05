import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../assets/app_theme.dart';

abstract class RouteViewObserver extends NavigatorObserver {
  static NavigatorObserver get observer => _observer;
  static final _observer = _RouteViewObserver<ModalRoute>();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    //_pushUpdateNavigationBarColor(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    //_popUpdateNavigationBarColor(route, previousRoute);
  }

  void _popUpdateNavigationBarColor(Route route, Route? previousRoute) {
    if (_isDarkStyleRoute(previousRoute)) {
      darkNavigationBarStyle();
      return;
    }

    defaultNavigationBarStyle();
  }

  static void defaultNavigationBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme.current.colors.bottomNavigationBarBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  static void darkNavigationBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,

    ));
  }

  bool _isDarkStyleRoute(Route? route) {
    return true;
    // return (route?.settings.name == RealTimeVideoPaths.main ||
    //     route?.settings.name == PlayBackVideoPaths.main ||
    //     route?.settings.name == EventListPaths.detail);
  }

  void _pushUpdateNavigationBarColor(Route route, Route? previousRoute) {
    if (_isDarkStyleRoute(route)) {
      darkNavigationBarStyle();
      return;
    }

    if (_isDarkStyleRoute(previousRoute) && (route.settings.name?.isEmpty ?? true)) {
      return;
    }

    defaultNavigationBarStyle();
    resetOrientation();
  }

  //重置竖屏方向
  void resetOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}

abstract class RouteViewController extends GetxController {
  bool _isAppear = false;
  bool get isAppear => _isAppear;

  /// RouteView展示
  @mustCallSuper
  void onAppear(bool isFirstAppear) {
    _isAppear = true;
  }

  /// RouteView隐藏
  /// isLastDisAppear: 是否最后一次隐藏（销毁）
  /// isHidden: 标记是否被完全遮挡
  @mustCallSuper
  void onDisAppear(bool isLastDisAppear, bool isHidden) {
    _isAppear = false;
  }
}

typedef RouteViewOnAppear = void Function(bool isFirstAppear);
typedef RouteViewOnDisAppear = void Function(bool isLastDisAppear, bool isHidden);

/// 此Widget用于监听Route页面的`onAppear`和`onDisAppear`时机
final class RouteView extends StatefulWidget {
  final Widget child;

  final RouteViewOnAppear? onAppear;
  final RouteViewOnDisAppear? onDisAppear;
  final RouteViewController? controller;

  const RouteView({Key? key, required this.child, this.onAppear, this.onDisAppear, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RouteViewState();
  }
}

abstract mixin class _ViewVisibility {
  void onAppear(bool isFirstAppear);

  void onDisAppear(bool isLastDisAppear, bool isHidden);
}

final class _RouteViewState extends State<RouteView> with _ViewVisibility {
  RouteViewController? get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route == null) {
      return;
    }
    RouteViewObserver._observer.subscribe(this, route);
  }

  @override
  void dispose() {
    super.dispose();
    RouteViewObserver._observer.unsubscribe(this);
  }

  @override
  void onAppear(bool isFirstAppear) {
    final onAppear = widget.onAppear;
    if (onAppear != null) {
      onAppear(isFirstAppear);
    }
    final controller = widget.controller;
    if (controller != null) {
      controller.onAppear(isFirstAppear);
    }
  }

  @override
  void onDisAppear(bool isLastDisAppear, bool isHidden) {
    final onDisAppear = widget.onDisAppear;
    if (onDisAppear != null) {
      onDisAppear(isLastDisAppear, isHidden);
    }
    final controller = widget.controller;
    if (controller != null) {
      controller.onDisAppear(isLastDisAppear, isHidden);
    }
  }
}

final class _RouteViewObserver<R extends Route<dynamic>> extends RouteViewObserver {
  final Map<R, Set<_ViewVisibility>> _listeners = {};

  void subscribe(_ViewVisibility visibility, R route) {
    if (_listeners.containsKey(route)) {
      return;
    }
    final Set<_ViewVisibility> subscribers = _listeners.putIfAbsent(route, () => <_ViewVisibility>{});
    if (subscribers.add(visibility)) {
      // 首次onAppear
      visibility.onAppear(true);
    }
  }

  void unsubscribe(_ViewVisibility visibility) {
    final List<R> routes = _listeners.keys.toList();
    for (final R route in routes) {
      final Set<_ViewVisibility>? subscribers = _listeners[route];
      if (subscribers != null) {
        subscribers.remove(visibility);
        if (subscribers.isEmpty) {
          _listeners.remove(route);
        }
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is R && previousRoute is R) {
      final List<_ViewVisibility>? previousSubscribers = _listeners[previousRoute]?.toList();

      if (previousSubscribers != null) {
        for (final visibility in previousSubscribers) {
          // 非首次onAppear
          visibility.onAppear(false);
        }
      }

      final List<_ViewVisibility>? subscribers = _listeners[route]?.toList();

      if (subscribers != null) {
        for (final visibility in subscribers) {
          // 最后一次onDisAppear
          visibility.onDisAppear(true, true);
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is R && previousRoute is R) {
      final Set<_ViewVisibility>? previousSubscribers = _listeners[previousRoute];
      final isHidden = _isPage(route);
      if (previousSubscribers != null) {
        for (final visibility in previousSubscribers) {
          visibility.onDisAppear(false, isHidden);
        }
      }
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is R && oldRoute is R) {
      final Set<_ViewVisibility>? previousSubscribers = _listeners[oldRoute];
      if (previousSubscribers != null) {
        for (final visibility in previousSubscribers) {
          visibility.onDisAppear(true, true);
        }
      }
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route is R && previousRoute is R) {
      final Set<_ViewVisibility>? subscribers = _listeners[route];
      if (subscribers != null) {
        for (final visibility in subscribers) {
          visibility.onDisAppear(true, true);
        }
      }

      final Set<_ViewVisibility>? previousSubscribers = _listeners[previousRoute];
      if (previousSubscribers != null) {
        for (final visibility in previousSubscribers) {
          visibility.onAppear(false);
        }
      }
    }
  }

  bool _isPage(Route route) {
    return route is GetPageRoute;
  }

  // bool _isDialog(Route route) {
  //   return route is GetDialogRoute;
  // }
  //
  // bool _isBottomSheet(Route route) {
  //   return route is GetModalBottomSheetRoute;
  // }
}
