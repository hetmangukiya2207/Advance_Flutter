import 'dart:math';
import 'package:flutter/material.dart';

class CategoryOrAuthorPage extends StatefulWidget {
  const CategoryOrAuthorPage({Key? key}) : super(key: key);

  @override
  State<CategoryOrAuthorPage> createState() => _CategoryOrAuthorPageState();
}

class _CategoryOrAuthorPageState extends State<CategoryOrAuthorPage> {
  List<Category> categories = [
    Category(category: 'business', title: 'Business'),
    Category(category: 'sports', title: 'Sports'),
    Category(category: 'wisdom', title: 'Wisdom'),
    Category(category: 'love', title: 'Love'),
    Category(category: 'motivational', title: 'Motivational'),
    Category(category: 'life', title: 'Life'),
    Category(category: 'friendship', title: 'Friendship'),
    Category(category: 'history', title: 'History'),
    Category(category: 'politics', title: 'Politics'),
    Category(category: 'humor', title: 'Humor'),
    Category(category: 'inspirational', title: 'Inspirational'),
  ];

  List<Category> authors = [
    Category(category: 'george_bernard_shaw', title: 'George Bernard Shaw'),
    Category(category: 'john_stuart_mill', title: 'John Stuart Mill'),
    Category(category: 'arthur_c_clarke', title: 'Arthur C Clarke'),
    Category(category: 'jean_paul_sartre', title: 'Jean-Paul Sartre'),
    Category(category: 'aristotle', title: 'Aristotle'),
    Category(category: 'albert_einstein', title: 'Albert Einstein'),
    Category(category: 'barack_obama', title: 'Barack Obama'),
    Category(category: 'donald_trump', title: 'Donald Trump'),
    Category(category: 'muhammad_ali', title: 'Muhammad Ali'),
  ];

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes by ${res.title}",
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: (res.isAuthorCat) ? authors.length : categories.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () async {
              Arguments args = Arguments(
                  title: (res.isAuthorCat)
                      ? authors[i].title
                      : categories[i].title,
                  name: (res.isAuthorCat)
                      ? authors[i].category
                      : categories[i].category,
                  isAuthCat: res.isAuthorCat);

              Navigator.of(context).pushNamed('quotes_page', arguments: args);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        child: Text(
                          (res.isAuthorCat)
                              ? authors[i].title.substring(0, 2)
                              : categories[i].title.substring(0, 2),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        (res.isAuthorCat)
                            ? authors[i].title
                            : categories[i].title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    indent: 80,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final String category;
  final String title;

  Category({required this.category, required this.title});
}

class Arguments {
  final String title;
  final String name;
  final bool isAuthCat;

  Arguments({required this.title, required this.isAuthCat, required this.name});
}
