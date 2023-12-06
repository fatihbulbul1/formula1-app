class Constructor {
  final String position;
  final String points;
  final String wins;
  final String name;

  Constructor({
    required this.position,
    required this.points,
    required this.wins,
    required this.name,
  });

  factory Constructor.fromJson(dynamic json) {
    var position = json["position"];
    var points = json["points"];
    var wins = json["wins"];
    var nname = json["Constructor"]["name"];

    return Constructor(
      position: position,
      points: points,
      wins: wins,
      name: nname,
    );
  }
  static List<Constructor> raceFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Constructor.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Race $position, $points, $wins $name';
  }
}
