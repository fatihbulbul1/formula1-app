import 'package:flutter/material.dart';

class PastRaceContainer extends StatelessWidget {
  final String raceName;
  final String round;
  final String dayStr;
  final String month;
  final String winnerName;
  final String constructorName;
  final String place;

  const PastRaceContainer({
    super.key,
    required this.raceName,
    required this.round,
    required this.dayStr,
    required this.month,
    required this.winnerName,
    required this.constructorName,
    required this.place,
  });
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromARGB(255, 46, 46, 46)),
            color: const Color.fromARGB(255, 46, 46, 46)),
        child: Column(
          children: [
            IntrinsicHeight(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dayStr,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                ),
                const VerticalDivider(
                  color: Colors.white,
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Round $round",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 211, 211, 211)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      (place.replaceFirst(place[0], place[0].toUpperCase()))
                          .replaceAll("_", " "),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      raceName,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 211, 211, 211)),
                    )
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Winner: $winnerName - $constructorName",
              style: const TextStyle(color: Colors.red),
            )
          ],
        ),
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
