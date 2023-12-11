import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/bookmarks_models/bookmark_posts_model.dart';
import '../../../data/models/bookmarks_models/create_bookmark_model.dart';
import '../../../data/models/global_response_model.dart';
import '../../../data/services/app_services.dart';
import '../providers/add_bookmark_provider.dart';

class AddBookmarkController extends GetxController {
  final AddBookmarkProviders addBookmarkProvider = Get.find<AddBookmarkProviders>();
  final AppServices appServices = Get.find<AppServices>();

  addBookmark(String postId) async {
    // Ui.loadingDialog();
    CreateBookmarkModel? response = await addBookmarkProvider.postAddBookmark(appServices.userId!.value, postId);
    if (response == null) {
      // Get.back();
      Ui.errorGetBar(message: 'null');
    } else {
      // Get.back();
      if (response.status == 'Success') {
        Ui.successGetBar(message: response.status!);
      } else {
        Ui.errorGetBar(message: response.status!);
      }
    }
  }

  RxMap<String, BookmarkPostsDatum> bookmarkMap = <String, BookmarkPostsDatum>{}.obs;

  // RxList<BookmarkPostsDatum> bookmarksPostsList = <BookmarkPostsDatum>[].obs;
  getBookmarksPosts() async {
    bookmarkMap.value = {};
    BookmarkPostsModel? response = await addBookmarkProvider.getBookmarksPosts(appServices.userId!.value);
    if (response == null) {
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      if (response.status == 'success') {
        if (response.data!.isEmpty) {
          // Ui.errorGetBar(message: ' has been occured, Please try again later');
        } else {
          for (int i = 0; i < response.data!.length; i++) {
            bookmarkMap[response.data![i].post!.postId!] = response.data![i];
          }
        }
      } else {
        Ui.errorGetBar(message: 'Error has been , Please try again later');
      }
    }
  }

  deleteBookmark(String bookmarkId) async {
    // Ui.loadingDialog();
    GlobalResponseModel? response = await addBookmarkProvider.deleteBookmarkById(bookmarkId, appServices.userId!.value);
    if (response == null) {
      Get.back();
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      if (response.status == 'success') {
        Ui.successGetBar(message: response.status!);
        getBookmarksPosts();
      } else {
        Ui.errorGetBar(message: (response.status == 'fail') ? response.status! : 'Error has been occured, Please try again later');
      }
    }
  }
}
