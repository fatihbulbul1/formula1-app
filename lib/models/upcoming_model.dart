class URace {
  final String raceName;
  final String round;
  final String dayStr;
  final String month;
  final String place;

  URace({
    required this.raceName,
    required this.round,
    required this.dayStr,
    required this.month,
    required this.place,
  });

  factory URace.fromJson(dynamic json) {
    final List months = [
      "-",
      "JAN",
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
    var place = json["Circuit"]["circuitId"];
    return URace(
        raceName: json["raceName"],
        round: json["round"],
        dayStr: dayStr,
        month: month,
        place: place);
  }
  static List<URace> raceFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return URace.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'URace {$raceName}, $round, $dayStr, $month';
  }
}
