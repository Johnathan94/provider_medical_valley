import 'package:dio/dio.dart';

class GetProfileClient {
  Dio dio;
  GetProfileClient(this.dio);

  getMyProfile(int id) async {
    Response response = await dio
        .get("${dio.options.baseUrl}/Provider/GetProviderById?providerId=$id");
    return response.data;
  }
}
