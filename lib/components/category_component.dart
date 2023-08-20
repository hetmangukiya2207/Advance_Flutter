import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget category(
    {required double height,
    required String category,
    required BuildContext context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.142,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.softLight,
            ),
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://source.unsplash.com/random/?background,$category",
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 2, top: 3),
        child: Text(
          "$category Quotes",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ],
  );
}
