part of 'item_notification_bloc.dart';

@immutable
abstract class ItemNotificationEvent {}

class ReadMessageEvent extends ItemNotificationEvent {
  late final Message message;

  ReadMessageEvent(this.message);
}
