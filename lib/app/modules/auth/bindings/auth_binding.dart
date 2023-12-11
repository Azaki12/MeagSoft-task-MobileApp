import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_providers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProviders>(() => AuthProviders());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
