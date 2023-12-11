import 'package:get/get.dart';

import '../controllers/create_post_controller.dart';
import '../providers/add_post_provider.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPostProviders>(() => AddPostProviders());
    Get.lazyPut<CreatePostController>(() => CreatePostController());
  }
}
