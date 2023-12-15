import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/firebase_options.dart';
import 'package:test/pages/racing.dart';
import 'package:test/pages/share_tweet.dart';
import 'package:test/pages/standings.dart';
import 'package:test/pages/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "Formula1",
            // scaffoldBackgroundColor: Color.fromARGB(255, 35, 37, 39)
            scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)),
        debugShowCheckedModeBanner: false,
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

TextStyle titleStyle() {
  return const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final TextEditingController authorCon = TextEditingController();
  final TextEditingController textCon = TextEditingController();
  final TextEditingController bodyImageCon = TextEditingController();
  final List<Widget> _pages = [
    MyWidget(),
    const RacingPage(),
    const StandingsPage(),
    ShareTweet(),
  ];
  final List<Text> _texts = [
    Text(
      "Home".toUpperCase(),
      style: titleStyle(),
    ),
    Text("Racing".toUpperCase(), style: titleStyle()),
    Text("Standings".toUpperCase(), style: titleStyle()),
    Text("Post a tweet".toUpperCase(), style: titleStyle()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 25,
        title: _texts[_currentIndex],
        backgroundColor: const Color(0xFFEE0000),
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
          indicatorColor: const Color.fromRGBO(238, 0, 0, 1.0),
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
                icon: Icon(Icons.leaderboard), label: "Standings"),
            NavigationDestination(
                icon: Icon(Icons.new_label_sharp), label: "Post Tweet")
          ],
        ),
      ),
    );
  }

  void openTweetBox() {
    showDialog(
        context: context,
        builder: (context) => (AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Author:"),
                  TextField(
                    controller: authorCon,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Text"),
                  TextField(
                    controller: textCon,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Image Url"),
                  TextField(
                    controller: bodyImageCon,
                  )
                ],
              ),
              actions: [ElevatedButton(onPressed: () {}, child: Text("add"))],
            )));
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
      items: const [
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
