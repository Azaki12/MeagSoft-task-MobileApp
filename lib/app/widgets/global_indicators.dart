import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/constants.dart';

class GlobalIndicators extends StatelessWidget {
  final int? length;
  final int? cindex;
  const GlobalIndicators({Key? key, this.length, this.cindex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length!,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedContainer(
              width: 10,
              height: 10,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: (cindex == index)
                    ? Get.theme.colorScheme.secondary
                    : Get.theme.scaffoldBackgroundColor,
                shape: BoxShape.circle,
                border: (cindex != index)
                    ? Border.all(
                        color: Constants.lightBlue,
                        width: 2,
                      )
                    : const Border.fromBorderSide(BorderSide.none),
              ),
            ),
          ),
        ));
  }
}
