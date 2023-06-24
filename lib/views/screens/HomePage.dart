import 'package:bhagvat_geeta/controllers/providers/json_decode_provider.dart';
import 'package:bhagvat_geeta/controllers/providers/theme_provider.dart';
import 'package:bhagvat_geeta/models/json_decode_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  Future<void> loadJSON() async {
    await Provider.of<ChapterJsonDecodeProvider>(context, listen: false)
        .loadJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bhagavat Geeta"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: (Provider.of<ThemeProvider>(context).themeModel.isDark)
                ? const Icon(Icons.mode_night)
                : const Icon(Icons.light_mode_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Provider.of<ChapterJsonDecodeProvider>(context)
            .chapterJsonDecodeModel
            .allChapter
            .length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () {
              chapterIndex = index;
              Navigator.of(context).pushNamed("chapter_detail_page");
            },
            leading: Text(
                "${Provider.of<ChapterJsonDecodeProvider>(context, listen: false).chapterJsonDecodeModel.allChapter[index].id}"),
            title: Text(
                Provider.of<ChapterJsonDecodeProvider>(context, listen: false)
                    .chapterJsonDecodeModel
                    .allChapter[index]
                    .nameHindi),
            subtitle: Text(
                "Verses : ${Provider.of<ChapterJsonDecodeProvider>(context, listen: false).chapterJsonDecodeModel.allChapter[index].versesCount}"),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
        ),
      ),
    );
  }
}
