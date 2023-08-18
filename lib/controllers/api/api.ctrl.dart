// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class ApiHanlder {
  static const HANET_API_URL = "https://partner.hanet.ai";
  static final Dio _api = Dio(
    BaseOptions(
      baseUrl: HANET_API_URL,
      contentType: Headers.formUrlEncodedContentType,
      validateStatus: (status) {
        return (status ?? 400) <= 400;
      },
    ),
  );

  static Future<Response> get(String path,
      {Map<String, dynamic>? params}) async {
    return await _api.get(path, queryParameters: params);
  }

  static Future<Response> post(
    String path, {
    Map<String, dynamic>? params,
    Object? body,
  }) async {
    return await _api.post(path, queryParameters: params, data: body);
  }
}
