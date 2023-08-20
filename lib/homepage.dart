import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'modal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/author_component.dart';
import '../components/category_component.dart';
import '../helpers/db_helpers.dart';
import '../components/drawer.dart';
import '../components/option_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: drawer(context: context),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: Colors.black));
        }),
        title: const Text(
          "Life Quotes and Saying",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: Colors.yellow.shade800)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite, color: Colors.red)),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: DBHelper.dbHelper
                    .fetchLatestQuotes(tableName: 'latestQuotes'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error:${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<QuotesDB> data = snapshot.data as List<QuotesDB>;

                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('details_page', arguments: data[index]);
                      },
                      child: CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (val, _) {
                            index = val;
                          },
                          viewportFraction: 0.9,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlay: true,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: data.map((e) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            // margin: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(e.image),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.hardLight),
                              ),
                            ),
                            child: Text(
                              e.quote,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.alike(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        CatOrAuthArgs args = CatOrAuthArgs(
                            title: 'Categories', isAuthorCat: false);

                        Navigator.of(context)
                            .pushNamed('category_author_page', arguments: args);
                      },
                      child: options(
                        color: const Color(0xffA45584),
                        icon: Icons.grid_view,
                        text: "Categories",
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Arguments args = Arguments(
                            title: "Popular", isAuthCat: false, name: 'pic');
                        Navigator.of(context)
                            .pushNamed('quotes_page', arguments: args);
                      },
                      child: options(
                        color: const Color(0xff7589C8),
                        icon: Icons.image_outlined,
                        text: "Pic Quotes",
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Arguments args = Arguments(
                            title: 'Latest', isAuthCat: false, name: 'pic');

                        Navigator.of(context)
                            .pushNamed('quotes_page', arguments: args);
                      },
                      child: options(
                        color: const Color(0xffB99041),
                        icon: Icons.settings,
                        text: "Latest",
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: options(
                        color: const Color(0xff6C9978),
                        icon: Icons.menu_book_sharp,
                        text: "Articles",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Most Popular",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Happiness',
                                isAuthCat: false,
                                name: 'happiness');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Happiness',
                              context: context))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Love', isAuthCat: false, name: 'love');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Love',
                              context: context))),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Success',
                                isAuthCat: false,
                                name: 'success');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Success',
                              context: context))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Wisdom',
                                isAuthCat: false,
                                name: 'wisdom');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Wisdom',
                              context: context))),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Quotes by Category",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      CatOrAuthArgs args = CatOrAuthArgs(
                          title: 'Categories', isAuthorCat: false);

                      Navigator.of(context)
                          .pushNamed('category_author_page', arguments: args);
                    },
                    child: const Text(
                      "View All >",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Ambition',
                                isAuthCat: false,
                                name: 'ambition');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Ambition',
                              context: context))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Business',
                                isAuthCat: false,
                                name: 'business');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Business',
                              context: context))),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Friendship',
                                isAuthCat: false,
                                name: 'friendship');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Friendship',
                              context: context))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Humor',
                                isAuthCat: false,
                                name: 'humor');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: category(
                              height: height,
                              category: 'Humor',
                              context: context))),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Quotes by Author",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      CatOrAuthArgs args =
                          CatOrAuthArgs(title: 'Authors', isAuthorCat: true);
                      Navigator.of(context)
                          .pushNamed('category_author_page', arguments: args);
                    },
                    child: const Text(
                      "View All >",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'George Bernard Shaw',
                                isAuthCat: true,
                                name: 'george_bernard_shaw');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: authorBox(
                              height: height,
                              author: "George Bernard Shaw",
                              color: const Color(0xffF5DBCE)))),
                  const SizedBox(width: 4),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'John Stuart Mill',
                                isAuthCat: true,
                                name: 'john_stuart_mill');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: authorBox(
                              height: height,
                              author: "John Stuart Mill",
                              color: const Color(0xffFDE490)))),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Arthur C Clarke',
                                isAuthCat: true,
                                name: 'arthur_c_clarke');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: authorBox(
                              height: height,
                              author: "Arthur C Clarke",
                              color: const Color(0xffB8D7E9)))),
                  const SizedBox(width: 4),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Arguments args = Arguments(
                                title: 'Jean-Paul Sartre',
                                isAuthCat: true,
                                name: 'jean_paul_sartre');
                            Navigator.of(context)
                                .pushNamed('quotes_page', arguments: args);
                          },
                          child: authorBox(
                              height: height,
                              author: "Jean-Paul Sartre",
                              color: const Color(0xffF6CDDF)))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CatOrAuthArgs {
  final String title;
  final bool isAuthorCat;

  CatOrAuthArgs({
    required this.title,
    required this.isAuthorCat,
  });
}

class Arguments {
  final String title;
  final String name;
  final bool isAuthCat;

  Arguments({required this.title, required this.isAuthCat, required this.name});
}
