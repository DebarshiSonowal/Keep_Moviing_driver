
import 'package:dio/dio.dart';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Dio dio;

  BaseOptions option =
  BaseOptions(connectTimeout: 10000, receiveTimeout: 10000, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });

  Future login(String number) async {
    dio = Dio(option);
    try {
      Response response = await dio.post(url, data: {'phone': number});
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }





}