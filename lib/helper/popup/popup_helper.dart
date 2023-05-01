import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/enums/alert_type.dart';
import '../device_screen_info/device_screen_info.dart';
import '../navigation/navigation_helper.dart';

class AppAlert {
  static Future show({
    required AppAlertType type,
    Widget? child,
    String? message,
    Function? onSuccess,
    Function? onClose,
    String? okText,
    String? cancelText,
    String? title,
    bool? useWithOutMargin,
    Color? okTextColor,
    Color? cancelTextColor,
    String? buttonText,
  }) async {
    if (child == null && message == null) throw ("Please set child or message");
    await showDialog(
      context: NavigationHelper.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AppAlertContainer(
              type: type,
              child: child,
              buttonText: buttonText,
              message: message,
              onSuccess: onSuccess,
              onClose: onClose,
              okText: okText,
              cancelText: cancelText,
              title: title,
              useWithOutMargin: useWithOutMargin,
              okTextColor: okTextColor,
              cancelTextColor: cancelTextColor,
            ),
          ],
        );
      },
    );
  }
}

class _AppAlertContainer extends StatelessWidget {
  final AppAlertType type;
  final Widget? child;
  final String? message;
  final Function? onSuccess;
  final Function? onClose;
  final String? okText;
  final String? cancelText;
  final String? title;
  final bool? useWithOutMargin;
  final Color? okTextColor;
  final Color? cancelTextColor;
  final String? buttonText;

  _AppAlertContainer(
      {required this.type,
      this.child,
      this.message,
      this.onSuccess,
      this.onClose,
      this.okText,
      this.cancelText,
      this.title,
      this.useWithOutMargin,
      this.okTextColor,
      this.cancelTextColor,
      this.buttonText});

  void onSuccessClicked() {
    Navigator.of(NavigationHelper.navigatorKey.currentContext!).pop();
    if (onSuccess != null) onSuccess!();
  }

  void onCloseClicked() {
    Navigator.of(NavigationHelper.navigatorKey.currentContext!).pop();
    if (onClose != null) onClose!();
  }

  Widget get _title {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DeviceInfo.width(4)),
      child: Text(
        title ?? "",
        style: TextStyle(
          color: AppColors.kprimaryColor,
          fontSize: 16,
          letterSpacing: -0.6,
        ),
      ),
    );
  }

  Widget _button({
    required String text,
    Function()? onTap,
    Color? color = AppColors.kprimaryColor,
    double radiusLeft = 15,
    double radiusRight = 15,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: double.infinity,
        color: Colors.white.withOpacity(0),
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: DeviceInfo.height(2),
          bottom: DeviceInfo.height(2),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16,
            letterSpacing: -0.6,
          ),
        ),
      ),
    );
  }

  Widget get _closeFooter => _button(
      text: buttonText == null ? 'Kapat' : buttonText!, onTap: onCloseClicked);

  Widget get _questionButtons {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: AppColors.ligthGrey, width: 1))),
            child: _button(
              text: this.cancelText ?? 'Kapat',
              color: cancelTextColor,
              onTap: onCloseClicked,
              radiusRight: 0,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: AppColors.ligthGrey, width: 1))),
            child: _button(
              text: this.okText ?? 'Tamam',
              onTap: onSuccessClicked,
              color: okTextColor ?? Colors.red,
              radiusLeft: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _content {
    if (child != null) return child!;
    return Text(
      message!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.kprimaryColor,
        fontSize: 14,
        letterSpacing: -0.4,
      ),
    );
  }

  Widget get _footer {
    if (type == AppAlertType.success) return _closeFooter;
    if (type == AppAlertType.info) return _closeFooter;
    if (type == AppAlertType.question) return _questionButtons;
    return _closeFooter;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
        margin: EdgeInsets.only(top: DeviceInfo.height(2)),
        width: DeviceInfo.width(84),
        child: Column(
          children: [
            _title,
            useWithOutMargin == false || useWithOutMargin == null
                ? Container(height: DeviceInfo.height(2.45))
                : const SizedBox(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      useWithOutMargin == true || useWithOutMargin == null
                          ? DeviceInfo.width(3)
                          : DeviceInfo.width(5)),
              child: _content,
            ),
            Container(height: DeviceInfo.height(2.45)),
            Container(height: 1, color: AppColors.ligthGrey),
            _footer,
          ],
        ),
      ),
    );
  }
}
