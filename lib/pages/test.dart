import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test/services/dbhelper.dart';
import 'package:test/services/firestore.dart';

class MyWidget extends StatefulWidget {
  MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  FirestoreService firestoreService = FirestoreService();

  List<Map<String, dynamic>> _allData = [];

  bool isLoading = true;
  void refreshData() async {
    final data = await SQLHelper.getData();
    setState(() {
      _allData = data;
      isLoading = false;
    });
  }

  void deleteData() async {
    await SQLHelper.deleteData();
    refreshData();
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> _addData(String author, String text, String bodyImageUrl) async {
    await SQLHelper.createData(author, text, bodyImageUrl);
    refreshData();
  }

  var num = 0;
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
    remaining.add(
        "${"${"Round " + round} | ${raceDay[2]} " + months[int.parse(raceDay[1])]} ${raceDay[0]}");
    return remaining;
  }

  @override
  Widget build(BuildContext context) {
    getNextRace();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // RaceNameContainer(),
      // TimerContainer2(),
      Top(),
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
      isLoading
          ? Center(child: CircularProgressIndicator())
          : Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                child: ListView.builder(
                  itemCount: _allData.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        tweetContainer(_allData[index]),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
    ]);
  }

  Column tweetContainer(var item) {
    DateTime time = DateTime.parse(item["date"]);
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(time);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 56, 56, 56),
              border: Border.all(color: Color.fromARGB(255, 56, 56, 56)),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      twitPicture(),
                      SizedBox(
                        width: 15,
                      ),
                      twitHeader(item["author"], item["text"]),
                    ],
                  ),
                  item["bodyImageUrl"] != ""
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Column(children: [
                              Image.network(item["bodyImageUrl"]),
                            ]),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    formattedDate,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color.fromARGB(204, 154, 154, 154)),
                  )
                ]),
          ),
        ),
      ],
    );
  }

  Container twitHeader(String author, String text) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              author,
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
          text,
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

  FutureBuilder Top() {
    return FutureBuilder(
        future: getNextRace(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Container(
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
                        "${snapshot.data[3]}".toUpperCase(),
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
                )
              ],
            );
          }
        });
  }

  TextStyle timeTextStyle() => TextStyle(color: Colors.white, fontSize: 13);

  TextStyle numberTextStyle() {
    return TextStyle(
        color: Colors.white, fontSize: 33, fontWeight: FontWeight.bold);
  }
}
