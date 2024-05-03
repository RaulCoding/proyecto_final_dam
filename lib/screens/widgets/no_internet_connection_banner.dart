import 'package:flutter/material.dart';

class NoInternetBanner extends StatelessWidget {
  bool show;
  NoInternetBanner({required this.show, super.key});

  @override
  Widget build(BuildContext context) {
    return show
        ? Container(
            color: Colors.red,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            height: 130,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No hay conexión a internet",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  "Conéctate a internet para crear o hacer modificaciones de tareas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
