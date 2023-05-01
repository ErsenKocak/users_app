import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../helper/device_screen_info/device_screen_info.dart';
import '../../constants/colors.dart';

class SearchBarWidget extends StatelessWidget {
  final String searchText;
  final String? hintText;
  final bool? autoFocus;

  final Color? backgroundColor;
  final Color? buttonColor;
  final Color? searchIconColor;
  final bool isSearchActive;
  final bool? isSearchHomeScreen;
  final Function(String text) onChanged;
  final Function(String text) onSubmitted;
  final Function onTap;
  final Function onPressButton;
  final TextEditingController? controller;
  double? height;
  bool? isSecondarySearcBar;
  Color? borderColor;
  Color? inActiveBorderColor;
  FocusNode? focusNode;

  SearchBarWidget({
    required this.searchText,
    required this.isSearchActive,
    required this.onChanged,
    required this.onSubmitted,
    required this.onTap,
    required this.onPressButton,
    this.hintText,
    this.isSecondarySearcBar = false,
    this.searchIconColor,
    this.backgroundColor,
    this.buttonColor,
    this.autoFocus,
    this.controller,
    this.isSearchHomeScreen = false,
    this.height = 7.5,
    this.borderColor = AppColors.kprimaryColorLight,
    this.inActiveBorderColor,
    this.focusNode,
  });

  Widget get _searchbar {
    return Container(
      height: DeviceInfo.height(height!),
      width: DeviceInfo.width(92),
      // padding: EdgeInsets.only(right: DeviceInfo.width(2)),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: isSearchActive
              ? borderColor!
              : inActiveBorderColor ?? AppColors.kprimaryColorDark,
          width: 1,
        ),
        color: backgroundColor ?? Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              // margin: EdgeInsets.only(left: DeviceInfo.width(2)),

              child: TextField(
                textInputAction: TextInputAction.search,
                onChanged: (text) => onChanged(text),
                controller: controller ?? TextEditingController(),
                onTap: () => onTap(),
                focusNode: focusNode,
                onSubmitted: (text) {
                  log('onSubmitted $text');

                  onSubmitted(text);
                  // WidgetsBinding.instance
                  //     .addPostFrameCallback((_) => controller?.clear());
                },
                // autofocus: autoFocus != null ? autoFocus! : false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    hintText:
                        hintText != null ? '${hintText}' : 'Kullanıcı ara',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                    )),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: DeviceInfo.height(0.5),
                top: DeviceInfo.height(0.5),
                right: DeviceInfo.height(isSecondarySearcBar! ? 0.9 : 0.5)),
            child: GestureDetector(
              onTap: () => onPressButton(),
              child: Container(
                height: DeviceInfo.width(isSecondarySearcBar! ? 10 : 12),
                width: DeviceInfo.width(isSecondarySearcBar! ? 10 : 12),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(
                    DeviceInfo.width(isSecondarySearcBar! ? 2 : 3.6)),
                child: Icon(
                  isSearchActive ? Icons.cancel_outlined : Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _searchbar;
  }
}
