import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_bg.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlobalAppBar(title: 'Notifications'),
      body: GlobalBG(
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: ListTile(
                title: Text('Notification $index'),
                subtitle: const Text('Subtitle'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Get.theme.colorScheme.secondary,
                ),
                onTap: () {},
              ).decorate(color: Colors.white, padding: 6),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
