import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gapo_test/bloc/item_notification_bloc.dart';
import 'package:gapo_test/data/model/highlight_text.dart';
import 'package:gapo_test/data/model/notification.dart';

final Message mockMessage1 = Message(
          text:
          "Tin nội bộ G đã đăng một bài viết mới trong nhóm Sào huyệt G-Group: Anh chị em G-er ơi,...",
          highlights: [
            Highlight(offset: 0, length: 12),
            Highlight(offset: 49, length: 17)
          ]);
final Message mockMessage2 = Message(
    text:
    "tesst casse no highlight",
    highlights: []);

main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Item Notification BLoc', () {
    test('Initial State is Empty', () {
      final ItemNotificationBloc _bloc = ItemNotificationBloc();
      expect(_bloc.state, ItemNotificationEmptyState());
    });

    List<HighLightText> mockListText1 = [
      HighLightText(text: 'Tin nội bộ G', isHighLight: true),
      HighLightText(text: ' đã đăng một bài viết mới trong nhóm '),
      HighLightText(text: 'Sào huyệt G-Group', isHighLight: true),
      HighLightText(text: ': Anh chị em G-er ơi,...'),
    ];
    blocTest('start read message',
        build: () => ItemNotificationBloc(),
        act: (ItemNotificationBloc bloc) => bloc.add(ReadMessageEvent(mockMessage1)),
        expect: () => [
          ItemNotificationReadMessageState(),
          ItemNotificationReadMessageSuccessState(mockListText1)
        ]);

    List<HighLightText> mockListText2 = [
      HighLightText(text: 'tesst casse no highlight'),
    ];
    blocTest('start read message',
        build: () => ItemNotificationBloc(),
        act: (ItemNotificationBloc bloc) => bloc.add(ReadMessageEvent(mockMessage2)),
        expect: () => [
          ItemNotificationReadMessageState(),
          ItemNotificationReadMessageSuccessState(mockListText2)
        ]);
  });
}
