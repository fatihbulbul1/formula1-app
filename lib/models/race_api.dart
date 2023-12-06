import 'dart:convert';
import 'package:test/models/race_.dart';
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
}
