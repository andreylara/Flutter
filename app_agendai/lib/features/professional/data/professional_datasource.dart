import 'package:app_agendai/core/helpers/result.dart';
import 'package:app_agendai/features/professional/models/professional_details.dart';
import 'package:app_agendai/features/professional/models/rating.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProfessionalDatasource {
  ProfessionalDatasource(this._dio);

  final Dio _dio;

  Future<Result<void, ProfessionalDetails>> getProfessional(
      {required String id}) async {
    try {
      final response =
          await _dio.post('/get-professional', data: {'professionalId': id});
      return Success(ProfessionalDetails.fromMap(response.data['result']));
    } catch (e) {
      debugPrint('$e');
      return const Failure(null);
    }
  }

  Future<Result<void, List<Rating>>> getProfessionalRatings({
    required String professionalId,
    required int itemsPerPage,
    required int page,
  }) async {
    try {
      final response = await _dio.post(
        '/get-professional-ratings',
        data: {
          'professionalId': professionalId,
          'page': page,
          'limit': itemsPerPage,
        },
      );

      final ratings = response.data['result']
          .map<Rating>((s) => Rating.fromMap(s))
          .toList();
      return Success(ratings);
    } catch (e) {
      debugPrint('$e');
      return const Failure(null);
    }
  }
}
