import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/auth_models/login_model.dart';
import '../../../data/models/auth_models/signup_models.dart';
import '../../../data/models/global_response_model.dart';
import '../../../data/services/app_services.dart';
import '../../../routes/app_pages.dart';
import '../providers/auth_providers.dart';

class AuthController extends GetxController {
  final AuthProviders authProvider = Get.find<AuthProviders>();
  final AppServices appServices = Get.find<AppServices>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString passwordConfirm = ''.obs;
  RxBool isChecked = false.obs;
  RxBool isPassObsecure = true.obs;
  RxBool isConfirmPassObsecure = true.obs;

  register() async {
    Ui.loadingDialog();
    GlobalResponseModel? registerModel = await authProvider.postRegister(SignupRequestModel(
      fullName: fullName.value,
      email: email.value,
      password: password.value,
      passwordConfirm: passwordConfirm.value,
    ));
    if (registerModel == null) {
      Get.back();
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      Get.back();
      if (registerModel.status == 'success') {
        login();
        Get.offAllNamed(Routes.home)!.then(
          (value) => Ui.successGetBar(message: registerModel.status!),
        );
      } else {
        if (registerModel.status == 'fail') {
          Ui.errorGetBar(message: registerModel.status!);
        } else {
          Ui.errorGetBar(message: 'Error has been occured, Please try again later');
        }
      }
    }
  }

  login() async {
    Ui.loadingDialog();
    LoginResponseModel? loginModel = await authProvider.postLogin(email.value, password.value);
    if (loginModel == null) {
      Get.back();
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      Get.back();
      if (loginModel.status == 'success') {
        Get.offNamedUntil(Routes.home, (route) => false)!;
        appServices.saveAccessToken(loginModel.token!);
        appServices.saveUserId(loginModel.data!.id!);
        appServices.saveUserName(loginModel.data!.fullName!);
      } else {
        // Ui.errorGetBar(message: (loginModel.code == 400) ? loginModel.message! : 'Error has been occured, Please try again later');
      }
    }
  }

  dummyLogin() async {
    Ui.loadingDialog();
    Get.offNamedUntil(Routes.home, (route) => false)!;
    Ui.successGetBar(message: 'loginModel.message!');
    Get.back();
  }
}
