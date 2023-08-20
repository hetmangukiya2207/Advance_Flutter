import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

drawer({required BuildContext context}) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            alignment: Alignment.center,
            child: Text(
              "Life Quotes and \nSayings",
              textAlign: TextAlign.center,
              style: GoogleFonts.kalam(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ),
          ...drawerItem
              .map((e) => ListTile(
                    onTap: () {
                      if (e.title == "By Topic") {
                        Arguments args =
                            Arguments(title: "Category", isAuthorCat: false);
                        Navigator.of(context)
                            .pushNamed('category_author_page', arguments: args);
                      } else if (e.title == "By Author") {
                        Arguments args =
                            Arguments(title: "Author", isAuthorCat: true);
                        Navigator.of(context)
                            .pushNamed('category_author_page', arguments: args);
                      }
                    },
                    leading: e.icon,
                    title: Text(e.title),
                  ))
              .toList(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Communicate",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
                fontSize: 18,
              ),
            ),
          ),
          ...drawerItem2
              .map(
                (e) => ListTile(
                  onTap: () {},
                  leading: e.icon,
                  title: Text(e.title),
                ),
              )
              .toList(),
        ],
      ),
    ),
  );
}

List drawerItem = [
  DrawerItem(
      icon: const Icon(Icons.topic_rounded, color: Colors.teal),
      title: "By Topic"),
  DrawerItem(
      icon: const Icon(Icons.person, color: Colors.blueGrey),
      title: "By Author"),
  DrawerItem(
      icon: const Icon(Icons.star, color: Colors.orange), title: "Favourites"),
  DrawerItem(
      icon: const Icon(Icons.lightbulb, color: Colors.yellow),
      title: "Quote of the Day"),
  DrawerItem(
      icon: Icon(Icons.star_border, color: Colors.yellow.shade600),
      title: "Favourite Pictures"),
  DrawerItem(
      icon: const Icon(Icons.video_collection_sharp, color: Colors.red),
      title: "Videos"),
];

List drawerItem2 = [
  DrawerItem(icon: const Icon(Icons.settings), title: "Settings"),
  DrawerItem(icon: const Icon(Icons.share), title: "Share"),
  DrawerItem(icon: const Icon(Icons.rate_review), title: "Rate"),
  DrawerItem(icon: const Icon(Icons.feedback), title: "Feedback"),
  DrawerItem(icon: const Icon(Icons.search_sharp), title: "Our other apps"),
  DrawerItem(icon: const Icon(Icons.info_outline), title: "About"),
];

class DrawerItem {
  final Icon icon;
  final String title;

  DrawerItem({
    required this.icon,
    required this.title,
  });
}

class Arguments {
  final String title;
  final bool isAuthorCat;

  Arguments({required this.title, required this.isAuthorCat});
}
