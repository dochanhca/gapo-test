import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gapo_test/data/model/notification.dart';

class DataProvider {
  Future<List<NotificationModel>?> getNotificationList() async {
    dynamic json = await _parseJsonFromAssets('assets/noti.json');
    return _getTransactionListTransform(json);
  }

  List<NotificationModel>? _getTransactionListTransform(dynamic json) {
    List<dynamic> data = json['data'];
    List<NotificationModel>? listData = data
        .skipWhile((value) => value == null)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
    return listData;
  }
}

dynamic _parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return await rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}
