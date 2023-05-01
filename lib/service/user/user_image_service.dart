import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:users_app/core/constants/app_constants.dart';
import 'package:users_app/model/user/user_image.dart';

import '../../core/enums/http_urls.dart';
import '../../core/init/locator.dart';
import '../../model/user/user.dart';

class UserImageService {
  final _logger = getIt<Logger>();

  Future<UserImage?> getUserImage({required int userId}) async {
    try {
      var response = await Dio()
          .get('${IMAGES_BASE_URL}$userId/${HttpClientApiUrl.userImage.uri}');

      if (response.data != null && response.statusCode == HttpStatus.ok) {
        return UserImage.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (error) {
      _logger.e('UserImageService -- getUserImage --  ERROR -- ${error}');

      rethrow;
    }
  }
}
