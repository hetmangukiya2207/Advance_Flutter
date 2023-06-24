import 'package:bhagvat_geeta/controllers/providers/json_decode_provider.dart';
import 'package:bhagvat_geeta/models/json_decode_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShlokDetailPage extends StatefulWidget {
  const ShlokDetailPage({Key? key}) : super(key: key);

  @override
  State<ShlokDetailPage> createState() => _ShlokDetailPageState();
}

class _ShlokDetailPageState extends State<ShlokDetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
        .englishLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
            .shlokJsonDecodeModel
            .allShloks[shlokIndex]
            .verse),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
                    .shlokJsonDecodeModel
                    .allShloks[shlokIndex]
                    .sanskrit,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Translation",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Provider.of<ShlokJsonDecodeProvider>(context,
                              listen: false)
                          .englishLanguage();
                    },
                    child: const Text('English'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<ShlokJsonDecodeProvider>(context,
                              listen: false)
                          .hindiLanguage();
                    },
                    child: const Text('Hindi'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<ShlokJsonDecodeProvider>(context,
                              listen: false)
                          .gujaratiLanguage();
                    },
                    child: const Text('Gujarati'),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Provider.of<ShlokJsonDecodeProvider>(context)
                    .shlokJsonDecodeModel
                    .allShloks[shlokIndex]
                    .translation,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
