import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';

class BranchesClient {
  Dio dio;

  BranchesClient(this.dio);

  getBranches() async {
    final token = LocalStorageManager.getToken();
    Response response = await dio.get(
      "${dio.options.baseUrl}/Alpha/Provider/GetMyBranches",
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
    return response.data;
  }
}
