
import 'package:dio/dio.dart';
class SlotClient{
  Dio dio ;

  SlotClient(this.dio);

  getSlot(int dayId ,int serviceId)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Slots?dayId=$dayId&serviceId=$serviceId");
    return response.data;
  }

}