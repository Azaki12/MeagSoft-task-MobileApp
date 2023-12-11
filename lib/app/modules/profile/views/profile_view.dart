import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_bg.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlobalAppBar(title: 'Profile'),
      body: GlobalBG(
        body: Obx(
          () => Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      foregroundColor: Colors.amber,
                      radius: 50,
                    ),
                    const SizedBox(height: 15),
                    '${controller.profileData.value.name}'.subtitle(weight: FontWeight.bold),
                    '${controller.profileData.value.email}'.body(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
