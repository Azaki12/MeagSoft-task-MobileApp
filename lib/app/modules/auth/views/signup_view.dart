import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/enums/enums.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/global_bg.dart';
import '../../../widgets/global_btn.dart';
import '../../../widgets/global_textfield.dart';
import '../../../widgets/simple_link.dart';
import '../controllers/auth_controller.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalBG(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.18,
                  alignment: Alignment.center,
                  child: Constants.appName.h2,
                ),
                SizedBox(
                  width: Get.width,
                  child: 'Create a New Account'.tr.subtitle(weight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: Get.width,
                  child: 'Create an account so you can follow up on your child\'s condition'.body(center: false),
                ),
                const SizedBox(height: 15),
                Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
// NOTE ----->  Full Name Field
                        GlobalTextField(
                          hintText: 'full name'.tr,
                          prefixIcon: 'person',
                          inputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onSaved: (val) => controller.fullName.value = val!,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please enter your full name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 8),
// NOTE ----->  Email Field
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
// NOTE ----->  Password & Confirm Password Fields
                        Obx(
                          () => Column(
                            children: [
                              GlobalTextField(
                                controller: controller.passController,
                                obsecure: controller.isPassObsecure.value,
                                hintText: 'password'.tr,
                                prefixIcon: 'lock',
                                suffixIcon: (controller.isConfirmPassObsecure.value) ? 'eye-slash' : 'eye',
                                inputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
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
                              const SizedBox(height: 8),
                              GlobalTextField(
                                hintText: 'confirm password'.tr,
                                prefixIcon: 'lock',
                                suffixIcon: (controller.isConfirmPassObsecure.value) ? 'eye-slash' : 'eye',
                                obsecure: controller.isConfirmPassObsecure.value,
                                textInputAction: TextInputAction.go,
                                inputType: TextInputType.visiblePassword,
                                onSaved: (val) => controller.passwordConfirm.value = val!,
                                validator: (String? val) {
                                  if (val != controller.passController.text) {
                                    return 'Password does not match';
                                  } else {
                                    return null;
                                  }
                                },
                                onSuffixTap: () => controller.isConfirmPassObsecure.value = !controller.isConfirmPassObsecure.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
// NOTE ----->  Privacy Policy & Terms & Conditions Checkbox
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.isChecked.value,
                        activeColor: Get.theme.primaryColor,
                        onChanged: (value) => controller.isChecked.value = value!,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: [
                        'I agree to the'.tr.caption,
                        const SizedBox(width: 5),
                        SimpleLink(
                          onTap: () {},
                          text: 'terms of conditions.'.tr.button(color: Constants.accentColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
// NOTE ----->  Signup Button
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: GlobalButton(
                    onTap: () {
                      if (controller.isChecked.value) {
                        if (controller.formKey.currentState!.validate()) {
                          controller.formKey.currentState!.save();
                          controller.register();
                        }
                      } else {
                        Ui.errorGetBar(message: 'please agree to terms');
                      }
                    },
                    type: GlobalBtnType.withoutIcon,
                    text: 'sign up'.tr,
                    height: 55,
                  ),
                ),
                const SizedBox(height: 20),
// NOTE ----->  Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'Already have an account? '.tr.caption,
                    const SizedBox(width: 5),
                    SimpleLink(
                      onTap: () {
                        Get.offNamed(Routes.login);
                      },
                      text: 'sign in'.tr.button(color: Constants.accentColor),
                    ),
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
