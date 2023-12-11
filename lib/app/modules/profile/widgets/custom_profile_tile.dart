import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';


import '../../../core/utils/constants.dart';
import '../../../widgets/simple_link.dart';

class CustomProfileTile extends StatelessWidget {
  final String? title;
  final String? icon;
  final String? subtitle;
  final String? linkText;
  final VoidCallback? onTap;

  const CustomProfileTile({
    Key? key,
    this.icon,
    this.subtitle,
    this.title,
    this.linkText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: icon!.icon(color: Get.theme.colorScheme.secondary),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title!.subtitle(weight: FontWeight.w500),
              subtitle!.caption,
            ],
          ),
        ),
        if (linkText != null)
          SimpleLink(
            text: linkText!.body(color: Constants.accentColor),
            onTap: onTap,
          ),
      ],
    ).decorate(color: Colors.white, padding: 15);
  }
}
