import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test/models/race.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  Future getNextRace() async {
    var response = await http.get(Uri.https("ergast.com", "api/f1/2023.json"));
    var jsonData = jsonDecode(response.body);
    var date = jsonData["MRData"]["RaceTable"]["Races"][0]["FirstPractice"]
            ["date"]
        .replaceFirst("2023", "2024");
    var time =
        jsonData["MRData"]["RaceTable"]["Races"][0]["FirstPractice"]["time"];
    ;
    DateTime now = DateTime.now();
    DateTime targetDateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse("$date $time");

    Duration difference = targetDateTime.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours - (days * 24);
    int minutes = difference.inMinutes - (days * 24 * 60) - (hours * 60);
    List remaining = [];
    remaining.add(days);
    remaining.add(hours);
    remaining.add(minutes);
    return remaining;
  }

  @override
  Widget build(BuildContext context) {
    getNextRace();
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "17 - 19 KAS",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      SizedBox(
        height: 10,
      ),
      TimerContainer2(),
      SizedBox(
        height: 20,
      ),
      Text(
        "Latest News".toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      SizedBox(
        height: 10,
      ),
      Divider(
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
      // Container(
      //     height: 45,
      //     decoration: BoxDecoration(
      //         border: Border.all(color: Colors.white),
      //         borderRadius: BorderRadius.all(Radius.circular(10))
      //         // border: Border(
      //         //     top: BorderSide(color: Colors.white),
      //         //     right: BorderSide(color: Colors.white),
      //         //     left: BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
      //         //     bottom: BorderSide(color: Color.fromARGB(0, 255, 255, 255))),
      //         //borderRadius: BorderRadius.circular(10)
      //         //borderRadius: BorderRadius.only(topRight: Radius.circular(1))
      //         ))
    ]));
  }

  Container tweetContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 56, 56, 56),
          border: Border.all(color: Color.fromARGB(255, 56, 56, 56)),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  twitPicture(),
                  SizedBox(
                    width: 15,
                  ),
                  twitHeader(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(children: [
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      child: Image(
        image: AssetImage("assets/images/img.png"),
        height: 50,
        fit: BoxFit.fill,
      ),
    );
  }

  Container oldContainer() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(4)),
          child: Image(
            image: AssetImage("assets/images/img.png"),
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          child: Column(children: [
            Text(
              "Formula 1",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "IT’S RACE WEEK IN VEGAS!!!",
              style: TextStyle(color: Colors.white),
            ),
            Image(
              image: AssetImage("assets/images/img2.png"),
              width: 200,
            )
          ]),
        )
      ]),
    );
  }

  FutureBuilder TimerContainer2() {
    return FutureBuilder(
        future: getNextRace(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Container(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 100, 66),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Las Vegas Grand Prix Weekend".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  SizedBox(height: 15),
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
                        VerticalDivider(
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
                        VerticalDivider(
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
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }
        });
  }

  Container TimerContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 100, 66),
          border: Border.all(
              style: BorderStyle.solid,
              color: Color.fromARGB(0, 255, 255, 255)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20),
          Text(
            "Las Vegas Grand Prix Weekend".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 15,
            color: Colors.black,
            thickness: 0.4,
          ),
          SizedBox(height: 15),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "01",
                      style: numberTextStyle(),
                    ),
                    Text(
                      "days".toUpperCase(),
                      style: timeTextStyle(),
                    )
                  ],
                ),
                VerticalDivider(
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Text(
                      "03",
                      style: numberTextStyle(),
                    ),
                    Text(
                      "hrs".toUpperCase(),
                      style: timeTextStyle(),
                    )
                  ],
                ),
                VerticalDivider(
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Text(
                      "59",
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
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  TextStyle timeTextStyle() => TextStyle(color: Colors.white, fontSize: 13);

  TextStyle numberTextStyle() {
    return TextStyle(
        color: Colors.white, fontSize: 33, fontWeight: FontWeight.bold);
  }
}
// const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Sayfa1",
//             style: TextStyle(color: Colors.white),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: 
//             [Text("data1"), Text("data2"), Text("dat3a")],
//           ),
//         ]);