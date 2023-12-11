import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

class CommentSheetHeader extends StatelessWidget {
  const CommentSheetHeader({super.key, this.offset});
  final double? offset;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
          topRight: Radius.circular(offset == 0.8 ? 0 : 40),
        ),
      ),
      child: SizedBox(
        width: Get.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 40,
              ),
              child: 'Comments'.title(),
            ),
          ],
        ),
      ),
    );
  }
}
