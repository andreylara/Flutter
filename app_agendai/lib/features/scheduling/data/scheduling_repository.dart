import 'package:app_agendai/core/helpers/result.dart';
import 'package:app_agendai/features/scheduling/data/scheduling_datasource.dart';
import 'package:app_agendai/features/scheduling/models/scheduling.dart';

class SchedulingRepository {
  SchedulingRepository(this._datasource);

  final SchedulingDatasource _datasource;

  Future<Result<void, List<Scheduling>>> getUserSchedules() {
    return _datasource.getUserSchedules();
  }
}
