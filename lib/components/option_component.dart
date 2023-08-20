import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget options(
    {required Color color, required IconData icon, required String text}) {
  return Container(
    height: 90,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          height: 50,
          width: 50,
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
