import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

class SettingsTile extends StatelessWidget {
  final String? title;
  final String? icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  const SettingsTile({
    Key? key,
    this.title,
    this.icon,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Get.theme.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: onTap,
        title: title!.body(
            center: false,
            color: Get.theme.primaryColor,
            weight: FontWeight.w500),
        leading: icon!.icon(),
        trailing: trailing,
      ),
    );
  }
}
