# gapo-test

1. Yêu cầu để chạy project:

 - flutter version >= 2.0.0
 - dart version >= 2.12.0

2. Để chạy mock data cho unit test:
 - Trong file locator.dart uncomment dòng code:
  ```GetIt.I.registerFactory<DataProvider>(() => DataProviderMock());```
 - Comment lại dòng:
  ```GetIt.I.registerFactory<DataProvider>(() => DataProviderImpl())```
