import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  static late SharedPreferences sharedPreferences ;
  static initialize ()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static saveUser (Map<String, dynamic> userDate)async{
    await sharedPreferences.setString("user", jsonEncode(userDate));
  }
  static deleteUser ()async{
    await sharedPreferences.setString("user","");
  }
  static String getUser (){
    return sharedPreferences.getString("user") ?? "";
  }

}