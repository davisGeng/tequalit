

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {

  static const AppTheme _current = AppTheme._();

  const AppTheme._();

  static AppTheme get current => _current;

  AppColors get colors => AppColors();

  TextStyles get textStyles => TextStyles();
}