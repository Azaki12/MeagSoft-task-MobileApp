import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import 'package:test_app/app/modules/home/controllers/home_controller.dart';
import '../core/utils/constants.dart';

class CustomDrawerTile extends GetView<HomeController> {
  final String? title;
  final String? icon;
  final String? path;
  const CustomDrawerTile({Key? key, this.icon, this.path, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Get.theme.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          controller.isDrawerOpened.value = false;
          controller.animationController.reverse();
          Get.toNamed(path!);
        },
        title: title!.body(color: Get.theme.primaryColor, center: false),
        leading: SvgPicture.asset('${Constants.iconsPath}$icon.svg'),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Get.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
