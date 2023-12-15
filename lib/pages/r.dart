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
        title: const Text('Second Route'),
        backgroundColor: const Color(0xFFEE0000),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(drivers[index].points),
                        Text(drivers[index].driverName),
                        Text(drivers[index].constructorName),
                        Text(drivers[index].points)
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }),
    );
  }
}
