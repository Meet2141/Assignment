import 'package:assignment/src/constants/endpoint_constants.dart';
import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/features/home/model/res_home_model.dart';
import 'package:assignment/src/model/res_base_model.dart';
import 'package:assignment/src/service/dio_service.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final ApiService instance = ApiService._internal();

  factory ApiService() {
    return instance;
  }

  ApiService._internal();

  JsonPayLoad getErrorModel(DioException error) {
    /// Set for unknown OneByteString error logged on sentry.
    JsonPayLoad? responseData;
    if (error.response?.data == null || error.response?.data is Map<String, dynamic>) {
      responseData = error.response?.data;
    }

    ResBaseModel baseModel = ResBaseModel.fromJson(responseData ??
        {
          'status': '${error.response?.statusCode}',
          'code': error.response?.statusCode,
          'message': error.response?.statusMessage,
          'detail': error.response?.data,
          'error': error.error.toString(),
          'error_type': error.type.toString(),
        });
    return baseModel.toJson();
  }

  /// Get Home API
  Future<ResHomeModel?> getHomeAPI({required String code}) async {
    try {
      final response = await DioService.instance.get('${EndpointConstants.home}&country=$code');
      return response?.data != null ? ResHomeModel.fromJson(response?.data) : null;
    } on DioException catch (error) {
      throw getErrorModel(error);
    }
  }
}
