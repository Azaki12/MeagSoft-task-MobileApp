import 'package:get/get.dart';

import '../controllers/add_bookmark_controller.dart';
import '../controllers/posts_controller.dart';
import '../providers/add_bookmark_provider.dart';
import '../providers/posts_providers.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostsController>(() => PostsController(), fenix: true);
    Get.lazyPut<AddBookmarkController>(() => AddBookmarkController(), fenix: true);
    Get.lazyPut<AddBookmarkProviders>(() => AddBookmarkProviders(), fenix: true);

    Get.lazyPut<PostProviders>(() => PostProviders(), fenix: true);
  }
}
