import 'package:flutter/material.dart';
import 'package:test/models/n_result_model.dart';
import 'package:test/services/race_api.dart';

class R extends StatefulWidget {
  const R({
    super.key,
    required this.round,
    required this.raceName,
  });
  final String round;
  final String raceName;
  @override
  State<R> createState() => _RState();
}

class _RState extends State<R> {
  bool isLoading = true;
  late List<Drivers> drivers;
  Future getResults() async {
    drivers = await RaceApi.getResults(widget.round);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Race Result'),
          backgroundColor: const Color(0xFFEE0000),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Text(
                      widget.raceName,
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
                    Text(
                      "Race Result",
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: drivers.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 46, 46, 46),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              drivers[index].position,
                                              style: TextStyle(
                                                  color: drivers[index]
                                                              .position ==
                                                          "1"
                                                      ? Colors.yellow
                                                      : drivers[index]
                                                                  .position ==
                                                              "2"
                                                          ? Colors.blueGrey
                                                          : drivers[index]
                                                                      .position ==
                                                                  "3"
                                                              ? Colors.orange
                                                              : Colors.white),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  drivers[index]
                                                      .driverName
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  drivers[index]
                                                      .constructorName,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          drivers[index].points + " PTS",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
        ));
  }
}
