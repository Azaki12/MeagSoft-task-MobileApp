import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_bg.dart';
import '../controllers/posts_controller.dart';
import 'content_posts_view.dart';

class PostsView extends GetView<PostsController> {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlobalAppBar(title: 'Posts', isPosts: true),
      body: GlobalBG(
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.appServices.pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (val) {
                    controller.appServices.currentPage.value = val;
                  },
                  children: const [
                    ContentPostsView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        onPressed: () => Get.toNamed(Routes.createPost),
        child: 'create-post'.icon(color: Colors.white),
      ),
    );
  }
}
