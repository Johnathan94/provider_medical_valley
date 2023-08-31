import 'package:dio/dio.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';

class SlotClient {
  Dio dio;

  SlotClient(this.dio);

  getSlot(int branchId, int requestId) async {
    Response response = await dio.get(
      "${dio.options.baseUrl}/Alpha/Provider/GetAvailableSlots?BranchId=$branchId&RequestId=$requestId",
      options: Options(headers: {
        'Authorization': 'Bearer ${LocalStorageManager.getToken()}',
      }),
    );
    return response.data;
  }
}
