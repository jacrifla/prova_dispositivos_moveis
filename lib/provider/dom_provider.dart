import 'package:dio/dio.dart';

class DominioProvider {
  Dio dio = Dio();

  initDio() {
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Map<String, dynamic>?> getDominioApi(String dominio) async {
    try {
      final url = 'https://brasilapi.com.br/api/registrobr/v1/$dominio';

      final response = await dio.get(url);
      // print('RESPONSE: ${response.data}');
      return response.data;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
