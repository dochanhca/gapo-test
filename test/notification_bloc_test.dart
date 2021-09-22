import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gapo_test/bloc/notification_bloc.dart';
import 'package:gapo_test/data/model/notification.dart';
import 'package:gapo_test/data/repository/notification_repo.dart';
import 'package:gapo_test/locator.dart';
import 'package:mocktail/mocktail.dart';

final List<NotificationModel> mockData = [
  NotificationModel(
      id: "60c2d917dfab450023476145",
      type: "gp_single",
      title: "Bài viết mới",
      message: Message(
          text:
              "Tin nội bộ G đã đăng một bài viết mới trong nhóm Sào huyệt G-Group: Anh chị em G-er ơi,...",
          highlights: [
            Highlight(offset: 0, length: 12),
            Highlight(offset: 49, length: 17)
          ]),
      image:
          "https://image-1.gapowork.vn/images/16ad0a91-6af4-4571-ad43-91540fa633a2.jpeg",
      icon: "https://image-1.gapo.vn/images/icon/new/group2.png",
      status: "unread",
      readAt: 0,
      createdAt: 1623382295,
      updatedAt: 1623383376,
      receivedAt: 1623382295,
      imageThumb:
          "https://image-1.gapowork.vn/images/16ad0a91-6af4-4571-ad43-91540fa633a2.jpeg",
      animation: "",
      subjectName: "Tin nội bộ G",
      isSubscribed: true,
      tracking: null,
      subscription: null)
];

class MockRepo extends Mock implements NotificationRepo {}

class MockBlock extends MockBloc<NotificationEvent, NotificationState>
    implements NotificationBloc {}

class FakeLoadDataEvent extends Fake implements LoadDataEvent {}

class FakeEmptyState extends Fake implements NotificationEmptyState {}

main() {
  setUpAll(() {
    registerFallbackValue(FakeLoadDataEvent());
    registerFallbackValue(FakeEmptyState());
  });
  setUpLocator();

  group('whenListen', () {
    test("Let's mock the CounterBloc's stream!", () {
      // Create Mock CounterBloc Instance
      final bloc = NotificationBloc(NotificationEmptyState());
      // bloc.add(FakeLoadDataEvent());

      // Stub the listen with a fake Stream
      // Expect that the CounterBloc instance emitted the stubbed Stream of
      // states
      expect(bloc.state, NotificationEmptyState());
    });
  });
}
