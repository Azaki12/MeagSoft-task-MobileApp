import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import 'package:test_app/app/modules/posts/controllers/add_bookmark_controller.dart';
import 'package:test_app/app/modules/posts/widgets/comment_sheet_header.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/global_response_model.dart';
import '../../../data/models/posts_models/posts_model/post_datum.dart';
import '../../../data/models/posts_models/posts_model/posts_model.dart';
import '../../../data/services/app_services.dart';
import '../../../widgets/global_textfield.dart';
import '../providers/posts_providers.dart';

class PostsController extends GetxController {
  final PostProviders provider = Get.find<PostProviders>();
  final AppServices appServices = Get.find<AppServices>();
  final AddBookmarkController bookmarkController = Get.find<AddBookmarkController>();
  RxList<RxBool> isBookmark = <RxBool>[].obs;
  RxMap<String, int> likes = <String, int>{}.obs;
  RxMap<String, List<dynamic>> comments = <String, List<dynamic>>{}.obs;
  TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    findAllPosts();
    super.onInit();
  }

  RxList<PostDatum> posts = <PostDatum>[].obs;
  RxList<PostDatum> postsStats = <PostDatum>[].obs;
  RxList<PostDatum> bookmarkssStats = <PostDatum>[].obs;
  RxInt count = 0.obs;

  Future<void> findAllPosts() async {
    posts.value = [];
    isBookmark.value = [];
    PostsModel? postsModel = await provider.getAllPosts();
    if (postsModel == null) {
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      if (postsModel.status == 'success') {
        posts.addAll(postsModel.data!);
        for (int i = 0; i < posts.length; i++) {
          likes[posts[i].postId!] = posts[i].likes!;
          comments[posts[i].postId!] = posts[i].comments!;

          if (posts[i].userId == appServices.userId!.value) {
            postsStats.add(posts[i]);
            count.value++;
          }
          if (posts[i].bookmarkedFrom!.contains(appServices.userId!.value)) {
            bookmarkssStats.add(posts[i]);
          }
        }
      }
    }
  }

  deletePost(String id) async {
    Ui.loadingDialog();
    GlobalResponseModel? response = await provider.deletePostById(id);
    if (response == null) {
      Get.back();
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      Get.back();
      if (response.code == 204) {
        Ui.successGetBar(message: response.status!);
        posts.value = [];
        findAllPosts();
        Get.back();
      } else {
        Ui.errorGetBar(message: (response.code == 404) ? response.status! : 'Error has been occured, Please try again later');
      }
    }
  }

  addLike(String postId) async {
    Ui.loadingDialog();
    PostsModel? response = await provider.addLike(postId);
    if (response == null) {
      Get.back();
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      Get.back();
      if (response.status == 'Success') {
        Ui.successGetBar(message: response.status!);
        likes[postId] = response.data![0].likes!;
        Get.back();
      } else {
        Ui.errorGetBar(message: (response.status == 'fail') ? response.status! : 'Error has been occured, Please try again later');
      }
    }
  }

  addComment(String comment, String postId) async {
    Ui.loadingDialog();
    PostsModel? response = await provider.addComment(postId: postId, userId: appServices.userId!.value, comment: comment);
    if (response == null) {
      Get.back();
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      Get.back();
      if (response.status == 'Success') {
        Ui.successGetBar(message: response.status!);
        comments[postId] = response.data![0].comments!;
        Get.back();
      } else {
        Ui.errorGetBar(message: (response.status == 'fail') ? response.status! : 'Error has been occured, Please try again later');
      }
    }
  }

  void showSheetWithoutList(BuildContext context, String postId, String userId) {
    showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.9,
      maxHeight: 0.9,
      headerHeight: 50,
      context: context,
      barrierColor: Colors.transparent,
      bottomSheetColor: Colors.transparent,
      isSafeArea: true,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      headerBuilder: (context, offset) {
        return CommentSheetHeader(offset: offset);
      },
      bodyBuilder: (context, offset) {
        return SliverChildListDelegate(
          [
            (comments[postId]!.isEmpty)
                ? SizedBox(height: Get.height * 0.71, child: Center(child: 'No Comments are made be the first to comment :)'.subtitle()))
                : Obx(
                    () => SizedBox(
                      width: Get.width,
                      height: Get.height * 0.72,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          for (int i = 0; i < comments[postId]!.length; i++) ...[
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                              title: '${comments[postId]![i]['comment']}'.subtitle(
                                color: Colors.grey,
                                weight: FontWeight.bold,
                              ),
                              subtitle: '${comments[postId]![i]['userName']}'.caption,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const CircleAvatar(
                                  foregroundColor: Colors.amber,
                                  radius: 40,
                                ),
                              ),
                            ).decorate(
                              color: Colors.white,
                              width: Get.width * 0.8,
                              height: Get.height * 0.1,
                              padding: 12,
                              radius: 18,
                            ),
                            const SizedBox(height: 10)
                          ]
                        ],
                      ),
                    ),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                height: kBottomNavigationBarHeight + 15,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GlobalTextField(
                        controller: commentController,
                        hintText: 'Write a Comment',
                        filled: false,
                      ).decorate(color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        addComment(commentController.text, postId);
                        commentController.clear();
                      },
                      child: 'send'.icon().decorate(
                            color: Colors.white,
                            width: 55,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      anchors: [.2, 0.3, .5],
    );
  }
}
