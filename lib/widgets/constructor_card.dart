import 'package:flutter/material.dart';

class ConstructorCard extends StatelessWidget {
  final String position;
  final String points;
  final String wins;
  final String name;
  final Map images = {
    "Red Bull": "assets/images/teams/red_bull.png",
    "Mercedes": "assets/images/teams/mercedes.png",
    "Ferrari": "assets/images/teams/ferrari.png",
    "McLaren": "assets/images/teams/mclaren.png",
    "Aston Martin": "assets/images/teams/aston_martin.png",
    "Alpine F1 Team": "assets/images/teams/alpine.png",
    "Williams": "assets/images/teams/williams.png",
    "AlphaTauri": "assets/images/teams/alpha_tauri.png",
    "Alfa Romeo": "assets/images/teams/alfa_romeo.png",
    "Haas F1 Team": "assets/images/teams/haas.png",
  };
  final Map driverPairs = {
    "Red Bull": ["Max Verstappen", "Sergio Pérez"],
    "Mercedes": ["Lewis Hamilton", "George Russell"],
    "Ferrari": ["Charles Leclerc", "Carlos Sainz"],
    "McLaren": ["Lando Norris", "Oscar Piastri"],
    "Aston Martin": ["Fernando Alonso", "Lance Stroll"],
    "Alpine F1 Team": ["Pierre Gasly", "Esteban Ocon"],
    "Williams": ["Alex Albon", "Logan Sargeant"],
    "AlphaTauri": ["Yuki Tsunoda", "Daniel Ricciardo"],
    "Alfa Romeo": ["Valtteri Bottas", "Zhou Guanyu"],
    "Haas F1 Team": ["Nico Hülkenberg", "Kevin Magnussen"],
  };
  ConstructorCard({super.key, 
    required this.position,
    required this.points,
    required this.wins,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 46, 46, 46),
          border: Border.all(color: const Color.fromARGB(255, 46, 46, 46)),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  driverPairs[name][0],
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  driverPairs[name][1],
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image(
                  image: AssetImage(images[name]),
                  height: 45,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "$points PTS",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
