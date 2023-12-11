import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/bookmarks_models/bookmark_posts_model.dart';
import '../../../data/models/global_response_model.dart';
import '../../../data/services/app_services.dart';
import '../providers/bookmarks_provider.dart';

class BookmarksController extends GetxController {
  final BookmarkProviders provider = Get.find<BookmarkProviders>();
  final AppServices appServices = Get.find<AppServices>();

  @override
  void onInit() {
    getBookmarksPosts();
    super.onInit();
  }

  RxList<BookmarkPostsDatum> bookmarksPostsList = <BookmarkPostsDatum>[].obs;
  getBookmarksPosts() async {
    BookmarkPostsModel? response = await provider.getBookmarksPosts(appServices.userId!.value);
    if (response == null) {
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      if (response.status == 'success') {
        if (response.data!.isEmpty) {
          Ui.errorGetBar(message: ' has been occured, Please try again later');
        } else {
          bookmarksPostsList.value = response.data!;
        }
      } else {
        Ui.errorGetBar(message: 'Error has been , Please try again later');
      }
    }
  }

  deleteBookmark(String bookmarkId) async {
    Ui.loadingDialog();
    GlobalResponseModel? response = await provider.deleteBookmarkById(bookmarkId, appServices.userId!.value);
    if (response == null) {
      Get.back();
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      Get.back();

      if (response.status == 'success') {
        Ui.successGetBar(message: response.status!);
        getBookmarksPosts();
      } else {
        Ui.errorGetBar(message: (response.status == 'fail') ? response.status! : 'Error has been occured, Please try again later');
      }
    }
  }
}
