import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/views/utils/GlobalVariable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../provider/GlobalProvider.dart';

class CupertinoChatsPage extends StatefulWidget {
  const CupertinoChatsPage({Key? key}) : super(key: key);

  @override
  State<CupertinoChatsPage> createState() => _CupertinoChatsPageState();
}

class _CupertinoChatsPageState extends State<CupertinoChatsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: (ContactList.allContacts.isNotEmpty)
          ? ListView.builder(
        itemCount: ContactList.allContacts.length,
        itemBuilder: (context, i) {
          return CupertinoButton(
            onPressed: () {},
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  FileImage(ContactList.allContacts[i].image as File),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ContactList.allContacts[i].fullName,
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle,
                      ),
                      Text(
                        "+91 ${ContactList.allContacts[i].phoneNumber}",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    CupertinoIcons.phone,
                    color: CupertinoColors.activeGreen,
                  ),
                  onPressed: () async {
                    Uri url = Uri.parse(
                        "tel:+91${ContactList.allContacts[i].phoneNumber}");
                    await launchUrl(url);
                  },
                ),
              ],
            ),
          );
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.person,
              size: 200,
            ),
            Text(
              "You have no Chat Yet!!!",
              style: TextStyle(
                fontSize: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }
}