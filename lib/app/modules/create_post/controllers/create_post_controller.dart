import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/data/models/posts_models/posts_model/create_post_model.dart';
import 'package:test_app/app/modules/posts/controllers/posts_controller.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/posts_models/add_post_model.dart';
import '../../../data/services/app_services.dart';
import '../providers/add_post_provider.dart';

class CreatePostController extends GetxController {
  final AppServices appServices = Get.find<AppServices>();
  final PostsController postsController = Get.find<PostsController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AddPostProviders addPostProvider = Get.find<AddPostProviders>();
  RxString body = ''.obs;

  addPost() async {
    try {
      Ui.loadingDialog();
      CreatePostModel? response = await addPostProvider.postAddPost(
        AddPostModel(body: body.value, author: appServices.userName!.value, id: appServices.userId!.value),
      );

      if (response!.status == 'Success') {
        Get.back();
        Get.back();
        postsController.findAllPosts();
        Ui.successGetBar(message: response.status!);
      }
    } on DioError catch (e) {
      Get.back();
      Get.back();
      Ui.errorGetBar(message: e.message.toString());
    }
  }
}
