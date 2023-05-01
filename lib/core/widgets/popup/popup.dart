import 'package:flutter/material.dart';

import '../../../helper/popup/popup_helper.dart';
import '../../enums/alert_type.dart';

class AppPopup {
  static handleOnPress(Function()? onPress) {
    if (onPress == null) return;
    onPress();
  }

  static showSuccess(String message, {Function()? onPress}) async {
    await AppAlert.show(
      type: AppAlertType.success,
      message: message,
      onClose: onPress,
    );
  }

  static showQuestion(String message,
      {Function()? onPress, String? okText, String? cancelText}) async {
    await AppAlert.show(
      type: AppAlertType.question,
      message: message,
      onSuccess: onPress,
      okText: okText,
      cancelText: cancelText,
    );
  }

  static showQuestionWithChild(
    String message, {
    Function()? onPress,
    String? title,
    String? okText,
    Color? okTextColor,
    Color? cancelTextColor,
    String? cancelText,
    Widget? child,
  }) async {
    await AppAlert.show(
      type: AppAlertType.question,
      message: message,
      child: child,
      title: title,
      onSuccess: onPress,
      okText: okText,
      okTextColor: okTextColor,
      cancelTextColor: cancelTextColor,
      cancelText: cancelText,
    );
  }

  static showInfo(
      {String? message,
      Widget? child,
      Function()? onPress,
      String? buttonText,
      String? title,
      bool? isUseWitOutMargin}) async {
    await AppAlert.show(
        type: AppAlertType.info,
        message: message,
        onClose: onPress,
        child: child,
        buttonText: buttonText,
        title: title,
        useWithOutMargin: isUseWitOutMargin ?? false);
  }

  static showError(String message, {Function()? onPress}) async {
    await AppAlert.show(
      type: AppAlertType.error,
      message: message,
      onClose: onPress,
    );
  }
}
