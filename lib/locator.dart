import 'package:gapo_test/data/repository/notification_repo.dart';
import 'package:gapo_test/data/source/data_provider.dart';
import 'package:get_it/get_it.dart';

void setUpLocator() {
  GetIt.I.registerFactory<DataProvider>(() => DataProvider());
  GetIt.I.registerFactory<NotificationRepo>(() => NotificationRepoImpl());
}