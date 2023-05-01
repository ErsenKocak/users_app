import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  const CustomProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(
          color: AppColors.ksecondaryColor, strokeWidth: 2),
    ));
  }
}
