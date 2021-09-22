import 'package:intl/intl.dart';
import 'package:gapo_test/data/model/notification.dart';

extension NotificationModelExs on NotificationModel {
  String getDisplayDate() {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(this.createdAt * 1000);
    final DateFormat output = DateFormat('dd/MM/yyyy, hh:mm');
    return output.format(date);
  }
}
