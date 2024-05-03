import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreenTitle extends StatelessWidget {
  const MainScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Column(
        children: [
          const Icon(
            Icons.assignment,
            size: 100,
          ),
          const SizedBox(height: 25),
          Text(
            'TO DO LIST APP',
            style: GoogleFonts.bebasNeue(fontSize: 52),
          ),
        ],
      ),
    );
  }
}
