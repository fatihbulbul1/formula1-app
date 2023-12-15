class Drivers {
  final String driverName;
  final String position;
  final String points;
  final String constructorName;

  Drivers({
    required this.driverName,
    required this.position,
    required this.points,
    required this.constructorName,
  });

  factory Drivers.fromJson(dynamic json) {
    var driverName =
        json["Driver"]["givenName"] + " " + json["Driver"]["familyName"];
    var position = json["position"];
    var points = json["points"];
    var constructorName = json["Constructor"]["name"];

    return Drivers(
        driverName: driverName,
        points: points,
        position: position,
        constructorName: constructorName);
  }
  static List<Drivers> driverFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Drivers.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Race $position, $points, $driverName $constructorName';
  }
}
