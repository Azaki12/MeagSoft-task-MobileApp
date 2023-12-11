import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../../app/core/utils/constants.dart';
import '../../../data/enums/enums.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/global_bg.dart';
import '../../../widgets/global_btn.dart';
import '../../../widgets/global_indicators.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalBG(
        body: Obx(
          () => Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Hero(
                      tag: 'appname',
                      child: Constants.appName.h2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (value) => controller.cindex.value = value,
                    itemCount: controller.length,
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('${Constants.illustrationsPath}onboarding1.svg'),
                        const SizedBox(height: 35),
                        'Testing the app'.tr.title(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
                          child: 'The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps.'.body(center: true),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GlobalIndicators(length: controller.length, cindex: controller.cindex.value),
                      const SizedBox(height: 40),
                      AnimatedCrossFade(
                        alignment: Alignment.center,
                        firstCurve: Curves.easeInOut,
                        secondCurve: Curves.easeInOut,
                        sizeCurve: Curves.easeInOut,
                        firstChild: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.lastPage();
                                },
                                child: 'skip'.tr.button(),
                              ),
                              GlobalButton(
                                onTap: () {
                                  controller.next();
                                },
                                type: GlobalBtnType.withIcon,
                                icon: 'back',
                                text: 'next'.tr,
                                width: Get.width * 0.3,
                                height: 55,
                              ),
                            ],
                          ),
                        ),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GlobalButton(
                            onTap: () => Get.offNamedUntil(Routes.login, (route) => false),
                            type: GlobalBtnType.withoutIcon,
                            text: 'get started'.tr,
                            height: 55,
                            width: Get.width * 0.7,
                          ),
                        ),
                        crossFadeState: controller.cindex.value == controller.length - 1 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
