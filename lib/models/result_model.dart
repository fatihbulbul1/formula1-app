import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  String raceName;
  List<ResultElement> results;

  Result({
    required this.raceName,
    required this.results,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        raceName: json["raceName"],
        results: List<ResultElement>.from(
            json["Results"].map((x) => ResultElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "raceName": raceName,
        "Results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultElement {
  String driverName;
  String position;
  String points;
  String constructorName;

  ResultElement({
    required this.driverName,
    required this.position,
    required this.points,
    required this.constructorName,
  });

  factory ResultElement.fromJson(Map<String, dynamic> json) => ResultElement(
        driverName: json["driverName"],
        position: json["position"],
        points: json["points"],
        constructorName: json["constructorName"],
      );

  Map<String, dynamic> toJson() => {
        "driverName": driverName,
        "position": position,
        "points": points,
        "constructorName": constructorName,
      };
}
