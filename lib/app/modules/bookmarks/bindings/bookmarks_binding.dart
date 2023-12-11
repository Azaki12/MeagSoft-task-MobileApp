import 'package:get/get.dart';

import '../controllers/bookmarks_controller.dart';
import '../providers/bookmarks_provider.dart';

class BookmarksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkProviders>(() => BookmarkProviders());
    Get.lazyPut<BookmarksController>(() => BookmarksController());
  }
}
