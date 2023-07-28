import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

String _provider = "provider";

class LocalStorageManager {
  static late SharedPreferences sharedPreferences;
  static initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveUser(Map<String, dynamic> userDate) async {
    await sharedPreferences.setString("${_provider}user", jsonEncode(userDate));
  }

  static saveToken(String token) async {
    await sharedPreferences.setString("${_provider}token", token);
  }

  static acceptTermsAndConditions() async {
    await sharedPreferences.setBool("accept_terms", true);
  }

  static isTermsAcceptedBefore() {
    return sharedPreferences.getBool("accept_terms");
  }

  static Future saveCurrentLanguage(String locale) async {
    await sharedPreferences.setString("${_provider}locale", locale);
  }

  static String getCurrentLanguage() {
    return sharedPreferences.getString("${_provider}locale") ?? "";
  }

  static String getToken() {
    return sharedPreferences.getString("${_provider}token") ?? "";
  }

  static deleteUser() async {
    await sharedPreferences.setString("${_provider}user", "");
  }

  static Map<String, dynamic>? getUser() {
    String user = sharedPreferences.getString("${_provider}user") ?? "";

    Map<String, dynamic> currentUser = {};
    if (user != "") {
      currentUser = jsonDecode(user);
      return currentUser;
    }
    return null;
  }
}
