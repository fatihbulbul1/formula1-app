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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 46, 46, 46)),
          color: const Color.fromARGB(255, 46, 46, 46)),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              dayStr,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: monthDecoration(),
              padding: const EdgeInsets.all(5),
              child: Text(
                month,
              ),
            )
          ]),
          VerticalDivider(
            color: Colors.white,
            width: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Round $round",
                style: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                (place.replaceFirst(place[0], place[0].toUpperCase()))
                    .replaceAll("_", " "),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                raceName,
                style: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
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
