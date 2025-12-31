

import 'package:value_add_web/routes/value_add_routes.dart';

class Routes {
  Routes._();

  static const initial = ValueAddPaths.main;

  static final routes = [
    // 增值服务
    ValueAddRoutes.route(),
  ];
}
