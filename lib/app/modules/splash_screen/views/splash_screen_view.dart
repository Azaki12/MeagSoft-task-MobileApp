import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';
import '../../../core/utils/constants.dart';
import '../../../widgets/global_bg.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(controller);
    return Scaffold(
      body: GlobalBG(
        body: Center(
          child: Hero(
            tag: 'appname',
            child: Constants.appName.h1,
          ),
        ),
      ),
    );
  }
}
