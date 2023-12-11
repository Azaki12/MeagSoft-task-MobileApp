import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/enums/enums.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_drawer_tile.dart';
import '../../../widgets/global_btn.dart';
import '../controllers/home_controller.dart';

class DrawerView extends GetView<HomeController> {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight),
        const CustomDrawerTile(
          title: 'Bookmarks',
          icon: 'star-stroke',
          path: Routes.bookmarks,
        ),
        const CustomDrawerTile(
          title: 'Your Profile',
          icon: 'your-profile',
          path: Routes.profile,
        ),
        const CustomDrawerTile(
          title: 'Settings',
          icon: 'settings',
          path: Routes.settings,
        ),
        const CustomDrawerTile(
          title: 'Stats',
          icon: 'settings',
          path: Routes.stats,
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: GlobalButton(
            onTap: () {
              controller.appServices.removeUserData();
              Get.offAllNamed(Routes.login);
            },
            type: GlobalBtnType.withIcon,
            text: 'Logout',
            icon: 'logout',
            width: Get.width,
            height: 55,
            color: Get.theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
