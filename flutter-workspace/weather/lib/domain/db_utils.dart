import 'dart:convert';

import 'package:flutter_test_eberhardt/domain/sun_manager.dart';
import 'package:http/http.dart' as http;

class DBUtils {
  static const List<String> monthList = <String>[
    "Jänner",
    "Februar",
    "März",
    "April",
    "Mai",
    "Juni",
    "Juli",
    "August",
    "September",
    "Oktober",
    "November",
    "Dezember",
  ];

  static Future<List<SunManager>> getSunFromCity(
      String url, String type, String city) async {
    try {
      final response =
          await http.get(Uri.parse("$url/cities/${city}2023.json"));
      final extractedData = json.decode(response.body) != null
          ? json.decode(response.body) as List<dynamic>
          : null;

      List<SunManager> sunsetList = <SunManager>[];

      if (extractedData != null) {
        for (var element in extractedData) {
          sunsetList.add(
            SunManager(
              double.parse(((double.parse(element["Tag"])) +
                      ((monthList.indexOf(element["Monat"])) * 30))
                  .toStringAsFixed(2)),
              double.parse(timeParser(element[type]).toStringAsFixed(2)),
            ),
          );
        }
      }

      return sunsetList;
    } on Exception catch (_) {
      return <SunManager>[];
    }
  }

  static Future<List<String>> getAllCityNames(String url) async {
    try {
      List<String> cityList = <String>[];

      final response = await http.get(Uri.parse("$url/cities.json"));
      final extractedData = json.decode(response.body) != null
          ? json.decode(response.body) as Map<String, dynamic>
          : null;

      if (extractedData != null) {
        extractedData.forEach((key, value) {
          cityList.add(key.replaceAll("2023", ""));
        });
      }
      return cityList;
    } on Exception catch (_) {
      return <String>[];
    }
  }

  static double timeParser(String data) {
    return double.parse(data.split(":")[0]) +
        double.parse(data.split(":")[1]) / 60;
  }
}
