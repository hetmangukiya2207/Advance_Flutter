import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/GlobalVariable.dart';

class CupertinoCallsPage extends StatefulWidget {
  const CupertinoCallsPage({Key? key}) : super(key: key);
  @override
  State<CupertinoCallsPage> createState() => _CupertinoCallsPageState();
}

class _CupertinoCallsPageState extends State<CupertinoCallsPage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: (ContactList.allContacts.isNotEmpty)
          ? ListView.builder(
        itemCount: ContactList.allContacts.length,
        itemBuilder: (context, i) {
          return CupertinoListTile(
            onTap: () {},
            leading: CircleAvatar(
              radius: 30,
              foregroundImage:
              FileImage(ContactList.allContacts[i].image as File),
            ),
            title: Text(ContactList.allContacts[i].fullName),
            subtitle: Text("+91 ${ContactList.allContacts[i].phoneNumber}"),
            trailing: CupertinoButton(
              padding: const EdgeInsets.all(16),
              child: const Icon(
                CupertinoIcons.phone,
                color: CupertinoColors.activeGreen,
              ),
              onPressed: () async {
                Uri url = Uri.parse(
                    "tel:+91${ContactList.allContacts[i].phoneNumber}");
                await launchUrl(url);
              },
            ),
          );
        },
      )
          : const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.import_contacts_outlined,
              size: 200,
            ),
            Text(
              "You have no contact Yet!!!",
              style: TextStyle(
                fontSize: 21,
              ),
            )
          ],
        ),
      ),
    );
  }
}