import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../core/utils/constants.dart';
import '../../../data/enums/enums.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/global_bg.dart';
import '../../../widgets/global_btn.dart';
import '../../../widgets/global_textfield.dart';
import '../../../widgets/simple_link.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GlobalBG(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Constants.appName.h2,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        'Welcome Back '.tr.subtitle(weight: FontWeight.bold),
                        SvgPicture.asset('${Constants.iconsPath}hand-emoji.svg'),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: Get.width,
                      child: 'So happy to see you again. You can continue to login'.body(),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: controller.loginFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            GlobalTextField(
                              hintText: 'email address'.tr,
                              prefixIcon: 'email',
                              inputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onSaved: (val) => controller.email.value = val!,
                              validator: (String? val) {
                                if (val!.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!val.isEmail) {
                                  return 'Please enter a valid email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 8),
                            Obx(
                              () => GlobalTextField(
                                obsecure: controller.isPassObsecure.value,
                                hintText: 'password'.tr,
                                prefixIcon: 'lock',
                                suffixIcon: 'eye-slash',
                                inputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.go,
                                onSaved: (val) => controller.password.value = val!,
                                validator: (String? val) {
                                  if (val!.isEmpty) {
                                    return 'password is required'.tr;
                                  } else if (val.length < 8) {
                                    return 'password must be at least 8 digits'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                onSuffixTap: () => controller.isPassObsecure.value = !controller.isPassObsecure.value,
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: GlobalButton(
                        onTap: () {
                          if (controller.loginFormKey.currentState!.validate()) {
                            controller.loginFormKey.currentState!.save();
                            controller.login();
                          }
                        },
                        type: GlobalBtnType.withoutIcon,
                        text: 'login'.tr,
                        height: 55,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Do not have an account? '.tr.caption,
                        const SizedBox(width: 5),
                        SimpleLink(
                          onTap: () {
                            Get.offNamed(Routes.signup);
                          },
                          text: 'sign up'.tr.button(color: Constants.accentColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
