import 'package:get/get.dart';

import '../../../data/models/posts_models/add_post_model.dart';
import '../../../data/models/posts_models/posts_model/create_post_model.dart';
import '../../../data/providers/api_provider.dart';

class AddPostProviders extends ApiProvider {
  Future<CreatePostModel?> postAddPost(AddPostModel data) async {
    Response res = await post('posts', data.toJson());
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return CreatePostModel.fromJson(res.body);
    }
  }
}
