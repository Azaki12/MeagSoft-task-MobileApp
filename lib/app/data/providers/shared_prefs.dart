import 'package:shared_preferences/shared_preferences.dart';
// import 'constants.dart';

class SharedPrefsHelper {
  static SharedPreferences? prefs;

/*----------------------------------------------------------------------------*/
/*----------------------------  Initialize Prefs  ----------------------------*/
/*----------------------------------------------------------------------------*/
  static initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

/*----------------------------------------------------------------------------*/
/*------------------------------  Access Token  ------------------------------*/
/*----------------------------------------------------------------------------*/
  static void saveApiKeyToPrefs(accessToken) async {
    await initPrefs();
    prefs!.setString('accessToken', accessToken);
  }

  static Future<String?> getApiTokenFromPrefs() async {
    await initPrefs();
    String? accessTokenSaved = prefs!.getString('accessToken');
    return accessTokenSaved;
  }

  static Future removeToken() async {
    await initPrefs();
    prefs!.remove('accessToken');
  }

/*----------------------------------------------------------------------------*/
/*---------------------------------  User Id  --------------------------------*/
/*----------------------------------------------------------------------------*/
  static void saveUserIdToPrefs(String userid) async {
    await initPrefs();
    prefs!.setString('userId', userid);
  }

  static Future<String?> getUserIdFromPrefs() async {
    await initPrefs();
    String? userIdSaved = prefs!.getString('userId');
    return userIdSaved;
  }

  static Future removeUserId() async {
    await initPrefs();
    prefs!.remove('userId');
  }

/*----------------------------------------------------------------------------*/
/*--------------------------------  App Theme  -------------------------------*/
/*----------------------------------------------------------------------------*/
  static Future<bool> checkTheme() async {
    final shared = await SharedPreferences.getInstance();
    return shared.containsKey('theme');
  }

  static Future saveTheme(bool themeId) async {
    await initPrefs();
    prefs!.setBool('theme', themeId);
  }

  static Future<bool?> getTheme() async {
    await initPrefs();
    bool? themeIdSaved = prefs!.getBool('theme');
    return themeIdSaved;
  }

/*----------------------------------------------------------------------------*/
/*--------------------------------  Language  --------------------------------*/
/*----------------------------------------------------------------------------*/
  static storeLanguage(String language) async {
    await initPrefs();
    await prefs!.setString('lang', language);
  }

  static Future<String?> getLanguage() async {
    await initPrefs();
    return prefs?.getString('lang');
  }

  static removeLanguage() async {
    await initPrefs();
    prefs?.remove('lang');
  }

/*----------------------------------------------------------------------------*/
/*--------------------------------  First time  --------------------------------*/
/*----------------------------------------------------------------------------*/
  static void storeisFirstTime(bool isFirstTime) async {
    await initPrefs();
    prefs!.setBool('isFirstTime', isFirstTime);
  }

  static Future<bool?> getIsFirstTime() async {
    await initPrefs();
    bool? isFirstTimeSaved = prefs!.getBool('isFirstTime');
    return isFirstTimeSaved;
  }

  static removeIsFirstTime() async {
    await initPrefs();
    prefs!.remove('isFirstTime');
  }
  /*----------------------------------------------------------------------------*/
/*--------------------------------  UserName  --------------------------------*/
/*----------------------------------------------------------------------------*/

  static void saveUserNameToPrefs(userName) async {
    await initPrefs();
    prefs!.setString('userName', userName);
  }
  static Future<String?> getUserName() async {
    await initPrefs();
    String? userName = prefs!.getString('userName');
    return userName;
  }
  
  static removeUserName() async {
    await initPrefs();
    prefs!.remove('userName');
  }
}
