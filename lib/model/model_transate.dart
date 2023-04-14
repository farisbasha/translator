// To parse this JSON data, do
//
//     final translateModel = translateModelFromJson(jsonString);

import 'dart:convert';

TranslateModel translateModelFromJson(String str) =>
    TranslateModel.fromJson(json.decode(str));

String translateModelToJson(TranslateModel data) => json.encode(data.toJson());

class TranslateModel {
  TranslateModel({
    required this.data,
  });

  Data data;

  factory TranslateModel.fromJson(Map<String, dynamic> json) => TranslateModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.languages,
  });

  List<Language> languages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
      );

  get translations => null;

  Map<String, dynamic> toJson() => {
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
      };
}

class Language {
  Language({
    required this.language,
  });

  String language;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        language: json["language"],
      );

  get name => null;

  Map<String, dynamic> toJson() => {
        "language": language,
      };
}
