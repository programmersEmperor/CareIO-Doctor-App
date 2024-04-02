import 'dart:async';
import 'dart:io';

import 'package:careio_doctor_version/Services/Api/base/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

class BaseApi {
  late Dio _dio;
  final String _apiVersion = 'v1';
  BaseApi() {
    _dio = _configureClient();
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  Dio _configureClient() {
    Dio client = Dio();

    client.options = BaseOptions(
      baseUrl: 'https://api.careio.app/api/$_apiVersion/app/doctors/',
    );
    client.interceptors.add(ApiInterceptors());
    client.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (o) => debugPrint(o.toString())));
    return client;
  }

  Future<Response> getRequest(
      {required String url, Map<String, dynamic>? params}) async {
    Response response = await _dio.get(url, queryParameters: params ?? {});
    return response;
  }

  Future<Response> postRequest({required url, required dynamic body, Map<String, dynamic>? params }) async {
    Response response = await _dio.post(url, data: body, queryParameters: params);
    return response;
  }

  Future<Response> putRequest({required url, required dynamic body}) async {
    Response response = await _dio.put(url, data: body);
    return response.data;
  }
}
