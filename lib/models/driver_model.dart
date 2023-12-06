class Driver {
  final String position;
  final String points;
  final String wins;
  final String number;
  final String name;
  final String surname;
  final String constructorName;

  Driver({
    required this.position,
    required this.points,
    required this.wins,
    required this.number,
    required this.name,
    required this.surname,
    required this.constructorName,
  });

  factory Driver.fromJson(dynamic json) {
    var position = json["position"];
    var points = json["points"];
    var wins = json["wins"];
    var number = json["Driver"]["permanentNumber"];
    var nname = json["Driver"]["givenName"];
    var srname = json["Driver"]["familyName"];
    var constructor = json["Constructors"][0]["name"];

    return Driver(
        position: position,
        points: points,
        wins: wins,
        number: number,
        name: nname,
        surname: srname,
        constructorName: constructor);
  }
  static List<Driver> raceFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Driver.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Race $position, $points, $wins, $number, $name, $constructorName';
  }
}
