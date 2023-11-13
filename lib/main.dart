import 'package:flutter/material.dart';
import 'package:test/pages/racing.dart';
import 'package:test/pages/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "Formula1",
            // scaffoldBackgroundColor: Color.fromARGB(255, 35, 37, 39)
            scaffoldBackgroundColor: Color.fromARGB(255, 27, 27, 27)),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

TextStyle titleStyle() {
  return TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MyWidget(),
    RacingPage(),
    Center(
      child: Text("Page 3 Content"),
    ),
  ];
  final List<Text> _texts = [
    Text(
      "Home".toUpperCase(),
      style: titleStyle(),
    ),
    Text("Racing".toUpperCase(), style: titleStyle()),
    Text("Standings".toUpperCase(), style: titleStyle()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 25,
        title: _texts[_currentIndex],
        backgroundColor: Color(0xFFEE0000),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
          return const TextStyle(fontWeight: FontWeight.bold);
        })),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          indicatorColor: Color.fromRGBO(238, 0, 0, 1.0),
          selectedIndex: _currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
                // selectedIcon: Icon(Icons.newspaper),
                icon: Icon(Icons.newspaper_outlined),
                label: "Latest"),
            NavigationDestination(
              icon: Icon(Icons.emoji_events),
              label: "Racing",
            ),
            NavigationDestination(
                icon: Icon(Icons.leaderboard), label: "Standings")
          ],
        ),
      ),
    );
  }

  Padding _body() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(25.0, 30.0, 10.0, 0),
      child: Column(
        children: [
          Text(
            "Name",
            style: TextStyle(letterSpacing: 2.0, color: Colors.red),
          ),
          SizedBox(height: 10),
          Text(
            "OMAR7",
            style: TextStyle(fontSize: 25, color: Colors.blue),
          )
        ],
      ),
    );
  }

  BottomNavigationBar Nav() {
    return BottomNavigationBar(
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.red,
      elevation: 0,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
