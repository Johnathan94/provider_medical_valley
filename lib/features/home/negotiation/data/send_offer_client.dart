import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/offer_model.dart';
class SendOfferClient{
  Dio dio ;

  SendOfferClient(this.dio);

  sendOffer(SendOffer offer)async{
    Response response =  await dio.post("${dio.options.baseUrl}/Provider/SendOffer",data: jsonEncode(offer.toJson()));
    return response.data;
  }

}