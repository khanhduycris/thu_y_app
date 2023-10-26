import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';


import '../db/db_keys_local.dart';
import 'api_path.dart';

final dio = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        print("####### Url: ${options.baseUrl}${options.path}");
        print("####### Options: ${options.data}");

        return handler.next(options);
      },
      onResponse: (Response? response, ResponseInterceptorHandler handler) {
        return handler.next(response!);
      },
      onError: (e, handler) {
        print(
            "####### error: [${e.response?.statusCode}] >> ${e.response?.data}");
        String err;
        if (e.response == null) {
          err = "Kết nối đến máy chủ thất bại.";
        } else if (e.response?.statusCode == 400) {
          err = "Lỗi cú pháp";
        } else if (e.response?.statusCode == 404) {
          err = "Không tìm thấy tài nguyên";
        } else if (e.response?.statusCode == 500) {
          err = "Có lỗi hệ thống, vui lòng thử lại";
        } else {
          err = e.response?.data['message'] ?? e.message;
        }
        return handler.next(
          DioError(
            requestOptions: e.requestOptions,
            response: e.response,
            type: e.type,
            error: err,
            message: err,
          ),
        );
      },
    ),
  );

class Api {
  static postAsync({
    required String endPoint,
    required Map<String, dynamic> req,
    bool isToken = true,
    bool hasForm = false,
  }) async {
    try {
      Map<String, dynamic> headers = Map();
      headers['Content-Type'] = "application/json";
      if (isToken) {
        var token = getStringAsync(DbKeysLocal.accessToken);
        headers['Authorization'] =
            'Bearer $token';
      }
      print(headers);
      FormData formData = FormData.fromMap(req);
      var res = await dio.post(
        ApiPath.domain + endPoint,
        data: hasForm ? formData : req,
        options: Options(
          headers: headers,
        ),
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  static getAsync({
    required String endPoint,
    bool isToken = true,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? req,
    bool hasForm = false,
  }) async {
    try {
      Map<String, dynamic> headersData = Map();
      headersData['Content-Type'] = "application/json";

      if (isToken) {
        var token = getStringAsync(DbKeysLocal.accessToken);
        headersData['Authorization'] = 'Bearer $token';
      }

      var res = await dio.get(
        ApiPath.domain + endPoint,
        options: Options(
          headers: headers ?? headersData,
        ),
        data: hasForm && req != null ? FormData.fromMap(req) : req,
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  static deleteAsync({
    required String endPoint,
    bool isToken = true,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Map<String, dynamic> headersData = Map();
      headersData['Content-Type'] = "application/json";

      if (isToken) {
        var token = getStringAsync(DbKeysLocal.accessToken);
        headersData['Authorization'] = 'Bearer $token';
      }
      var res = await dio.delete(
        ApiPath.domain + endPoint,
        options: Options(
          headers: headers ?? headersData,
        ),
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  static String checkError(error) {
    if (error is DioError) {
      return error.message ?? "Có lỗi hệ thống, vui lòng thử lại";
    } else {
      return error.toString();
    }
  }
}
