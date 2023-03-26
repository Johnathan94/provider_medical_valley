

import 'package:dio/dio.dart';

class OffersClient{
  Dio dio ;

  OffersClient(this.dio);

  getOffers(int page , int pageSize  , int providerId)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Request/GetProviderNegotiations?PageNumber=$page&PageSize=$pageSize&providerId=35");
    return response.data;
  }

}