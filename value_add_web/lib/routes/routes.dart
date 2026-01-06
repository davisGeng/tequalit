import '../value_add/value_add_routes.dart';

class Routes {
  Routes._();

  static String initial = ValueAddPaths.main;

  static final routes = [
    // 增值服务
    ValueAddRoutes.route(),
  ];
}
