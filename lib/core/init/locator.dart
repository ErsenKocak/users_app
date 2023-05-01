import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../service/user/user_image_service.dart';
import '../../service/user/user_service.dart';
import '../constants/app_constants.dart';
import '../constants/theme.dart';

final getIt = GetIt.instance;

Future setupLocator() async {
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(
        baseUrl: BASE_URL,
        contentType: 'application/json',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60))),
  );
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<AppTheme>(AppTheme());

  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<UserImageService>(UserImageService());
}
