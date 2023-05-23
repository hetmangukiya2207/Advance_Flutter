import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../models/ContactModel.dart';
import '../../providers/MainPovider.dart';
import '../utils/GlobalUtils.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Contact data = ModalRoute.of(context)!.settings.arguments as Contact;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        elevation: 0,
        foregroundColor:
        (Provider.of<MainProvider>(context).isDarkView != false)
            ? Colors.white
            : Colors.black,
        backgroundColor:
        (Provider.of<MainProvider>(context).isDarkView != false)
            ? Colors.black26
            : Colors.white,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    CircleAvatar(
                      child: Text(
                        "${data.firstName![0].toUpperCase()}",
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.grey,
                      radius: 70,
                      foregroundImage: (data.image != null)
                          ? FileImage(data.image as File)
                          : null,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(
                              'edit_contact_page',
                              arguments: Global.allContacts.indexOf(data),
                            )
                                .then((value) => setState(() {}));
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "${data.firstName} ${data.lastName}",
                  style: TextStyle(
                    color:
                    (Provider.of<MainProvider>(context).isDarkView != false)
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SelectableText(
                  "+91 ${data.phone}",
                  style: TextStyle(
                    color:
                    (Provider.of<MainProvider>(context).isDarkView != false)
                        ? Colors.white.withOpacity(0.9)
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  thickness: 1.2,
                  color:
                  (Provider.of<MainProvider>(context).isDarkView != false)
                      ? Colors.white
                      : Colors.black,
                  endIndent: 10,
                  indent: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        Uri call = Uri(
                          scheme: 'tel',
                          path: data.phone,
                        );
                        await launchUrl(call);
                      },
                      child: Icon(Icons.phone_rounded),
                      backgroundColor: Colors.green,
                      foregroundColor:
                      (Provider.of<MainProvider>(context).isDarkView !=
                          false)
                          ? Colors.white
                          : Colors.white,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        Uri message = Uri(
                          scheme: 'sms',
                          path: data.phone,
                        );
                        await launchUrl(message);
                      },
                      child: Icon(Icons.message_rounded),
                      backgroundColor: Colors.amber,
                      foregroundColor:
                      (Provider.of<MainProvider>(context).isDarkView !=
                          false)
                          ? Colors.white
                          : Colors.white,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        Uri email = Uri(
                          scheme: 'mailto',
                          path: data.email,
                        );
                        await launchUrl(email);
                      },
                      child: Icon(Icons.email_rounded),
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor:
                      (Provider.of<MainProvider>(context).isDarkView !=
                          false)
                          ? Colors.white
                          : Colors.white,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        await Share.shareXFiles([
                          XFile(data.image!.path),
                        ],
                            text:
                            ("Name : ${data.firstName} ${data.lastName}\nContact : ${data.phone}"));
                      },
                      child: Icon(Icons.share_rounded),
                      backgroundColor: Colors.orange,
                      foregroundColor:
                      (Provider.of<MainProvider>(context).isDarkView !=
                          false)
                          ? Colors.white
                          : Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1.2,
                  color:
                  (Provider.of<MainProvider>(context).isDarkView != false)
                      ? Colors.white
                      : Colors.black,
                  endIndent: 10,
                  indent: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}