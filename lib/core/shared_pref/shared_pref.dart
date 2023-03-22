import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
String _provider = "provider";
class LocalStorageManager {
  static late SharedPreferences sharedPreferences ;
  static initialize ()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static saveUser (Map<String, dynamic> userDate)async{
    await sharedPreferences.setString("${_provider}user", jsonEncode(userDate));
  }
  static saveToken (String token)async{
    await sharedPreferences.setString("${_provider}token", token);
  }
  static String getToken (){
    return sharedPreferences.getString("${_provider}token") ?? "";
  }
  static deleteUser ()async{
    await sharedPreferences.setString("${_provider}user","");
  }
  static String getUser (){
    return sharedPreferences.getString("${_provider}user") ?? "";
  }

}