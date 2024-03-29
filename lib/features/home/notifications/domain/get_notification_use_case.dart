import 'package:dartz/dartz.dart';
import 'package:provider_medical_valley/core/failures/failures.dart';
import 'package:provider_medical_valley/features/home/notifications/data/api/categories_client.dart';
import 'package:provider_medical_valley/features/home/notifications/data/models/notification_model.dart';

abstract class GetNotificationUseCase {
  Future<Either<ServerFailure , List<NotificationModel>>> getNotification();
}
class GetNotificationUseCaseImpl extends GetNotificationUseCase{
  NotificationClient notificationClient ;

  GetNotificationUseCaseImpl(this.notificationClient);

  @override
  Future<Either<ServerFailure, List<NotificationModel>>> getNotification()async {
    var result = await notificationClient.getNotifications();
    NotificationResponseModel notificationResponseModel = NotificationResponseModel.fromJson(result);
    if(notificationResponseModel.responseCode == 200){
      return Right(notificationResponseModel.data!);
    }
    else {
      return Left(ServerFailure(error : notificationResponseModel.message));
    }
  }

}