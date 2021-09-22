import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gapo_test/data/model/notification.dart';

abstract class DataProvider {
  Future<List<NotificationModel>?> getNotificationList();
}

class DataProviderMock implements DataProvider {
  @override
  Future<List<NotificationModel>?> getNotificationList() async {
    List<NotificationModel>? mocList = [];
    Map<String, dynamic> json = jsonDecode(
        '{\"id\":\"60c2d917dfab450023476145\",\"type\":\"gp_single\",\"title\":\"B\u00e0i vi\u1ebft m\u1edbi\",\"message\":{\"text\":\"Tin n\u1ed9i b\u1ed9 G \u0111\u00e3 \u0111\u0103ng m\u1ed9t b\u00e0i vi\u1ebft m\u1edbi trong nh\u00f3m S\u00e0o huy\u1ec7t G-Group: Anh ch\u1ecb em G-er \u01a1i,...\",\"highlights\":[{\"offset\":0,\"length\":12},{\"offset\":49,\"length\":17}]},\"image\":\"https:\/\/image-1.gapowork.vn\/images\/16ad0a91-6af4-4571-ad43-91540fa633a2.jpeg\",\"icon\":\"https:\/\/image-1.gapo.vn\/images\/icon\/new\/group2.png\",\"status\":\"unread\",\"subscription\":{\"targetId\":\"2356297600930435072\",\"targetType\":\"group\",\"targetName\":\"S\u00e0o huy\u1ec7t G-Group\",\"level\":1},\"readAt\":0,\"createdAt\":1623382295,\"updatedAt\":1623383376,\"receivedAt\":1623382295,\"imageThumb\":\"https:\/\/image-1.gapowork.vn\/images\/16ad0a91-6af4-4571-ad43-91540fa633a2.jpeg\",\"animation\":\"\",\"tracking\":\"{\\"target\\":{\\"type\\":3,\\"user_id\\":1373985360,\\"group_id\\":\\"2356297600930435072\\"}}\",\"subjectName\":\"Tin n\u1ed9i b\u1ed9 G\",\"isSubscribed\":true}');

    mocList.add(NotificationModel.fromJson(json));
    return mocList;
  }
}

class DataProviderImpl implements DataProvider {
  @override
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
