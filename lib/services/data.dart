import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class Results {
  final List<Result> results;

  const Results({required this.results});
}

class Result {
  final String position;
  final String points;
  final Driver? driver;
  final Constructor? constructor;
  final String? fastestLap;
  final String? status;

  const Result(
      {required this.position,
      required this.points,
      this.driver,
      this.constructor,
      this.fastestLap,
      this.status});

  factory Result.fromJson(Map<String, dynamic> json, String type) {
    if (type == 'raceResult') {
      return Result(
          position: json['position'],
          points: json['points'],
          fastestLap: json['FastestLap']['Time']['time'],
          driver: Driver.fromJson(json['Driver']),
          constructor: Constructor.fromJson(json['Constructor']),
          status: json['status']);
    } else if (type == 'driversChampionship') {
      return Result(
          position: json['position'],
          points: json['points'],
          driver: Driver.fromJson(json['Driver']),
          constructor: Constructor.fromJson(json['Constructors'][0]));
    } else if (type == 'constructorsChampionship') {
      return Result(
          position: json['position'],
          points: json['points'],
          constructor: Constructor.fromJson(json['Constructor']));
    }
    return Result.fromJson(json, type);
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
    var data = response.data;
    var allPositions = data["MRData"]["RaceTable"]["Races"][0]["Results"];
    var results = <Result>[];
    allPositions.forEach((value) {
      results.add(Result.fromJson(value, 'raceResult'));
    });
    return results;
  } else {
    throw Exception('Failed to load result');
  }
}

Future<List<Result>> fetchDriversChampResult() async {
  var dio = Dio();
  const url = 'http://ergast.com/api/f1/current/driverStandings.json';
  dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);
  final response = await dio.get(url,
      options: buildCacheOptions(const Duration(minutes: 5)));

  if (response.statusCode == 200) {
    var data = response.data;
    var allPositions = data["MRData"]["StandingsTable"]["StandingsLists"][0]
        ["DriverStandings"];
    var results = <Result>[];
    allPositions.forEach((value) {
      results.add(Result.fromJson(value, 'driversChampionship'));
    });
    return results;
  } else {
    throw Exception('Failed to load result');
  }
}

Future<List<Result>> fetchConstructorsChampResult() async {
  var dio = Dio();
  const url = 'http://ergast.com/api/f1/current/constructorStandings.json';
  dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);
  final response = await dio.get(url,
      options: buildCacheOptions(const Duration(minutes: 5)));

  if (response.statusCode == 200) {
    var data = response.data;
    var allPositions = data["MRData"]["StandingsTable"]["StandingsLists"][0]
        ["ConstructorStandings"];
    var results = <Result>[];
    allPositions.forEach((value) {
      results.add(Result.fromJson(value, 'constructorsChampionship'));
    });
    return results;
  } else {
    throw Exception('Failed to load result');
  }
}
