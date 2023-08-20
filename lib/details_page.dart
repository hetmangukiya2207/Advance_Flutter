import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'modal.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    QuotesDB res = ModalRoute.of(context)!.settings.arguments as QuotesDB;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
            image: NetworkImage(res.image),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Text(
              "${res.quote} \n\n - ${res.author}",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
            Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.teal,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.text_fields_sharp,
                        color: Colors.blueGrey,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.copy, color: Colors.blue)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_downward,
                          color: Colors.green)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star_border, color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 46),
          ],
        ),
      ),
    );
  }
}
