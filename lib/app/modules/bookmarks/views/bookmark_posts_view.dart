import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import 'package:test_app/app/modules/bookmarks/controllers/bookmarks_controller.dart';

import '../../../core/utils/constants.dart';

class BookmarksPostsView extends GetView<BookmarksController> {
  const BookmarksPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.bookmarksPostsList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  title: '${controller.bookmarksPostsList[index].post!.fullName}'.body(
                    color: Get.theme.primaryColor,
                    weight: FontWeight.bold,
                  ),
                  subtitle: DateFormat('yy/MM/dd - hh:mm').format(controller.bookmarksPostsList[index].post!.createdAt!).caption,
                  trailing: IconButton(
                    onPressed: () {
                      Get.dialog(
                        LimitedBox(
                          child: UnconstrainedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: 'Remove bookmark'.subtitle(weight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                'Are you sure you want to remove this post from bookmark'.body(center: true),
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
                                          controller.deleteBookmark(controller.bookmarksPostsList[index].id!);
                                        },
                                        child: Center(
                                          child: 'Remove'.button(color: Get.theme.colorScheme.secondary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).decorate(
                              color: Colors.white,
                              width: Get.width * 0.8,
                              height: Get.height * 0.28,
                              padding: 12,
                              radius: 18,
                            ),
                          ),
                        ),
                      );
                    },
                    icon: 'star-fill'.icon(color: Constants.accentColor, size: 20),
                  ),
                ),
                const Divider(height: 10, thickness: 1, endIndent: 10, indent: 10),
                SizedBox(width: double.infinity, child: '${controller.bookmarksPostsList[index].post!.body}'.body()),
              ],
            ).decorate(color: Colors.white, padding: 15, radius: 12),
          );
        },
      ),
    );
  }
}
