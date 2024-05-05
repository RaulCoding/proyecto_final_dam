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
            Icons.assignment_turned_in_rounded,
            size: 100,
            color: Color(0xffeeeeee),
          ),
          const SizedBox(height: 25),
          Text(
            'My Notes',
            style:
                GoogleFonts.bebasNeue(fontSize: 52, color: Color(0xffeeeeee)),
          ),
        ],
      ),
    );
  }
}
