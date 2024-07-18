import 'dart:io';

import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/model/res_base_model.dart';
import 'package:assignment/src/utils/toast_utils.dart';
import 'package:dio/dio.dart';

class DioService {
  Dio _dio = Dio();
  String tag = '${StringConstants.appName} API:';
  CancelToken? _cancelToken;
  static final Dio mDio = Dio();

  static DioService get instance => DioService._internal();

  factory DioService({bool stripeAuth = false}) {
    return instance;
  }

  DioService._internal() {
    _dio = initApiServiceDio();
  }

  Dio initApiServiceDio() {
    _cancelToken = CancelToken();
    final baseOption = BaseOptions(
      receiveDataWhenStatusError: true,
      followRedirects: false,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      baseUrl: 'https://newsapi.org',
    );
    mDio.options = baseOption;
    final mInterceptorsWrapper = InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (e, handler) {
        return handler.next(e);
      },
      onError: (e, handler) async {
        return handler.next(e);
      },
    );
    mDio.interceptors.add(mInterceptorsWrapper);
    return mDio;
  }

  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken == null ? _cancelToken!.cancel('Cancelled') : cancelToken.cancel();
  }

  Future<Response?> get(
    String endUrl, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    void Function(JsonPayLoad)? onSuccess,
    void Function(ResBaseModel)? onError,
    bool isReturnResponse = false,
  }) async {
    return await (_dio
        .get(endUrl, queryParameters: params, cancelToken: cancelToken ?? _cancelToken, options: options)
        .then((value) {
      if (value.statusCode == HttpStatus.ok || value.statusCode == HttpStatus.created) {
        if (onSuccess != null) {
          onSuccess(value.data);
        }
      } else {
        if (onError != null) {
          onError(value.data);
        }
      }
      return value;
    })).catchError((e) async {
      if (e is DioException) {
        ToastUtils.showFailed(message: e.message??'');
      }
      throw e;
    });
  }
}
