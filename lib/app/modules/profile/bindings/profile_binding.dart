import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../providers/profile_providers.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileProviders>(() => ProfileProviders());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
