import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class Results {
  final List<Result> results;

  const Results({required this.results});
}

// Convert respone into dart class
class Result {
  final String position;
  final String points;
  final Driver driver;
  final Constructor constructor;
  final String fastestLap;
  final String status;

  const Result(
      {required this.position,
      required this.points,
      required this.driver,
      required this.constructor,
      required this.fastestLap,
      required this.status});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        position: json['position'],
        points: json['points'],
        fastestLap: json['FastestLap']['Time']['time'],
        driver: Driver.fromJson(json['Driver']),
        constructor: Constructor.fromJson(json['Constructor']),
        status: json['status']);
  }
}

class Driver {
  final String code;
  final String name;

  const Driver({required this.code, required this.name});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
        code: json['code'], name: json['givenName'] + ' ' + json['familyName']);
  }
}

class Constructor {
  final String name;

  const Constructor({required this.name});

  factory Constructor.fromJson(Map<String, dynamic> json) {
    return Constructor(name: json['name']);
  }
}

Future<List<Result>> fetchResult() async {
  var dio = Dio();
  const url = 'http://ergast.com/api/f1/current/last/results.json';
  dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);
  final response = await dio.get(url,
      options: buildCacheOptions(const Duration(minutes: 5)));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = response.data;
    var allPositions = data["MRData"]["RaceTable"]["Races"][0]["Results"];
    var results = <Result>[];
    allPositions.forEach((value) {
      results.add(Result.fromJson(value));
    });
    return results;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load result');
  }
}
