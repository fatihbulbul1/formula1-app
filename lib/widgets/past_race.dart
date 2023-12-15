import 'package:flutter/material.dart';
import 'package:test/pages/r.dart';

class PastRaceContainer extends StatelessWidget {
  final String raceName;
  final String round;
  final String dayStr;
  final String month;
  final String winnerName;
  final String constructorName;
  final String place;

  PastRaceContainer({
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
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color.fromARGB(255, 46, 46, 46)),
            color: Color.fromARGB(255, 46, 46, 46)),
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
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: monthDecoration(),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            month,
                          ),
                        )
                      ]),
                ),
                VerticalDivider(
                  color: Colors.white,
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Round $round",
                      style:
                          TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      (place.replaceFirst(place[0], place[0].toUpperCase()))
                          .replaceAll("_", " "),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      raceName,
                      style:
                          TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
                    )
                  ],
                )
              ]),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Winner: $winnerName - $constructorName",
              style: TextStyle(color: Colors.red),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => R(
                              round: round,
                              raceName: raceName,
                            )),
                  );
                },
                child: Text("See Results"))
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
