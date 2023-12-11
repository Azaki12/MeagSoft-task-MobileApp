import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/constants.dart';
import 'package:test_app/app/core/utils/extensions.dart';


import '../data/enums/enums.dart';

class GlobalButton extends StatelessWidget {
  final GlobalBtnType type;
  final double? width, height;
  final String? icon;
  final String? text;
  final Color? color;
  final VoidCallback onTap;
  const GlobalButton(
      {Key? key,
      required this.onTap,
      this.icon,
      this.text,
      this.color,
      required this.type,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: color ?? Get.theme.primaryColor,
          shadowColor: Get.theme.shadowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
        ),
        child: (type == GlobalBtnType.withIcon)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  text!.button(color: Colors.white),
                  const SizedBox(width: 10),
                  SvgPicture.asset('${Constants.iconsPath}${icon!}.svg'),
                ],
              )
            : text!.button(color: Colors.white),
      ),
    );
  }
}
