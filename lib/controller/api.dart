import 'package:dio/dio.dart';

const API_KEY = "API_KEY";
const headers = {
  'X-RapidAPI-Key': API_KEY, //! API KEY HERE
  'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
  'content-type': 'application/x-www-form-urlencoded',
};

final _dio = Dio(
  BaseOptions(
    baseUrl: 'https://google-translate1.p.rapidapi.com',
    headers: headers,
  ),
);

class Translate {
  static Future<List<String>> getLanguages() async {
    try {
      final _response = await _dio.get(
        '/language/translate/v2/languages',
      );

      if (_response.statusCode == 200) {
        final _data = _response.data;
        return _data['data']['languages']
            .map<String>((e) => e['language'].toString())
            .toList();
      } else {
        throw Exception('Failed To Get Languages');
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> getdata(
      {required String text,
      required String targetLang,
      String? sourceLang}) async {
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
