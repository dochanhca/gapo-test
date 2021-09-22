part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {
}

class NotificationEmptyState extends NotificationState {}

class NotificationLoadDataState extends NotificationState {}

class NotificationLoadDataSuccessState extends NotificationState {
  final List<NotificationModel> notificationList;

  NotificationLoadDataSuccessState(this.notificationList);
}

class NotificationLoadDataFailureState extends NotificationState {
  final String errorMessage;

  NotificationLoadDataFailureState(this.errorMessage);
}

class NotificationSearchState extends NotificationLoadDataSuccessState {
  final String? textSearch;

  NotificationSearchState(this.textSearch, notificationList) : super(notificationList);
}

