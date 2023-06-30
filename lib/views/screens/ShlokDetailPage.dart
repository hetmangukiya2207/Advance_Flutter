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
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
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
                "Transaction",
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
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<ShlokJsonDecodeProvider>(context,
                              listen: false)
                          .englishLanguage();
                    },
                    child: const Text('English'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<ShlokJsonDecodeProvider>(context,
                              listen: false)
                          .hindiLanguage();
                    },
                    child: const Text('Hindi'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<ShlokJsonDecodeProvider>(context,
                              listen: false)
                          .gujaratiLanguage();
                    },
                    child: const Text('Gujarati'),
                  ),
                ],
              ),
              SizedBox(
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
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(h * 0.22), // Set the desired height here
                    ),
                    onPressed: () {},
                    child: Text("❤"),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(h * 0.22), // Set the desired height here
                    ),
                    onPressed: () {

                    },
                    child: Text("SHARE"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
