
import 'package:dio/dio.dart';
class LoginClient{
  Dio dio ;

  LoginClient(this.dio);

  login(String mobile)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Provider/SignIn?mobile=$mobile",);
    return response.data;
  }

}