
import 'package:dio/dio.dart';

class RequestsClient {
  Dio dio ;

  RequestsClient(this.dio);

  getRequests(int bookingTypeId , int page , int pageSize)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Requests?PageNumber=$page&PageSize=$pageSize&providerId=70&BookingTypeId=$bookingTypeId",);
    return response.data;
  }
}