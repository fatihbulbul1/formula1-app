import 'dart:convert';

Race raceFromJson(String str) => Race.fromJson(json.decode(str));

String raceToJson(Race data) => json.encode(data.toJson());

class Race {
  MrData mrData;

  Race({
    required this.mrData,
  });

  factory Race.fromJson(Map<String, dynamic> json) => Race(
        mrData: MrData.fromJson(json["MRData"]),
      );

  Map<String, dynamic> toJson() => {
        "MRData": mrData.toJson(),
      };
}

class MrData {
  String xmlns;
  String series;
  String limit;
  String offset;
  String total;
  RaceTable raceTable;

  MrData({
    required this.xmlns,
    required this.series,
    required this.limit,
    required this.offset,
    required this.total,
    required this.raceTable,
  });

  factory MrData.fromJson(Map<String, dynamic> json) => MrData(
        xmlns: json["xmlns"],
        series: json["series"],
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
        raceTable: RaceTable.fromJson(json["RaceTable"]),
      );

  Map<String, dynamic> toJson() => {
        "xmlns": xmlns,
        "series": series,
        "limit": limit,
        "offset": offset,
        "total": total,
        "RaceTable": raceTable.toJson(),
      };
}

class RaceTable {
  String season;
  List<RaceElement> races;

  RaceTable({
    required this.season,
    required this.races,
  });

  factory RaceTable.fromJson(Map<String, dynamic> json) => RaceTable(
        season: json["season"],
        races: List<RaceElement>.from(
            json["Races"].map((x) => RaceElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "season": season,
        "Races": List<dynamic>.from(races.map((x) => x.toJson())),
      };
}

class RaceElement {
  String season;
  String round;
  String url;
  String raceName;
  Circuit circuit;
  DateTime date;
  String time;
  FirstPractice firstPractice;
  FirstPractice secondPractice;
  FirstPractice thirdPractice;
  FirstPractice qualifying;

  RaceElement({
    required this.season,
    required this.round,
    required this.url,
    required this.raceName,
    required this.circuit,
    required this.date,
    required this.time,
    required this.firstPractice,
    required this.secondPractice,
    required this.thirdPractice,
    required this.qualifying,
  });

  factory RaceElement.fromJson(Map<String, dynamic> json) => RaceElement(
        season: json["season"],
        round: json["round"],
        url: json["url"],
        raceName: json["raceName"],
        circuit: Circuit.fromJson(json["Circuit"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
        firstPractice: FirstPractice.fromJson(json["FirstPractice"]),
        secondPractice: FirstPractice.fromJson(json["SecondPractice"]),
        thirdPractice: FirstPractice.fromJson(json["ThirdPractice"]),
        qualifying: FirstPractice.fromJson(json["Qualifying"]),
      );

  Map<String, dynamic> toJson() => {
        "season": season,
        "round": round,
        "url": url,
        "raceName": raceName,
        "Circuit": circuit.toJson(),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "FirstPractice": firstPractice.toJson(),
        "SecondPractice": secondPractice.toJson(),
        "ThirdPractice": thirdPractice.toJson(),
        "Qualifying": qualifying.toJson(),
      };
}

class Circuit {
  String circuitId;
  String url;
  String circuitName;
  Location location;

  Circuit({
    required this.circuitId,
    required this.url,
    required this.circuitName,
    required this.location,
  });

  factory Circuit.fromJson(Map<String, dynamic> json) => Circuit(
        circuitId: json["circuitId"],
        url: json["url"],
        circuitName: json["circuitName"],
        location: Location.fromJson(json["Location"]),
      );

  Map<String, dynamic> toJson() => {
        "circuitId": circuitId,
        "url": url,
        "circuitName": circuitName,
        "Location": location.toJson(),
      };
}

class Location {
  String lat;
  String long;
  String locality;
  String country;

  Location({
    required this.lat,
    required this.long,
    required this.locality,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        long: json["long"],
        locality: json["locality"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
        "locality": locality,
        "country": country,
      };
}

class FirstPractice {
  DateTime date;
  String time;

  FirstPractice({
    required this.date,
    required this.time,
  });

  factory FirstPractice.fromJson(Map<String, dynamic> json) => FirstPractice(
        date: DateTime.parse(json["date"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
      };
}
