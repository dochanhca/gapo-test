import 'package:gapo_test/data/model/notification.dart';
import 'package:gapo_test/data/source/data_provider.dart';
import 'package:get_it/get_it.dart';

abstract class NotificationRepo {
  Future<List<NotificationModel>?> getNotificationList();
}

class NotificationRepoImpl implements NotificationRepo {
  final DataProvider _provider = GetIt.I.get<DataProvider>();

  @override
  Future<List<NotificationModel>?> getNotificationList() {
    return _provider.getNotificationList();
  }
}
