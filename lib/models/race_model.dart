class Race {
  final String raceName;
  final String round;
  final String dayStr;
  final String month;
  final String winnerName;
  final String constructorName;
  final String place;

  Race({
    required this.raceName,
    required this.round,
    required this.dayStr,
    required this.month,
    required this.winnerName,
    required this.constructorName,
    required this.place,
  });

  factory Race.fromJson(dynamic json) {
    final List months = [
      "-",
      "-",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC"
    ];
    var date = json["date"];
    date = date.split("-");
    var month = months[int.parse(date[1])];
    var day = int.parse(date[2]);
    String dayStr;
    if (day < 10) {
      dayStr = "0$day";
    } else {
      dayStr = day.toString();
    }
    var winnerName = json["Results"][0]["Driver"]["givenName"];
    var winnerSrame = json["Results"][0]["Driver"]["familyName"];
    var place = json["Circuit"]["circuitId"];
    return Race(
        raceName: json["raceName"],
        round: json["round"],
        dayStr: dayStr,
        month: month,
        winnerName: "$winnerName $winnerSrame",
        constructorName: json["Results"][0]["Constructor"]["name"],
        place: place);
  }
  static List<Race> raceFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Race.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Race {$raceName}, $round, $dayStr, $month, $winnerName, $constructorName';
  }
}
