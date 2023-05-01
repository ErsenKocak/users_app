import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  var userAppTheme = ThemeData.light().copyWith(
      primaryColor: AppColors.kprimaryColor,
      appBarTheme: const AppBarTheme(color: AppColors.kprimaryColor),
      iconTheme: const IconThemeData(color: AppColors.kprimaryColor),
      textTheme: ThemeData.light().textTheme.apply(
            displayColor: AppColors.kprimaryColor,
          ),
      primaryTextTheme: ThemeData.light().textTheme.apply(),
      scaffoldBackgroundColor: AppColors.kscaffoldColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.kprimaryColor,
      ));
}
