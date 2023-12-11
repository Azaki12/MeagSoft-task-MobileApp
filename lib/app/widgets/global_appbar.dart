import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/constants.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import 'package:test_app/app/modules/home/views/drawer_view.dart';
import 'package:test_app/app/routes/app_pages.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isHome;
  final bool isPosts;
  final bool isProfile;
  final bool isDrawerOpen;
  final VoidCallback? onDrawerOpen;
  final double? height;
  const GlobalAppBar({Key? key, required this.title, this.isHome = false, this.isPosts = false, this.isProfile = false, this.height = kToolbarHeight, this.isDrawerOpen = false, this.onDrawerOpen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: AppBar(
          elevation: 4,
          shadowColor: Get.theme.shadowColor,
          title: title.subtitle(weight: FontWeight.bold),
          centerTitle: true,
          leading: (isHome)
              ? IconButton(
                  onPressed: () => Get.toNamed(Routes.notifications),
                  icon: (Get.isDarkMode) ? SvgPicture.asset('${Constants.iconsPath}notifications-dark.svg') : SvgPicture.asset('${Constants.iconsPath}notifications.svg'),
                )
              : IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Get.theme.colorScheme.secondary,
                ),
          actions: <Widget>[
            if (isHome)
              IconButton(
                onPressed: onDrawerOpen,
                icon: (height == kToolbarHeight)
                    ? (Get.isDarkMode)
                        ? SvgPicture.asset('${Constants.iconsPath}drawer-dark.svg')
                        : SvgPicture.asset('${Constants.iconsPath}drawer.svg')
                    : (Get.isDarkMode)
                        ? SvgPicture.asset('${Constants.iconsPath}drawer-close-dark.svg')
                        : SvgPicture.asset('${Constants.iconsPath}drawer-close.svg'),
              ),
            if (isProfile)
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('${Constants.iconsPath}edit.svg'),
              ),
          ],
          flexibleSpace: (isDrawerOpen)
              ? const SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  physics: BouncingScrollPhysics(),
                  child: DrawerView(),
                )
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height!);
}
