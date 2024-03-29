import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_medical_valley/features/home/notifications/data/models/notification_model.dart';
import 'package:provider_medical_valley/features/home/notifications/domain/get_notification_use_case.dart';

class NotificationBloc extends Cubit<NotificationState> {
  final GetNotificationUseCase getNotificationUseCase;

  NotificationBloc(this.getNotificationUseCase)
      : super(NotificationStateIdle());

  getNotifications() async {
    emit(NotificationStateLoading());
    var result = await getNotificationUseCase.getNotification();
    result.fold((l) => emit(NotificationStateError(l.error ?? "")),
        (r) => emit(NotificationStateSuccess(r)));
  }
}

abstract class NotificationState {}

class NotificationStateIdle extends NotificationState {}

class NotificationStateError extends NotificationState {
  String error;

  NotificationStateError(this.error);
}

class NotificationStateSuccess extends NotificationState {
  List<NotificationModel> notifications;

  NotificationStateSuccess(this.notifications);
}

class NotificationStateLoading extends NotificationState {}
