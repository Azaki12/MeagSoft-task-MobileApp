import 'package:get/get.dart';

import '../../../data/models/global_response_model.dart';
import '../../../data/models/posts_models/add_post_model.dart';
import '../../../data/models/posts_models/posts_model/posts_model.dart';
import '../../../data/providers/api_provider.dart';

class PostProviders extends ApiProvider {
  Future<GlobalResponseModel?> postAddPost(int id, AddPostModel data) async {
    Response res = await post('posts/$id', FormData(data.toJson()));
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return GlobalResponseModel.fromJson(res.body);
    }
  }

  Future<PostsModel?> getAllPosts() async {
    Response res = await get('posts', headers: {'Authorization': 'Bearer ${appServices.accessToken}'});
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return PostsModel.fromJson(res.body);
    }
  }

  Future<GlobalResponseModel?> deletePostById(String id) async {
    Response res = await delete('posts/$id', headers: {'Authorization': 'Bearer ${appServices.accessToken}'});
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return GlobalResponseModel.fromJson(res.body);
    }
  }

  Future<PostsModel?> addLike(String postId) async {
    Response res = await post('posts/add-like/$postId', {});
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return PostsModel.fromJson(res.body);
    }
  }

  Future<PostsModel?> addComment({required String postId, required String userId, required String comment}) async {
    Response res = await post('posts/add-comment/$userId/$postId', {'comment': comment});
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return PostsModel.fromJson(res.body);
    }
  }
}
