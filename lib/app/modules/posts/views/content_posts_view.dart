import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/posts_controller.dart';
import '../widgets/post_card.dart';

class ContentPostsView extends GetView<PostsController> {
  const ContentPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.posts.value = [];
        controller.findAllPosts();
      },
      child: Obx(
        () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) => PostCard(
            data: controller.posts[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
