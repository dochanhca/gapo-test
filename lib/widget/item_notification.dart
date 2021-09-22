import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gapo_test/bloc/item_notification_bloc.dart';
import 'package:gapo_test/data/model/notification.dart';
import 'package:gapo_test/utils/extension.dart';
import 'package:gapo_test/values/colors.dart';
import 'package:gapo_test/values/text.dart';
import 'package:gapo_test/widget/avatar.dart';

class ItemNotification extends StatefulWidget {
  ItemNotification(Key key, this.item) : super(key: key);

  late final NotificationModel item;

  @override
  _ItemNotificationState createState() => _ItemNotificationState();
}

class _ItemNotificationState extends State<ItemNotification>
    with AfterLayoutMixin {
  late final ItemNotificationBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ItemNotificationBloc(ItemNotificationEmptyState());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _bloc.add(ReadMessageEvent(widget.item.message));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NotificationStatusExs.fromString(widget.item.status) ==
              NotificationStatus.read
          ? GapoColor.whiteColor
          : GapoColor.lightBgColor,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avatar(widget.item.image, widget.item.icon),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMessage(),
                      const SizedBox(
                        height: 4,
                      ),
                      GapoText.smallRegular(widget.item.getDisplayDate())
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_control,
              color: GapoColor.gray30Color, size: 16)
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return BlocConsumer<ItemNotificationBloc, ItemNotificationState>(
        bloc: _bloc,
        listenWhen: (previousState, currentState) {
          return true;
        },
        listener: (_, state) {},
        builder: (context, state) {
          if (state is ItemNotificationReadMessageSuccessState) {
            return Text.rich(
              TextSpan(
                  children: state.highLightTextList
                      .map((e) => TextSpan(
                            text: e.text,
                            style: e.isHighLight
                                ? GapoTextStyle.mediumBoldStyle().textStyle
                                : GapoTextStyle.mediumRegularStyle().textStyle,
                          ))
                      .toList()),
            );
          }
          return const SizedBox();
        });
  }
}
