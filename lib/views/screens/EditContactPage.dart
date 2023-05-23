import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart%20';
import 'package:provider/provider.dart';
import '../../providers/MainPovider.dart';
import '../utils/GlobalUtils.dart';
import 'AddContactPage.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({Key? key}) : super(key: key);

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

GlobalKey<FormState> editContactKey = GlobalKey<FormState>();

TextStyle hintStyle =
TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16);

class _EditContactPageState extends State<EditContactPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      color: (Provider.of<MainProvider>(context).isDarkView != true)
          ? Colors.black
          : Colors.grey,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );
    int index = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        foregroundColor:
        (Provider.of<MainProvider>(context).isDarkView != false)
            ? Colors.white
            : Colors.black,
        backgroundColor:
        (Provider.of<MainProvider>(context).isDarkView != false)
            ? Colors.black45
            : Colors.white,
        elevation: 0,
        title: Text(
          "Edit",
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (editContactKey.currentState!.validate()) {
                editContactKey.currentState!.save();

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    foregroundImage: (Global.allContacts[index].image != null)
                        ? FileImage(Global.allContacts[index].image as File)
                        : null,
                    child: Text(
                      "${Global.allContacts[index].firstName![0].toUpperCase()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 44,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Options"),
                              ),
                              content: Text(
                                "Choose an option to add photo",
                              ),
                              icon: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.clear),
                                ),
                              ),
                              actions: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          child: Text(
                                            "Camera",
                                          ),
                                          onPressed: () async {
                                            XFile? img = await picker.pickImage(
                                              source: ImageSource.camera,
                                            );

                                            setState(() {
                                              Global.allContacts[index].image =
                                                  File(img!.path as String);
                                            });

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text("Gallery"),
                                          onPressed: () async {
                                            XFile? img = await picker.pickImage(
                                              source: ImageSource.gallery,
                                            );

                                            setState(() {
                                              Global.allContacts[index].image =
                                                  File(img!.path as String);
                                            });

                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    mini: true,
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: editContactKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "First Name",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        initialValue: Global.allContacts[index].firstName,
                        onSaved: (val) {
                          Global.allContacts[index].firstName = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter First Name First....";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "First Name",
                          hintStyle: hintStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Last Name",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        initialValue: Global.allContacts[index].lastName,
                        onSaved: (val) {
                          Global.allContacts[index].lastName = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Last Name First....";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Last Name",
                          hintStyle: hintStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Phone Number",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        initialValue: Global.allContacts[index].phone,
                        onSaved: (val) {
                          Global.allContacts[index].phone = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Phone Number First....";
                          }
                          if (val.length != 10) {
                            return "Enter Correct Phone Number....";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone No.",
                          hintStyle: hintStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email",
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        initialValue: Global.allContacts[index].email,
                        onSaved: (val) {
                          Global.allContacts[index].email = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Email First....";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          hintStyle: hintStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}