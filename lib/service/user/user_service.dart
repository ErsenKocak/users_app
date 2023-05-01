import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../core/enums/http_urls.dart';
import '../../core/init/locator.dart';
import '../../model/user/user.dart';

class UserService {
  final _logger = getIt<Logger>();
  final _dio = getIt<Dio>();

  Future<List<User>?> getUserList() async {
    try {
      var response = await _dio.get(HttpClientApiUrl.users.uri);

      if (response.data != null && response.statusCode == HttpStatus.ok) {
        return (response.data as List).map((e) => User.fromJson(e)).toList();
      } else {
        return null;
      }
    } on DioError catch (error) {
      _logger.e('UserService -- getUserList --  ERROR -- ${error}');

      rethrow;
    }
  }
}
