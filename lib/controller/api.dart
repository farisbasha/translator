import 'package:dio/dio.dart';

class Translate {
  static Future<String> getdata(
      {required String text,
      required String targetLang,
      String? sourceLang}) async {
    var headers = {
      'X-RapidAPI-Key': 'API_KEY!!!', //! API KEY HERE
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
      'content-type': 'application/x-www-form-urlencoded',
    };

    final _dio = Dio(
      BaseOptions(
        baseUrl: 'https://google-translate1.p.rapidapi.com',
        headers: headers,
      ),
    );

    try {
      final _response = await _dio.post(
        '/language/translate/v2',
        data: {'q': text, 'target': targetLang, 'source': sourceLang ?? ""},
      );

      if (_response.statusCode == 200) {
        final _data = _response.data;
        return _data['data']['translations'][0]['translatedText'];
      } else {
        throw Exception('Failed To Transalte');
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
