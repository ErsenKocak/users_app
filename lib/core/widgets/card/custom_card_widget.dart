import 'package:flutter/material.dart';
import 'package:users_app/core/constants/extensions/sized_box/sized_box_extension.dart';
import 'package:users_app/helper/device_screen_info/device_screen_info.dart';

class CustomCardWidget extends StatelessWidget {
  List<Widget>? cardHeader;
  List<Widget>? cardBody;
  List<Widget>? cardFooter;
  Function()? onTap;
  double? paddingValue;
  CustomCardWidget(
      {Key? key,
      this.cardHeader,
      this.cardBody,
      this.cardFooter,
      this.onTap,
      this.paddingValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(paddingValue ?? 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              cardHeader != null
                  ? Column(
                      children: [
                        Row(
                          children: cardHeader!,
                        ),
                        DeviceInfo.height(1).sbxh
                      ],
                    )
                  : const SizedBox(),
              cardBody != null
                  ? Row(
                      children: cardBody!,
                    )
                  : const SizedBox(),
              cardFooter != null
                  ? Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: cardFooter!,
                        ))
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
