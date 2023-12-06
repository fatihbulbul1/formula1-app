import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
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
  Future getNextRace() async {
    var response = await http.get(Uri.https("ergast.com", "api/f1/2019.json"));
    var jsonData = jsonDecode(response.body);
    var date = jsonData["MRData"]["RaceTable"]["Races"][0]["date"]
        .replaceFirst("2019", "2024");
    var time = jsonData["MRData"]["RaceTable"]["Races"][0]["time"];
    var round = jsonData["MRData"]["RaceTable"]["Races"][0]["round"];
    var raceName = jsonData["MRData"]["RaceTable"]["Races"][0]["raceName"];
    String strDate = jsonData["MRData"]["RaceTable"]["Races"][0]["date"]
        .replaceFirst("2019", "2024");
    var raceDay = strDate.split("-");

    DateTime now = DateTime.now();
    DateTime targetDateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse("$date $time");

    Duration difference = targetDateTime.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours - (days * 24);
    int minutes = difference.inMinutes - (days * 24 * 60) - (hours * 60);

    String strDays = days.toString();
    String strHours = hours.toString();
    String strMinutes = minutes.toString();

    if (days < 10) {
      strDays = "0$strDays";
    }
    if (hours < 10) {
      strHours = "0$strHours";
    }
    if (minutes < 10) {
      strMinutes = "0$strMinutes";
    }
    List remaining = [];
    remaining.add(strDays);
    remaining.add(strHours);
    remaining.add(strMinutes);
    remaining.add(raceName);
    remaining.add("${"${"Round " +
        round} | ${raceDay[2]} " +
        months[int.parse(raceDay[1])]} ${raceDay[0]}");
    return remaining;
  }

  @override
  Widget build(BuildContext context) {
    getNextRace();
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // RaceNameContainer(),
      // TimerContainer2(),
      Top(),
      const SizedBox(
        height: 20,
      ),
      Text(
        "Latest News".toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      const SizedBox(
        height: 10,
      ),
      const Divider(
        height: 0,
        color: Colors.white,
        thickness: 1,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
        child: Column(
          children: [
            tweetContainer(),
          ],
        ),
      )
    ]));
  }

  Container tweetContainer() {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 56, 56, 56),
          border: Border.all(color: const Color.fromARGB(255, 56, 56, 56)),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  twitPicture(),
                  const SizedBox(
                    width: 15,
                  ),
                  twitHeader(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Column(children: [
                  Image(
                    image: AssetImage("assets/images/img2.png"),
                    width: 200,
                  )
                ]),
              )
            ]),
      ),
    );
  }

  Container twitHeader() {
    return Container(
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Formula 1",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.check,
              color: Colors.yellow,
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "IT’S RACE WEEK IN VEGAS!!!",
          style: TextStyle(color: Colors.white),
        ),
      ]),
    );
  }

  Container twitPicture() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(4)),
      child: const Image(
        image: AssetImage("assets/images/img.png"),
        height: 50,
        fit: BoxFit.fill,
      ),
    );
  }

  FutureBuilder Top() {
    return FutureBuilder(
        future: getNextRace(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "${snapshot.data[4]}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 100, 66),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: const Color.fromARGB(0, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "${snapshot.data[3]}".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        height: 15,
                        color: Colors.black,
                        thickness: 0.4,
                      ),
                      const SizedBox(height: 15),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${snapshot.data[0]}",
                                  style: numberTextStyle(),
                                ),
                                Text(
                                  "days".toUpperCase(),
                                  style: timeTextStyle(),
                                )
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  "${snapshot.data[1]}",
                                  style: numberTextStyle(),
                                ),
                                Text(
                                  "hrs".toUpperCase(),
                                  style: timeTextStyle(),
                                )
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  "${snapshot.data[2]}",
                                  style: numberTextStyle(),
                                ),
                                Text(
                                  "mins".toUpperCase(),
                                  style: timeTextStyle(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )
              ],
            );
          }
        });
  }

  TextStyle timeTextStyle() => const TextStyle(color: Colors.white, fontSize: 13);

  TextStyle numberTextStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 33, fontWeight: FontWeight.bold);
  }
}
