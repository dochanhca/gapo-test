import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gapo_test/data/model/notification.dart';
import 'package:gapo_test/data/repository/notification_repo.dart';
import 'package:get_it/get_it.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo repo = GetIt.I<NotificationRepo>();

  NotificationBloc() : super(NotificationEmptyState());

  late List<NotificationModel> dataSource;

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadDataEvent) {
      yield NotificationLoadDataState();
      yield* _loadData();
    } else if (event is StartSearchEvent) {
      yield NotificationSearchState(
          textSearch: '', notificationList: dataSource);
    } else if (event is SearchEvent) {
      yield* _search(event.text);
    } else if (event is CancelSearchEvent) {
      yield NotificationLoadDataSuccessState(notificationList: dataSource);
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
        yield NotificationLoadDataSuccessState(notificationList: dataSource);
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
    yield NotificationSearchState(
        textSearch: text, notificationList: searchResults);
  }

  Stream<NotificationState> _updateNotificationStatus(String id) async* {
    if (state is NotificationSearchState) {
      _updateDataSource(id);
      List<NotificationModel>? searchData = _updateSearchList(id);
      String? text = (state as NotificationSearchState).textSearch;

      print('update status in search');
      yield NotificationSearchState(
          textSearch: text, notificationList: searchData, updatedId: id);
    } else {
      _updateDataSource(id);
      yield NotificationLoadDataSuccessState(
          notificationList: dataSource, updatedId: id);
    }
  }

  _updateDataSource(String id) {
    int needUpdateIndex =
        dataSource.indexWhere((element) => _eligibleToUpdate(element, id));
    if (needUpdateIndex >= 0) {
      dataSource[needUpdateIndex].status =
          NotificationStatus.read.getTextValue();
      dataSource[needUpdateIndex].updatedAt =
          DateTime.now().millisecondsSinceEpoch;
    }
  }

  List<NotificationModel> _updateSearchList(String id) {
    List<NotificationModel>? searchData =
        (state as NotificationSearchState).notificationList;
    int needUpdateIndex =
        searchData.indexWhere((element) => _eligibleToUpdate(element, id));
    if (needUpdateIndex >= 0) {
      searchData[needUpdateIndex].status =
          NotificationStatus.read.getTextValue();
      searchData[needUpdateIndex].updatedAt =
          DateTime.now().millisecondsSinceEpoch;
    }
    return searchData;
  }

  bool _eligibleToUpdate(NotificationModel item, String id) {
    return item.id == id &&
        NotificationStatusExs.fromString(item.status) ==
            NotificationStatus.unread;
  }
}
