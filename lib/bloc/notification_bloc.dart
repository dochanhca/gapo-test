import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gapo_test/data/model/notification.dart';
import 'package:gapo_test/data/repository/notification_repo.dart';
import 'package:get_it/get_it.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo repo = GetIt.I<NotificationRepo>();

  NotificationBloc(NotificationState initialState) : super(initialState);

  late List<NotificationModel> dataSource;

  @override
  NotificationState get initialState => NotificationEmptyState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadDataEvent) {
      yield NotificationLoadDataState();
      yield* _loadData();
    } else if (event is StartSearchEvent) {
      yield NotificationSearchState('', dataSource);
    } else if (event is SearchEvent) {
      yield* _search(event.text);
    } else if (event is CancelSearchEvent) {
      yield NotificationLoadDataSuccessState(dataSource);
    } else if (event is UpdateNotificationStatusEvent) {
      yield* _updateNotificationStatus(event.id);
    }
  }

  Stream<NotificationState> _loadData() async* {
    try {
      List<NotificationModel>? loadedList = await repo.getNotificationList();
      if (loadedList == null) {
        yield NotificationLoadDataFailureState('Có lỗi xảy ra');
      } else {
        dataSource = loadedList;
        yield NotificationLoadDataSuccessState(dataSource);
      }
    } catch (error) {
      yield NotificationLoadDataFailureState('Có lỗi xảy ra');
    }
  }

  Stream<NotificationState> _search(String? text) async* {
    List<NotificationModel> searchResults;
    if (text == null || text.isEmpty) {
      searchResults = dataSource;
    } else {
      searchResults = dataSource
          .where((element) =>
              element.message.text.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    yield NotificationSearchState(text, searchResults);
  }

  Stream<NotificationState> _updateNotificationStatus(String id) async* {
    dataSource.firstWhere((element) => element.id == id).status =
        NotificationStatus.read.getTextValue();
    if (state is NotificationSearchState) {
      List<NotificationModel>? searchData =
          (state as NotificationSearchState).notificationList;
      String? text = (state as NotificationSearchState).textSearch;
      searchData.firstWhere((element) => element.id == id).status =
          NotificationStatus.read.getTextValue();
      yield NotificationSearchState(text, searchData);
    } else {
      yield NotificationLoadDataSuccessState(dataSource);
    }
  }
}
