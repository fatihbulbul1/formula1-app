import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/models/race_.dart';
import 'package:test/models/race_api.dart';
import 'package:test/widgets/past_race.dart';

class RacingPage extends StatefulWidget {
  RacingPage({super.key});

  @override
  State<RacingPage> createState() => _RacingPageState();
}

class _RacingPageState extends State<RacingPage> {
  int _currentPage = 0;
  List races = [];
  late List<Race> _races;
  bool isLoading = true;
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
    getRaces2();
  }

  Future getRaces2() async {
    _races = await RaceApi.getRace();
    setState(() {
      isLoading = false;
    });
    print(_races);
  }

  Future getRaces() async {
    print("giris");
    setState(() {
      isLoading = true;
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
      if (day < 10)
        dayStr = "0" + day.toString();
      else
        dayStr = day.toString();

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
      isLoading = false;
    });
    print(races);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        selectButtons(),
        SizedBox(
          height: 20,
        ),
        _currentPage == 0
            ? upcomingContainer()
            : isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _races.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PastRaceContainer(
                                  raceName: _races[index].raceName,
                                  round: _races[index].round,
                                  dayStr: _races[index].dayStr,
                                  month: _races[index].month,
                                  winnerName: _races[index].winnerName,
                                  constructorName:
                                      _races[index].constructorName,
                                  place: _races[index].place),
                              SizedBox(height: 15),
                            ],
                          );
                        }),
                  )
      ]),
    );
  }

  Container upcomingContainer() {
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

  Column raceContainer1(state) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        state[2],
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
            return Center(
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
      padding: EdgeInsets.all(20),
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
        padding: EdgeInsets.all(20),
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
                          state[3],
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
                    "Round " + state[1],
                    style: TextStyle(
                        color: const Color.fromARGB(255, 211, 211, 211)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Brazil",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    state[0],
                    style: TextStyle(
                        color: const Color.fromARGB(255, 211, 211, 211)),
                  )
                ],
              )
            ]),
            SizedBox(
              height: 10,
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () {},
                child: Text(
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
                    ? MaterialStatePropertyAll(Colors.blueGrey)
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
                    ? MaterialStatePropertyAll(Colors.blueGrey)
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
