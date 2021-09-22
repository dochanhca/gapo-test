import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gapo_test/bloc/notification_bloc.dart';
import 'package:gapo_test/data/model/notification.dart';
import 'package:gapo_test/locator.dart';

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

main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setUpLocator();
  });

  group('NotificationBloc', () {
    test('Initial State is Empty', () {
      final NotificationBloc _bloc = NotificationBloc();
      expect(_bloc.state, NotificationEmptyState());
    });

    blocTest('start Load Data',
        build: () => NotificationBloc(),
        act: (NotificationBloc bloc) => bloc.add(LoadDataEvent()),
        expect: () => [
              NotificationLoadDataState(),
              NotificationLoadDataSuccessState(mockData)
            ]);

    blocTest('Search with empty text',
        build: () => NotificationBloc(),
        act: (NotificationBloc bloc) {
          bloc.add(LoadDataEvent());
          bloc.add(SearchEvent(''));
        },
        expect: () => [
              NotificationLoadDataState(),
              NotificationLoadDataSuccessState(mockData),
              NotificationSearchState('', mockData)
            ]);

    String text = 'zzzzzzzzz';
    List<NotificationModel> searchResults = mockData
        .where((element) =>
            element.message.text.toLowerCase().contains(text.toLowerCase()))
        .toList();
    blocTest('Search with text return empty list',
        build: () => NotificationBloc(),
        act: (NotificationBloc bloc) {
          bloc.add(LoadDataEvent());
          bloc.add(SearchEvent(text));
        },
        expect: () => [
              NotificationLoadDataState(),
              NotificationLoadDataSuccessState(mockData),
              NotificationSearchState(text, searchResults)
            ]);

    blocTest(
      'Cancel Search Event',
      build: () => NotificationBloc(),
      act: (NotificationBloc bloc) {
        bloc.add(LoadDataEvent());
        bloc.add(SearchEvent(''));
        bloc.add(CancelSearchEvent());
      },
      expect: () => [
        NotificationLoadDataState(),
        NotificationLoadDataSuccessState(mockData),
        NotificationSearchState('', mockData),
        NotificationLoadDataSuccessState(mockData),
      ],
    );

    // blocTest('update notification status',
    //     build: () => NotificationBloc(),
    //     act: (NotificationBloc bloc) {
    //   bloc.add(LoadDataEvent());
    //   bloc.add(UpdateNotificationStatusEvent('60c2d917dfab450023476145'));
    //     },
    //     expect: () => [
    //       NotificationLoadDataState(),
    //       NotificationLoadDataSuccessState(mockData),
    //       NotificationLoadDataSuccessState(mockData)
    //     ]);
  });
}
