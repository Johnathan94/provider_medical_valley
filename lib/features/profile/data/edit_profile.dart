import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/features/profile/data/edit_profile_body.dart';
class EditProfileClient{
  Dio dio ;

  EditProfileClient(this.dio);

  editProfile(EditProfileBody profileBody)async{
    Response response =  await dio.put("${dio.options.baseUrl}/Provider/EditProfile",data: jsonEncode(profileBody.toJson()));
    return response.data;
  }

}