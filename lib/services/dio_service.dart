
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn_dio/server/api.dart';
class DioService{

  static BaseOptions _options = BaseOptions();
  static Dio _dio = Dio();

  static Dio init(){
    _options = BaseOptions(
      baseUrl: ApiServer.baseUrl,
      connectTimeout: ApiServer.connectTimeout,
      receiveTimeout: ApiServer.receiveTimeout,
      headers: ApiServer.headers,
      responseType: ResponseType.json,
      validateStatus: (statusCode) => statusCode! <= 205,
    );
    _dio = Dio(_options);
    return _dio;
  }

  static Future<String?> get(BuildContext context, String api, [Map<String, dynamic> param = const <String, dynamic>{}])async{
    try{
      final Response response = await init().get(api, queryParameters: param);
      return jsonEncode(response.data);
    } on DioException catch(e){
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
      log(e.message.toString());
      return null;
    }
  }

  static Future<String?> post(BuildContext context, String api, Map<String, dynamic> data, [Map<String, dynamic> param = const <String, dynamic>{}])async{
    try{
      final Response response = await init().post(api, queryParameters: param, data: data);
      return jsonEncode(response.data);
    } on DioException catch(e){
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
      log(e.message.toString());
      return null;
    }
  }


  static Future<List<String?>> postAndGet(BuildContext context, {required String apiForPost, required Map<String, dynamic> dataForPost, required String apiForGet})async{
    try{
      final response = await Future.wait([post(context, apiForPost, dataForPost), get(context, apiForGet)]);
      List<String?> list = [];
      response.forEach((element) {
        list.add(element);
      });
      return list;
    }catch(e){
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
      return [];
    }
  }




}