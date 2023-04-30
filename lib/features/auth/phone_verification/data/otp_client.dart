
import 'package:dio/dio.dart';
class OtpClient{
  Dio dio ;

  OtpClient(this.dio);

    verifyOtp(String mobile, String otp)async{
    Response response =  await dio.post("${dio.options.baseUrl}/Provider/VerifyProviderOtp?mobile=$mobile&otp=$otp",);
    return response.data;
  }

}