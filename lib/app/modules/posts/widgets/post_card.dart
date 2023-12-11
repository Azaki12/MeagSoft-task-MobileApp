import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../core/utils/constants.dart';
import '../../../data/models/posts_models/posts_model/post_datum.dart';
import '../controllers/posts_controller.dart';

class PostCard extends GetView<PostsController> {
  final PostDatum? data;
  final int? index;

  const PostCard({Key? key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              title: '${data!.fullName}'.body(
                color: Get.theme.primaryColor,
                weight: FontWeight.bold,
              ),
              subtitle: DateFormat('yy/MM/dd - hh:mm').format(data!.createdAt!.toLocal()).caption,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SvgPicture.asset('${Constants.iconsPath}noImage.svg'),
              ).decorate(radius: 100, width: 50, height: 50, color: Colors.white),
              trailing: (controller.appServices.userId!.value == data!.userId)
                  ? IconButton(
                      onPressed: () => Get.dialog(
                        LimitedBox(
                          child: UnconstrainedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: 'Delete Post'.subtitle(weight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                'Are you sure you want to delete this post'.body(center: true),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () => Get.back(),
                                        child: Center(
                                          child: 'Cancel'.button(color: Colors.grey[400]),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Get.back();
                                          controller.deletePost(data!.postId!);
                                        },
                                        child: Center(
                                          child: 'Delete'.button(color: Get.theme.colorScheme.secondary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).decorate(
                              color: Colors.white,
                              width: Get.width * 0.8,
                              height: Get.height * 0.25,
                              padding: 12,
                              radius: 18,
                            ),
                          ),
                        ),
                      ),
                      icon: 'delete'.icon(color: Get.theme.colorScheme.secondary, size: 20),
                    )
                  : IconButton(
                      onPressed: () async {
                        if (data!.bookmarkedFrom!.contains(controller.appServices.userId!.value)) {
                          await controller.bookmarkController.getBookmarksPosts();
                          await controller.bookmarkController.deleteBookmark(controller.bookmarkController.bookmarkMap[data!.postId!]!.id!);
                          await controller.findAllPosts();
                        } else {
                          await controller.bookmarkController.getBookmarksPosts();
                          await controller.bookmarkController.addBookmark(data!.postId!);
                          await controller.findAllPosts();
                        }
                      },
                      icon: (data!.bookmarkedFrom!.contains(controller.appServices.userId!.value))
                          ? 'star-fill'.icon(color: Constants.accentColor, size: 20)
                          : 'star-stroke'.icon(color: Constants.accentColor, size: 20),
                    ),
            ),
            const Divider(height: 20, thickness: 1, endIndent: 10, indent: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '${data!.body}'.body(),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: ['${controller.likes[data!.postId!]}'.caption, const SizedBox(width: 5), 'Likes'.caption],
                ),
                const SizedBox(width: 15),
                Row(
                  children: ['${controller.comments[data!.postId]!.length}'.caption, const SizedBox(width: 5), 'Comments'.caption],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // --------> Like Btn <--------------//
                Expanded(
                  child: InkWell(
                    onTap: () => controller.addLike(data!.postId!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'like'.icon(color: Get.theme.primaryColor),
                        const SizedBox(width: 12),
                        'Like'.body(),
                      ],
                    ).decorate(color: Colors.white, padding: 10),
                  ),
                ),
                const SizedBox(width: 12),
                // ------> Comment Btn <------------//
                Expanded(
                  child: InkWell(
                    onTap: () => controller.showSheetWithoutList(context, data!.postId!, data!.userId!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'comment'.icon(),
                        const SizedBox(width: 12),
                        'Comment'.body(),
                      ],
                    ).decorate(color: Colors.white, padding: 10),
                  ),
                ),
              ],
            ),
          ],
        ).decorate(color: Colors.white, padding: 12),
      ),
    );
  }
}
