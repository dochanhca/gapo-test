part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class LoadDataEvent extends NotificationEvent {}

class StartSearchEvent extends NotificationEvent {}

class SearchEvent extends NotificationEvent {
  late final String text;

  SearchEvent(this.text);
}

class CancelSearchEvent extends NotificationEvent {}

class UpdateNotificationStatusEvent extends NotificationEvent {
  late final String id;

  UpdateNotificationStatusEvent(this.id);
}
