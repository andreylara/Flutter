import 'package:app_agendai/core/helpers/result.dart';
import 'package:app_agendai/features/home/data/notifications_datasource.dart';
import 'package:app_agendai/features/home/models/notification.dart';

class NotificationsRepository {
  NotificationsRepository(this._datasource);

  final NotificationsDatasource _datasource;

  Future<Result<void, List<Notification>>> getNotifications(
      int page, bool read) {
    return _datasource.getNotifications(page, read);
  }

  Future<bool> markNotificationRead(String id) {
    return _datasource.markNotificationread(id);
  }
}
