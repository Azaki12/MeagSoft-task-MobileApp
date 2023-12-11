import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../core/utils/constants.dart';
import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_bg.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_tile.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Settings'),
      body: GlobalBG(
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 12),
            child: Column(
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: 'General Settings'.subtitle(weight: FontWeight.bold),
                ),
                //*----------------------------  Notifications Tile  ---------------------------*/
                SettingsTile(
                  title: 'Notifications',
                  icon: 'bill',
                  trailing: CupertinoSwitch(
                    value: controller.isNotificationOn.value,
                    onChanged: (val) => controller.isNotificationOn.value = val,
                    activeColor: Constants.accentColor,
                    thumbColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),

                const SizedBox(height: 3),
                //*----------------------------  Dark Mode Tile  ---------------------------*/
                SettingsTile(
                  title: 'Dark Mode',
                  icon: 'moon',
                  trailing: CupertinoSwitch(
                    value: controller.appServices.isDark.value,
                    onChanged: (val) => controller.appServices.isDark.value = val,
                    activeColor: Constants.accentColor,
                    thumbColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: 'User Settings'.subtitle(weight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
