import 'package:get/get.dart';
import 'package:test_app/app/data/services/app_services.dart';

class SettingsController extends GetxController {
  final AppServices appServices = Get.find<AppServices>();
  RxBool isNotificationOn = RxBool(false);
  @override
  void onClose() {}
}
