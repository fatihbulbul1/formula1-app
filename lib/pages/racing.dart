import 'package:flutter/material.dart';

class RacingPage extends StatefulWidget {
  const RacingPage({super.key});

  @override
  State<RacingPage> createState() => _RacingPageState();
}

class _RacingPageState extends State<RacingPage> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        selectButtons(),
        SizedBox(
          height: 20,
        ),
        _currentPage == 0 ? upcomingContainer() : pastContainer()
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
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "17 - 19",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  Container pastContainer() {
    return Container(
      padding: EdgeInsets.all(20),
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
                    children: [
                      Text(
                        "03 - 05",
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
                          "Oct",
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
                    "Round 19",
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
                    "Formula 1 Brazil GP",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 211, 211, 211)),
                  )
                ],
              )
            ]),
          ),
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
