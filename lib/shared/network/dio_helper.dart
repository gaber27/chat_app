import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/' ,
          receiveDataWhenStatusError: true ,
      ),
    );
  }

  static Future<Response> getDate({
    required String url ,
     Map<String, dynamic>? query ,
    String lang = 'en',
    String? token ,
  }) async
  {
      dio.options.headers={
        'lang': lang,
        'Content-Type': 'application/json',
        'Authorization': token,
      };
    return  dio.get(url , queryParameters: query,) ;
  }
  static Future<Response> postDate({
    required String url ,
    required Map<String, dynamic> data ,
    String ?token})
  {
    dio.options.headers={
      // 'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
      'lang':'en',
    };
    return dio.post(
        url,
        data: data
    );
  }
  static Future<Response> putDate({
    required String url ,
    required Map<String, dynamic> data ,
    String ?token})
  {
    dio.options.headers={
      // 'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
      'lang':'en',
    };
    return dio.put(
        url,
        data: data
    );
  }
}