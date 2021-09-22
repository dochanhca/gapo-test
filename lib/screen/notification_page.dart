import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gapo_test/bloc/notification_bloc.dart';
import 'package:gapo_test/data/model/notification.dart';
import 'package:gapo_test/values/colors.dart';
import 'package:gapo_test/values/text.dart';
import 'package:gapo_test/widget/item_notification.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AfterLayoutMixin {
  late NotificationBloc _bloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = NotificationBloc(NotificationEmptyState());
    _searchController.addListener(() {
      _search(_searchController.value.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _bloc.add(LoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: GapoColor.grayBgColor,
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: BlocConsumer<NotificationBloc, NotificationState>(
          bloc: _bloc,
          listenWhen: (previousState, currentState) {
            return true;
          },
          listener: (_, state) {},
          builder: (_, state) {
            if (state is NotificationSearchState) {
              return _appBarWithSearch();
            }
            return _appBarWithoutSearch();
          }),
      centerTitle: false,
      backgroundColor: GapoColor.whiteColor,
      elevation: 0,
      brightness: Brightness.light,
    );
  }

  Widget _appBarWithSearch() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: GapoColor.gray30Color,
          ),
          iconSize: 32,
          onPressed: () => _bloc.add(CancelSearchEvent()),
        ),
        Expanded(
          child: TextField(
            maxLines: 1,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                isDense: true,
                filled: true,
                fillColor: GapoColor.searchBgColor,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                hintText: 'Tìm kiếm',
                prefixIcon: Icon(Icons.search,
                    color: GapoColor.lightTextColor, size: 24),
                suffixIcon: BlocConsumer<NotificationBloc, NotificationState>(
                    bloc: _bloc,
                    listenWhen: (previousState, currentState) {
                      return true;
                    },
                    listener: (_, state) {},
                    builder: (_, state) {
                      if (state is NotificationSearchState &&
                          state.textSearch != null &&
                          state.textSearch!.isNotEmpty) {
                        return IconButton(
                            icon: Icon(Icons.highlight_remove_rounded,
                                color: GapoColor.lightTextColor),
                            onPressed: () => _searchController.clear());
                      }
                      return const SizedBox();
                    })),
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: _search,
          ),
        ),
      ],
    );
  }

  Widget _appBarWithoutSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GapoText.h1Bold('Thông báo'),
        IconButton(
            icon: Icon(
              Icons.search,
              color: GapoColor.normalTextColor,
            ),
            iconSize: 32,
            onPressed: () => _bloc.add(StartSearchEvent()))
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: BlocConsumer<NotificationBloc, NotificationState>(
              bloc: _bloc,
              listenWhen: (previousState, currentState) {
                return true;
              },
              listener: (_, state) {},
              builder: (_, state) {
                if (state is NotificationLoadDataState) {
                  return Center(
                      child: GapoText.mediumBold('Đang tải dữ liệu...'));
                } else if (state is NotificationLoadDataSuccessState) {
                  List<NotificationModel> data = state.notificationList;
                  return ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _bloc
                            .add(UpdateNotificationStatusEvent(data[index].id)),
                        child:
                            ItemNotification(Key(data[index].id), data[index])),
                    itemCount: data.length,
                  );
                } else if (state is NotificationLoadDataFailureState) {
                  return Center(child: GapoText.mediumBold(state.errorMessage));
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }

  _search(String text) {
    _bloc.add(SearchEvent(text));
  }
}
