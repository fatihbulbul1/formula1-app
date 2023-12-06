import 'package:flutter/material.dart';

class DriverCard extends StatelessWidget {
  final String position;
  final String points;
  final String wins;
  final String number;
  final String name;
  final String surname;
  final String constructorName;
  final Map images = {
    "Verstappen": "assets/images/drivers/verstappen.png",
    "Pérez": "assets/images/drivers/perez.png",
    "Hamilton": "assets/images/drivers/hamilton.png",
    "Alonso": "assets/images/drivers/alonso.png",
    "Leclerc": "assets/images/drivers/leclerc.png",
    "Norris": "assets/images/drivers/norris.png",
    "Sainz": "assets/images/drivers/sainz.png",
    "Russell": "assets/images/drivers/russell.png",
    "Piastri": "assets/images/drivers/piastri.png",
    "Stroll": "assets/images/drivers/stroll.png",
    "Gasly": "assets/images/drivers/gasly.png",
    "Ocon": "assets/images/drivers/ocon.png",
    "Albon": "assets/images/drivers/albon.png",
    "Tsunoda": "assets/images/drivers/tsunoda.png",
    "Bottas": "assets/images/drivers/bottas.png",
    "Hülkenberg": "assets/images/drivers/hulkenberg.png",
    "Ricciardo": "assets/images/drivers/ricciardo.png",
    "Zhou": "assets/images/drivers/zhou.png",
    "Magnussen": "assets/images/drivers/magnussen.png",
    "Lawson": "assets/images/drivers/lawson.png",
    "Sargeant": "assets/images/drivers/sargeant.png",
    "de Vries": "assets/images/drivers/de_vries.png"
  };
  DriverCard({super.key, 
    required this.position,
    required this.points,
    required this.wins,
    required this.number,
    required this.name,
    required this.surname,
    required this.constructorName,
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
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  surname.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  constructorName,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Column(
              children: [
                Image(
                  image: AssetImage(images[surname]),
                  height: 100,
                ),
                const SizedBox(
                  height: 5,
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
