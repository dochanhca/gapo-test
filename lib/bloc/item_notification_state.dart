part of 'item_notification_bloc.dart';

@immutable
abstract class ItemNotificationState extends Equatable {}

class ItemNotificationEmptyState extends ItemNotificationState {
  @override
  List<Object?> get props => [];
}

class ItemNotificationReadMessageState extends ItemNotificationState {
  @override
  List<Object?> get props => [];
}

class ItemNotificationReadMessageSuccessState extends ItemNotificationState {
  final List<HighLightText> highLightTextList;

  ItemNotificationReadMessageSuccessState(this.highLightTextList);

  @override
  List<Object?> get props => [highLightTextList];
}

class ItemNotificationReadMessageFailureState extends ItemNotificationState {
  final String error;

  ItemNotificationReadMessageFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
