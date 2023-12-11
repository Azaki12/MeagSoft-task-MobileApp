import 'package:get/get.dart';
import 'package:test_app/app/modules/home/providers/news_provider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<NewsProvider>(() => NewsProvider());

  }
}
