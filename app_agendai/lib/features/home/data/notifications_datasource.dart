import 'package:app_agendai/core/helpers/result.dart';
import 'package:app_agendai/features/home/models/notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Notification;

class NotificationsDatasource {
  NotificationsDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, List<Notification>>> getNotifications(
      int page, bool read) async {
    try {
      final response = await _dio
          .post('/get-notifications', data: {'page': page, 'read': read});
      return Success(response.data['result']
          .map<Notification>((s) => Notification.fromJson(s))
          .toList());
    } catch (e) {
      debugPrint('ERROR $e');
      return const Failure(null);
    }
  }

  Future<bool> markNotificationread(String id) async {
    try {
      await _dio.post('/mark-notification-read', data: {
        'notificationId': id,
      });
      return true;
    } catch (e) {
      debugPrint('ERROR $e');
      return false;
    }
  }
}
