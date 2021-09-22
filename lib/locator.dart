import 'package:gapo_test/data/repository/notification_repo.dart';
import 'package:gapo_test/data/source/data_provider.dart';
import 'package:get_it/get_it.dart';

void setUpLocator() {
  // Mock Data for run unit test
  // GetIt.I.registerFactory<DataProvider>(() => DataProviderMock());

  // Real Data
  GetIt.I.registerFactory<DataProvider>(() => DataProviderImpl());

  GetIt.I.registerFactory<NotificationRepo>(() => NotificationRepoImpl());
}