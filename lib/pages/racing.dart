import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/models/race_model.dart';
import 'package:test/models/upcoming_model.dart';
import 'package:test/services/race_api.dart';
import 'package:test/widgets/past_race.dart';
import 'package:test/widgets/upcoming_race.dart';

class RacingPage extends StatefulWidget {
  const RacingPage({super.key});

  @override
  State<RacingPage> createState() => _RacingPageState();
}

class _RacingPageState extends State<RacingPage> {
  int _currentPage = 0;
  List races = [];
  List<Race> pastRaces = [];
  List<URace> upcomingRaces = [];
  bool isLoadingU = true;
  bool isLoadingP = true;
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
  @override
  void initState() {
    super.initState();
    getPastRaces();
    getUpcomingRaces();
  }

  Future getPastRaces() async {
    pastRaces = await RaceApi.getRace();
    setState(() {
      isLoadingP = false;
    });
  }

  Future getUpcomingRaces() async {
    upcomingRaces = await RaceApi.getUpcomingRaces();
    setState(() {
      isLoadingU = false;
    });
    print(upcomingRaces);
  }

  Future getRaces() async {
    setState(() {
      isLoadingP = true;
    });
    var response =
        await http.get(Uri.https("ergast.com", "api/f1/2023/results/1.json"));
    var jsonData = jsonDecode(response.body);
    List localRaces = [];
    for (var i = 0; i < 22; i++) {
      var raceName = jsonData["MRData"]["RaceTable"]["Races"][i]["raceName"];
      var round = jsonData["MRData"]["RaceTable"]["Races"][i]["round"];
      var date = jsonData["MRData"]["RaceTable"]["Races"][i]["date"];
      var winnerName = jsonData["MRData"]["RaceTable"]["Races"][i]["Results"][0]
          ["Driver"]["givenName"];
      var winnerSrame = jsonData["MRData"]["RaceTable"]["Races"][i]["Results"]
          [0]["Driver"]["familyName"];
      var constructor = jsonData["MRData"]["RaceTable"]["Races"][i]["Results"]
          [0]["Constructor"]["name"];
      date = date.split("-");
      var month = months[int.parse(date[1])];
      var day = int.parse(date[2]);
      String dayStr;
      if (day < 10) {
        dayStr = "0$day";
      } else {
        dayStr = day.toString();
      }

      localRaces.add([
        raceName,
        round,
        dayStr,
        month,
        "$winnerName $winnerSrame",
        constructor
      ]);
    }
    setState(() {
      races = localRaces;
      isLoadingP = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        selectButtons(),
        const SizedBox(
          height: 20,
        ),
        _currentPage == 0
            ? (isLoadingU
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: upcomingRaces.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              UpcomingRaceContainer(
                                  raceName: upcomingRaces[index].raceName,
                                  round: upcomingRaces[index].round,
                                  dayStr: upcomingRaces[index].dayStr,
                                  month: upcomingRaces[index].month,
                                  place: upcomingRaces[index].place),
                              const SizedBox(height: 15),
                            ],
                          );
                        }),
                  ))
            : (isLoadingP
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: pastRaces.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PastRaceContainer(
                                  raceName: pastRaces[index].raceName,
                                  round: pastRaces[index].round,
                                  dayStr: pastRaces[index].dayStr,
                                  month: pastRaces[index].month,
                                  winnerName: pastRaces[index].winnerName,
                                  constructorName:
                                      pastRaces[index].constructorName,
                                  place: pastRaces[index].place),
                              const SizedBox(height: 15),
                            ],
                          );
                        }),
                  ))
      ]),
    );
  }

  Container upcomingContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 46, 46, 46)),
          color: const Color.fromARGB(255, 46, 46, 46)),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          raceContainer(),
          const VerticalDivider(
            color: Colors.white,
            width: 50,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Round 20",
                style: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
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
                style: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
              )
            ],
          )
        ]),
      ),
    );
  }

  Column raceContainer() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        "17 - 19",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        decoration: monthDecoration(),
        padding: const EdgeInsets.all(5),
        child: const Text(
          "Oct",
        ),
      )
    ]);
  }

  Column raceContainer1(state) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        state[2],
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        decoration: monthDecoration(),
        padding: const EdgeInsets.all(5),
        child: const Text(
          "Oct",
        ),
      )
    ]);
  }

  FutureBuilder pastContainer1() {
    return FutureBuilder(
        future: getRaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: races.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(races[index][0]),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget pastContainerListTile() {
    return Expanded(
      child: ListView.builder(
        itemCount: races.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(races[index][0]),
          );
          // return Column(
          //   children: [
          //     race__(races[index]), // Make sure this function is implemented correctly
          //     SizedBox(height: 20),
          //   ],
          // );
        },
      ),
    );
  }

  Container pastContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 46, 46, 46)),
          color: const Color.fromARGB(255, 46, 46, 46)),
      child: Column(
        children: [
          race__("hi"),
        ],
      ),
    );
  }

  IntrinsicHeight race__(state) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromARGB(255, 46, 46, 46)),
            color: const Color.fromARGB(255, 46, 46, 46)),
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state[2],
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
                          state[3],
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
                    "Round " + state[1],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 211, 211, 211)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Brazil",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state[0],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 211, 211, 211)),
                  )
                ],
              )
            ]),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () {},
                child: const Text(
                  "See results",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }

  BoxDecoration monthDecoration() {
    return BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20));
  }

  Row selectButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            style: ButtonStyle(
                backgroundColor: _currentPage == 0
                    ? const MaterialStatePropertyAll(Colors.blueGrey)
                    : null),
            onPressed: () {
              setState(() {
                _currentPage = 0;
              });
            },
            onFocusChange: (value) {},
            child: Text("Upcoming",
                style: TextStyle(
                    color: _currentPage == 0 ? Colors.white : Colors.grey))),
        TextButton(
            style: ButtonStyle(
                backgroundColor: _currentPage == 1
                    ? const MaterialStatePropertyAll(Colors.blueGrey)
                    : null),
            onPressed: () {
              setState(() {
                _currentPage = 1;
              });
            },
            child: Text(
              "Past",
              style: TextStyle(
                  color: _currentPage == 1 ? Colors.white : Colors.grey),
            )),
      ],
    );
  }
}
