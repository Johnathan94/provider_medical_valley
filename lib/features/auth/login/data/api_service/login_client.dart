
import 'package:dio/dio.dart';
class LoginClient{
  Dio dio ;

  LoginClient(this.dio);

  login(String mobile)async{
    Response response =  await dio.post("${dio.options.baseUrl}/Provider/LoginProvider?mobile=$mobile",);
    return response.data;
  }

}