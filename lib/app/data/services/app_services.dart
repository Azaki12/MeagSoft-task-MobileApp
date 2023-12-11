import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../providers/shared_prefs.dart';

class AppServices extends GetxService {
  @override
  onInit() {
    super.onInit();
    getThemeFromPrefs();
    getAccessToken();
    getUserId();
    getfirsttime();
    getUserName();

    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /*--------------------------------------------------------------------------*/
  /*------------------------------  Variables  -------------------------------*/
  /*--------------------------------------------------------------------------*/

  RxBool isDark = false.obs;
  RxString accessToken = RxString('');
  RxString? userId = ''.obs;
  RxBool isFirstTime = true.obs;
  RxString? userName = ''.obs;

  /*--------------------------------------------------------------------------*/
  /*-------------------------  Control Toggle Bars  --------------------------*/
  /*--------------------------------------------------------------------------*/
  PageController pageController = PageController(initialPage: 0);
  RxInt currentPage = 0.obs;

  animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /*--------------------------------------------------------------------------*/
  /*---------------------------  Save Functions  -----------------------------*/
  /*--------------------------------------------------------------------------*/

  void setIsFirstTime(bool val) async {
    isFirstTime = val.obs;
    SharedPrefsHelper.storeisFirstTime(val);
  }

  void saveAccessToken(String token) {
    accessToken = token.obs;
    SharedPrefsHelper.saveApiKeyToPrefs(token);
  }

  void saveUserId(String id) {
    userId = id.obs;
    SharedPrefsHelper.saveUserIdToPrefs(id);
  }

  void saveUserName(String name) {
    userName = name.obs;
    SharedPrefsHelper.saveUserNameToPrefs(name);
  }

  changeTheme(bool value) {
    isDark.value = value;
    SharedPrefsHelper.saveTheme(value);
  }

  /*--------------------------------------------------------------------------*/
  /*----------------------------  Get Functions  -----------------------------*/
  /*--------------------------------------------------------------------------*/

  void getAccessToken() async {
    String? data = await SharedPrefsHelper.getApiTokenFromPrefs();
    if (data != null) {
      accessToken = data.obs;
      debugPrint('tokennnnnnnnnnnnnnnnnn :: $accessToken');
    }
  }

  void getUserId() async {
    String? data = await SharedPrefsHelper.getUserIdFromPrefs();
    if (data != null) {
      userId = data.obs;
      debugPrint('iddddddddddddddddddddddddd :: $userId');
    }
  }

  void getUserName() async {
    String? data = await SharedPrefsHelper.getUserName();
    if (data != null) {
      userName = data.obs;
      debugPrint('NAMMMMEMMEMEEMMEEEEEE :: $userName');
    }
  }

  getThemeFromPrefs() async {
    bool val = await SharedPrefsHelper.checkTheme();
    if (val) {
      isDark.value = (await SharedPrefsHelper.getTheme())!;
    } else {
      isDark.value = false;
    }
  }

  void getfirsttime() async {
    bool? data = await SharedPrefsHelper.getIsFirstTime();
    if (data != null) {
      isFirstTime = data.obs;
    }
  }

  /*--------------------------------------------------------------------------*/
  /*--------------------------  Remove User Data  ----------------------------*/
  /*--------------------------------------------------------------------------*/

  void removeUserData() {
    accessToken.value = '';
    userId!.value = '';
    SharedPrefsHelper.removeToken();
    SharedPrefsHelper.removeUserName();
    SharedPrefsHelper.removeUserId();
  }
}
