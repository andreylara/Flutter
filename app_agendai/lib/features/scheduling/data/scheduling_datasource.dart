import 'package:app_agendai/core/helpers/result.dart';
import 'package:app_agendai/features/scheduling/models/scheduling.dart';
import 'package:dio/dio.dart';

class SchedulingDatasource {
  SchedulingDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, List<Scheduling>>> getUserSchedules() async {
    try {
      final response = await _dio.post('/get-user-schedules');
      return Success(response.data['result']
          .map<Scheduling>((s) => Scheduling.fromMap(s))
          .toList());
    } catch (e) {
      return const Failure(null);
    }
  }
}
