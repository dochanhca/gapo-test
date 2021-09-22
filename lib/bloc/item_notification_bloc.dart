import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gapo_test/data/model/highlight_text.dart';
import 'package:gapo_test/data/model/notification.dart';

part 'item_notification_event.dart';

part 'item_notification_state.dart';

class ItemNotificationBloc
    extends Bloc<ItemNotificationEvent, ItemNotificationState> {
  ItemNotificationBloc() : super(ItemNotificationEmptyState());

  @override
  Stream<ItemNotificationState> mapEventToState(
      ItemNotificationEvent event) async* {
    if (event is ReadMessageEvent) {
      yield ItemNotificationReadMessageState();
      yield* _readMessage(event.message);
    }
  }

  Stream<ItemNotificationState> _readMessage(Message message) async* {
    String text = message.text;
    String temp = '';
    List<HighLightText> highLightTextList = [];
    if (message.highlights.isEmpty) {
      highLightTextList.add(HighLightText(text: text));
    } else {
      message.highlights.forEach((element) {
        if (element.offset > temp.length) {
          HighLightText notHighLightText =
              HighLightText(text: text.substring(temp.length, element.offset));
          highLightTextList.add(notHighLightText);
          temp += text.substring(temp.length, element.offset);

          HighLightText highLightText = HighLightText(
              text: text.substring(
                  element.offset, element.offset + element.length),
              isHighLight: true);
          highLightTextList.add(highLightText);
          temp +=
              text.substring(element.offset, element.offset + element.length);
        } else {
          HighLightText highLightText = HighLightText(
              text: text.substring(
                  element.offset, element.offset + element.length),
              isHighLight: true);
          highLightTextList.add(highLightText);
          temp +=
              text.substring(element.offset, element.offset + element.length);
        }
      });

      if (temp.length < text.length) {
        HighLightText lastText =
            HighLightText(text: text.substring(temp.length, text.length));
        highLightTextList.add(lastText);
      }
    }

    yield ItemNotificationReadMessageSuccessState(highLightTextList);
  }
}
