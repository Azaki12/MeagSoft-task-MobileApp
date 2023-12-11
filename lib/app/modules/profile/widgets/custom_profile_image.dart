import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

class CustomProfileImage extends StatelessWidget {
  final String? imageUrl;
  const CustomProfileImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: imageUrl!.profileImage,
        ).decorate(
          width: Get.width * 0.32,
          height: Get.width * 0.32,
          color: Colors.white,
          radius: 15,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
