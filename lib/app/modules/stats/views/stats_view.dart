import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import 'package:test_app/app/modules/posts/controllers/posts_controller.dart';

class StatsView extends GetView<PostsController> {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    '${controller.count}'.title(),
                    const SizedBox(
                      width: 5,
                    ),
                    'Written Post'.title(),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    '${controller.bookmarkssStats.length}'.title(),
                    const SizedBox(
                      width: 5,
                    ),
                    'Saved Post'.title(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
