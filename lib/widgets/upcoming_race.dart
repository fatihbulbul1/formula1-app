import 'package:flutter/material.dart';

class UpcomingRaceContainer extends StatelessWidget {
  final String raceName;
  final String round;
  final String dayStr;
  final String month;
  final String place;

  const UpcomingRaceContainer({
    super.key,
    required this.raceName,
    required this.round,
    required this.dayStr,
    required this.month,
    required this.place,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 46, 46, 46)),
          color: const Color.fromARGB(255, 46, 46, 46)),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          raceContainer(),
          VerticalDivider(
            color: Colors.white,
            width: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Round 20",
                style:
                    TextStyle(color: const Color.fromARGB(255, 211, 211, 211)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Las Vegas",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Formula 1 Las Vegas GP",
                style:
                    TextStyle(color: const Color.fromARGB(255, 211, 211, 211)),
              )
            ],
          )
        ]),
      ),
    );
  }
}

BoxDecoration monthDecoration() {
  return BoxDecoration(
      color: Colors.grey,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20));
}

Column raceContainer() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text(
      "17 - 19",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 8,
    ),
    Container(
      decoration: monthDecoration(),
      padding: EdgeInsets.all(5),
      child: Text(
        "Oct",
      ),
    )
  ]);
}
