import 'package:flutter/material.dart';
import 'package:test/models/constructor_model.dart';
import 'package:test/models/driver_model.dart';
import 'package:test/models/race_api.dart';
import 'package:test/widgets/constructor_card.dart';
import 'package:test/widgets/driver_card.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  int _currentPage = 0;
  late List<Driver> drivers;
  late List<Constructor> constructors;
  bool disLoading = true;
  bool cisLoading = true;
  @override
  void initState() {
    super.initState();
    getDrivers();
    getConstructors();
  }

  Future getDrivers() async {
    drivers = await RaceApi.getDrivers();
    setState(() {
      disLoading = false;
    });
  }

  Future getConstructors() async {
    constructors = await RaceApi.getConstructors();
    setState(() {
      cisLoading = false;
    });
    print(constructors);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        selectButtons(),
        const SizedBox(
          height: 20,
        ),
        _currentPage == 0
            ? (disLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: drivers.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              DriverCard(
                                position: drivers[index].position,
                                points: drivers[index].points,
                                wins: drivers[index].wins,
                                number: drivers[index].number,
                                name: drivers[index].name,
                                surname: drivers[index].surname,
                                constructorName: drivers[index].constructorName,
                              ),
                              SizedBox(height: 15),
                            ],
                          );
                        }),
                  ))
            : (cisLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: constructors.length,
                        itemBuilder: (context, idx) {
                          return Column(
                            children: [
                              ConstructorCard(
                                position: constructors[idx].position,
                                points: constructors[idx].points,
                                wins: constructors[idx].wins,
                                name: constructors[idx].name,
                              ),
                              SizedBox(height: 15),
                            ],
                          );
                        }),
                  ))
      ],
    );
  }

  Column driversColumn() {
    return Column(
      children: [
        driverContainer(),
      ],
    );
  }

  Column constructorsColumn() {
    return Column(
      children: [
        constructorContainer(),
      ],
    );
  }

  Container constructorContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 46, 46, 46),
          border: Border.all(color: Color.fromARGB(255, 46, 46, 46)),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Red Bull Racing",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Max Verstappen",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "Sergio Perez",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Column(
              children: [
                Image(
                  image: AssetImage("assets/images/red_bull.png"),
                  height: 45,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "782 PTS",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container driverContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 46, 46, 46),
          border: Border.all(color: Color.fromARGB(255, 46, 46, 46)),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Max",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Verstappen".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Red Bull Racing",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Column(
              children: [
                Image(
                  image: AssetImage("assets/images/verstappen.png"),
                  height: 100,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "524 PTS",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
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
            child: Text("Drivers",
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
              "Constructors",
              style: TextStyle(
                  color: _currentPage == 1 ? Colors.white : Colors.grey),
            )),
      ],
    );
  }
}
