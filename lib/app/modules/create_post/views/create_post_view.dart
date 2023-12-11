import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_textfield.dart';
import '../controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: 'Create Post'),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Form(
                  key: controller.formKey,
                  child: GlobalTextField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please type anything in your post';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => controller.body.value = val!,
                    hintText: 'Type Something...',
                    filled: false,
                    maxLines: 18,
                    textInputAction: TextInputAction.none,
                  ).decorate(color: Colors.white, padding: 12),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            controller.formKey.currentState!.save();
            controller.addPost();
          }
        },
        label: 'Create'.button(color: Colors.white),
        backgroundColor: Get.theme.primaryColor,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 55),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
