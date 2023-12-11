import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../core/utils/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_bg.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_fab.dart';
import 'content_home_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, widget) {
        return Obx(
          () => Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: GlobalAppBar(
              title: Constants.appName,
              isHome: true,
              height: controller.animation.value,
              isDrawerOpen: controller.isDrawerOpened.value,
              onDrawerOpen: () {
                if (controller.animation.value == kToolbarHeight) {
                  controller.animationController.forward().then((value) => controller.isDrawerOpened.value = true);
                } else {
                  controller.isDrawerOpened.value = false;
                  controller.animationController.reverse();
                }
              },
            ),
            body: const GlobalBG(body: ContentHomeView()),
            floatingActionButton: SpeedDial(
              children: [
                SpeedDialChild(
                  child: 'community'.icon(color: Colors.white),
                  label: 'Posts',
                  onTap: () => Get.toNamed(Routes.posts),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
