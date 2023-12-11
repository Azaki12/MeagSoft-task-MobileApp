import 'package:get/get.dart';

import '../../../data/models/bookmarks_models/bookmark_posts_model.dart';
import '../../../data/models/global_response_model.dart';
import '../../../data/providers/api_provider.dart';

class BookmarkProviders extends ApiProvider {
  // NOTE :- Get Bookmarks Posts
  Future<BookmarkPostsModel?> getBookmarksPosts(String id) async {
    Response res = await get('bookmarks/$id');
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return BookmarkPostsModel.fromJson(res.body);
    }
  }

  // NOTE :- Delete Post by id
  Future<GlobalResponseModel?> deleteBookmarkById(String id, String userId) async {
    Response res = await delete('bookmarks/$id/$userId');
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return GlobalResponseModel.fromJson(res.body);
    }
  }
}
