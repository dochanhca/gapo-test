import 'package:flutter_test/flutter_test.dart';
import 'package:gapo_test/locator.dart';
import 'package:get_it/get_it.dart';
import 'package:gapo_test/data/source/data_provider.dart';
import 'package:gapo_test/data/repository/notification_repo.dart';

main() {
  setUpAll(() {
    setUpLocator();
  });

  group('Locator', () {

    test('DataProvider not null', () {
      expect(GetIt.I<DataProvider>(), isNotNull);
    });

    test('NotificationRepo not null', () {
      expect(GetIt.I<NotificationRepo>(), isNotNull);
    });
  });
}