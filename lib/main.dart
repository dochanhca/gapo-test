import 'package:flutter/material.dart';
import 'package:gapo_test/locator.dart';

import 'app.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}



