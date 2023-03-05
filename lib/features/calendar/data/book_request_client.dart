import 'package:dio/dio.dart';

import '../../../core/base_service/dio_manager.dart';
import 'book_request_model.dart';

class BookRequestClient {
  Dio dio = DioManager.getDio();

  BookRequestClient();

  bookRequest(BookRequestModel requestModel) async {
    Response response = await dio.post(
        "${dio.options.baseUrl}/Provider/BookRequest",
        data: requestModel.toJson());
    return response.data;
  }
}
