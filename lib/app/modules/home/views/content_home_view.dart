import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import 'package:test_app/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/core/utils/constants.dart';
import '../../../routes/app_pages.dart';

class ContentHomeView extends GetView<HomeController> {
  const ContentHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return controller.getAllNews();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    'Hello, ${controller.appServices.userName} '.title(),
                    SvgPicture.asset('${Constants.iconsPath}hand-emoji.svg'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Get.toNamed(Routes.createPost),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      'add-post'.icon(size: 30),
                      const SizedBox(width: 10),
                      'Add a new Post'.subtitle(weight: FontWeight.bold),
                    ],
                  ).decorate(color: Colors.white, padding: 40),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: Get.width,
                child: 'News :'.subtitle(weight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.7,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Obx(
                      () => (controller.isNewsLoading.value)
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                                child: Column(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: (controller.appServices.isDark.value) ? Colors.grey.shade800 : Colors.grey.shade100,
                                      highlightColor: (controller.appServices.isDark.value) ? Colors.grey.shade900 : Colors.grey.shade50,
                                      child: Container(
                                        height: constraints.maxHeight * 0.1,
                                        width: constraints.maxHeight * 0.65,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Shimmer.fromColors(
                                      baseColor: (controller.appServices.isDark.value) ? Colors.grey.shade800 : Colors.grey.shade100,
                                      highlightColor: (controller.appServices.isDark.value) ? Colors.grey.shade900 : Colors.grey.shade50,
                                      child: Container(
                                        width: constraints.maxHeight * 0.75,
                                        height: constraints.maxHeight * 0.05,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                for (int i = 0; i < controller.newsList!.articles!.length; i++) ...[
                                  ListTile(
                                    onTap: () async {
                                      if (!await launchUrl(Uri.parse(controller.newsList!.articles![i].url!))) {
                                        Get.snackbar('Error', 'Could not open link', backgroundColor: Colors.red);
                                      }
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    title: '${controller.newsList!.articles![i].author}'.body(weight: FontWeight.w600, color: Get.theme.primaryColor),
                                    subtitle: '${controller.newsList!.articles![i].title}'.body(weight: FontWeight.w600),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Get.theme.colorScheme.secondary,
                                    ),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: SvgPicture.asset('${Constants.iconsPath}noImage.svg'),
                                    ).decorate(radius: 100, width: 50, height: 50, color: Colors.white),
                                  ).decorate(color: Colors.white, padding: 10),
                                  const SizedBox(height: 8),
                                ],
                              ],
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
