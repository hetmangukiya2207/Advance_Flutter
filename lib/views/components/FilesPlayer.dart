import 'package:flutter/material.dart';

class FilesPlayer extends StatefulWidget {
  const FilesPlayer({super.key});

  @override
  State<FilesPlayer> createState() => _FilesPlayerState();
}

class _FilesPlayerState extends State<FilesPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No Downloaded Song Available...",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
