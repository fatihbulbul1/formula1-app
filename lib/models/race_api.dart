import 'dart:convert';
import 'package:test/models/constructor_model.dart';
import 'package:test/models/driver_model.dart';
import 'package:test/models/race_model.dart';
import 'package:http/http.dart' as http;

class RaceApi {
  static Future<List<Race>> getRace() async {
    var uri = Uri.https("ergast.com", "api/f1/2023/results/1.json");
    final response = await http.get(uri);
    Map data = jsonDecode(response.body);
    List temp = [];
    for (var i in data["MRData"]["RaceTable"]["Races"]) {
      temp.add(i);
    }
    return Race.raceFromSnapshot(temp);
  }

  static Future<List<Driver>> getDrivers() async {
    var uri = Uri.https("ergast.com", "api/f1/2023/driverStandings.json");
    final response = await http.get(uri);
    Map data = jsonDecode(response.body);
    List temp = [];
    for (var i in data["MRData"]["StandingsTable"]["StandingsLists"][0]
        ["DriverStandings"]) {
      temp.add(i);
    }
    return Driver.raceFromSnapshot(temp);
  }

  static Future<List<Constructor>> getConstructors() async {
    var uri = Uri.https("ergast.com", "api/f1/2023/constructorStandings.json");
    final response = await http.get(uri);
    Map data = jsonDecode(response.body);
    List temp = [];
    for (var i in data["MRData"]["StandingsTable"]["StandingsLists"][0]
        ["ConstructorStandings"]) {
      temp.add(i);
    }
    return Constructor.raceFromSnapshot(temp);
  }
}
