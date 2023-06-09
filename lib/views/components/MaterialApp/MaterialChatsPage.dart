import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/views/utils/GlobalVariable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/ContactModel.dart';

class MaterialChatsPage extends StatefulWidget {
  const MaterialChatsPage({Key? key}) : super(key: key);

  @override
  State<MaterialChatsPage> createState() => _MaterialChatsPageState();
}

class _MaterialChatsPageState extends State<MaterialChatsPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: (ContactList.allContacts.isNotEmpty)
          ? ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  foregroundImage:
                      FileImage(ContactList.allContacts[index].image as File),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: h * 0.5,
                            width: w,
                            child: Padding(
                              padding: EdgeInsets.all(h * 0.02),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    foregroundImage: (PeopleImage != null)
                                        ? FileImage(PeopleImage as File)
                                        : null,
                                    radius: h * 0.08,
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  Text(
                                    ContactList.allContacts[index].fullName,
                                    style: TextStyle(
                                      fontSize: h * 0.025,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  Text(
                                    ContactList.allContacts[index].chat,
                                    style: TextStyle(
                                      fontSize: h * 0.02,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.edit),
                                      ),
                                      SizedBox(width: w * 0.01,),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h  * 0.02,),
                                  ElevatedButton(onPressed: () {}, child: Text("Cancel"),),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.message),
                ),
                title: Text(
                  ContactList.allContacts[index].fullName,
                  style: TextStyle(
                    fontSize: h * 0.025,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              itemCount: ContactList.allContacts.length,
            )
          : const Center(
              child: Text(
                "No Any Chats Yet...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
    );
  }
}
