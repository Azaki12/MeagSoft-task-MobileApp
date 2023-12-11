import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../core/utils/constants.dart';

class CustomToggleBar extends StatelessWidget {
  final int? currentPage;
  final String? title1;
  final String? title2;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  const CustomToggleBar(
      {Key? key,
      this.currentPage,
      this.onTap1,
      this.onTap2,
      this.title1,
      this.title2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap1,
              borderRadius: BorderRadius.circular(8),
              child: AnimatedDefaultTextStyle(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentPage == 0
                      ? Get.theme.primaryColor
                      : Constants.lightGrey,
                  fontWeight:
                      currentPage == 0 ? FontWeight.bold : FontWeight.normal,
                  fontSize: currentPage == 0
                      ? Get.textTheme.bodyLarge!.fontSize
                      : Get.textTheme.bodySmall!.fontSize,
                ),
                duration: const Duration(milliseconds: 300),
                child: Text(title1!),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              height: 30,
              child: VerticalDivider(
                color: Get.theme.colorScheme.secondary,
                width: 2,
                thickness: 2,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onTap2,
              borderRadius: BorderRadius.circular(8),
              child: AnimatedDefaultTextStyle(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentPage == 1
                      ? Get.theme.primaryColor
                      : Constants.lightGrey,
                  fontWeight:
                      currentPage == 1 ? FontWeight.bold : FontWeight.normal,
                  fontSize: currentPage == 1
                      ? Get.textTheme.bodyLarge!.fontSize
                      : Get.textTheme.bodySmall!.fontSize,
                ),
                duration: const Duration(milliseconds: 300),
                child: Text(title2!),
              ),
            ),
          ),
        ],
      ).decorate(color: Colors.white, padding: 5, radius: 8),
    );
  }
}
