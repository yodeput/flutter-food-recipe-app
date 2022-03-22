import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = new CancelToken();

  HttpUtil._internal() {
    late String _baseUrl;
    if (dotenv.env['BASE_URL'] != null) {
      _baseUrl = dotenv.env['BASE_URL']!;
    }

    // BaseOptions、Options、RequestOptions
    BaseOptions options = new BaseOptions(
      // API ENDPOINT
      baseUrl: _baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = new Dio(options);

    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(HttpFormatter());
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        Loading.dismiss();
        ErrorEntity eInfo = createErrorEntity(e);
        onError(eInfo);
        return handler.next(e); //continue
      },
    ));
  }

  /*
   * error
   */

  void onError(ErrorEntity eInfo) {
    print('error.code -> ' +
        eInfo.code.toString() +
        ', error.message -> ' +
        eInfo.message);
    switch (eInfo.code) {
      case 401:
        EasyLoading.showError(eInfo.message);
        break;
      default:
        EasyLoading.showError('Something Wrong');
        break;
    }
  }

  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "Request Canceled");
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -1, message: "Connection Timeout");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "Request Timeout");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "Response Timeout");
      case DioErrorType.response:
        {
          try {
            int errCode =
            error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "Bad Request");
              case 401:
                return ErrorEntity(code: errCode, message: "Unauthenticated");
              case 403:
                return ErrorEntity(code: errCode, message: "Forbidden");
              case 404:
                return ErrorEntity(code: errCode, message: "Not Found");
              case 405:
                return ErrorEntity(
                    code: errCode, message: "Method Not Allowed");
              case 500:
                return ErrorEntity(
                    code: errCode, message: "Internal Server Error");
              case 502:
                return ErrorEntity(code: errCode, message: "Bad Gateway");
              case 503:
                return ErrorEntity(
                    code: errCode, message: "Service Unavailable");
              case 505:
                return ErrorEntity(
                    code: errCode, message: "HTTP Version Not Supported");
              default:
                {
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "Something Wrong");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }


  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  // SET TOKEN
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    // headers['Authorization'] = 'Bearer ${UserStore.to.token}';

    return headers;
  }

  // GET
  Future get(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    if (requestOptions.extra == null) {
      requestOptions.extra = Map();
    }
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  // POST
  Future post(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  // PUT
  Future put(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  // PATCH
  Future patch(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  // DELETE
  Future delete(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  // POST FORM
  Future postForm(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

// Exception Handling
class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
