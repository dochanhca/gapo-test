part of 'notification_bloc.dart';

@immutable
abstract class NotificationState extends Equatable {
}

class NotificationEmptyState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoadDataState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoadDataSuccessState extends NotificationState {
  final List<NotificationModel> notificationList;
  final String? updatedId;

  NotificationLoadDataSuccessState({required this.notificationList, this.updatedId});
  @override
  List<Object?> get props => [notificationList, updatedId];
}

class NotificationLoadDataFailureState extends NotificationState {
  final String errorMessage;

  NotificationLoadDataFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

}

class NotificationSearchState extends NotificationLoadDataSuccessState {
  final String? textSearch;

  NotificationSearchState({this.textSearch, notificationList, updatedId})
      : super(notificationList: notificationList, updatedId: updatedId);

  @override
  List<Object?> get props => [textSearch, notificationList, updatedId];
}

