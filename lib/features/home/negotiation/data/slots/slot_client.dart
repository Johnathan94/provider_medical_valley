
import 'package:dio/dio.dart';
class SlotClient{
  Dio dio ;

  SlotClient(this.dio);

  getSlot(int  serviceId)async{
    Response response =  await dio.get("${dio.options.baseUrl}/Request/Slots?serviceId=24509");
    return response.data;
  }

}