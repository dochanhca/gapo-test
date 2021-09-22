part of 'item_notification_bloc.dart';

@immutable
abstract class ItemNotificationState {}

class ItemNotificationEmptyState extends ItemNotificationState {}

class ItemNotificationReadMessageState extends ItemNotificationState {}

class ItemNotificationReadMessageSuccessState extends ItemNotificationState {
  final List<HighLightText> highLightTextList;

  ItemNotificationReadMessageSuccessState(this.highLightTextList);
}

class ItemNotificationReadMessageFailureState extends ItemNotificationState {
  final String error;

  ItemNotificationReadMessageFailureState(this.error);
}
