import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [_searchField()],
      ),
      //bottomNavigationBar: BottomNav(),
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black87.withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Hello Flutter",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          "T",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

// class BottomNav extends StatefulWidget {
//   const BottomNav({
//     super.key,
//   });

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int _current = 0;
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _current,
//       items: [
//         BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
//         BottomNavigationBarItem(label: "Fav", icon: Icon(Icons.favorite))
//       ],
//       onTap: (index) => {
//         setState(() {
//           _current = index;
//         })
//       },
//     );
//   }
// }
