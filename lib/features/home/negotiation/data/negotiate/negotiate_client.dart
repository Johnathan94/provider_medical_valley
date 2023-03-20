
import 'package:dio/dio.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/negotiate/negotiate_request.dart';
class NegotiateClient{
  Dio dio ;

  NegotiateClient(this.dio);

  negotiate(NegotiationRequest request)async{
    Response response =  await dio.post("${dio.options.baseUrl}/Request/AddNegotiation",data: request.toJson());
    return response.data;
  }

}