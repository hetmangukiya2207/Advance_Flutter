import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart ';
import 'package:provider/provider.dart';

import '../../models/ContactModel.dart';
import '../../providers/MainPovider.dart';
import '../utils/GlobalUtils.dart';

class addContactPage extends StatefulWidget {
  @override
  State<addContactPage> createState() => _addContactPageState();
}

ImagePicker picker = ImagePicker();

GlobalKey<FormState> addContactKey = GlobalKey<FormState>();

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController emailController = TextEditingController();

TextStyle hintStyle =
const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16);

class _addContactPageState extends State<addContactPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      color: (Provider.of<MainProvider>(context).isDarkView != true)
          ? Colors.black
          : Colors.grey,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    );

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ), 
        title: Text(
          "Add",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (addContactKey.currentState!.validate()) {
                addContactKey.currentState!.save();

                Contact c1 = Contact(
                  firstName: Global.firstName,
                  lastName: Global.lastName,
                  phone: Global.phone,
                  email: Global.email,
                  image: Global.image,
                );
                Global.allContacts.add(c1);
                Navigator.of(context).pop();
              }

              setState(() {
                addContactKey.currentState!.reset();

                firstNameController.clear();
                lastNameController.clear();
                phoneNumberController.clear();
                emailController.clear();

                Global.firstName = null;
                Global.lastName = null;
                Global.phone = null;
                Global.email = null;
                Global.image = null;
              });
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
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.black),
                    ),
                    foregroundImage: (Global.image != null)
                        ? FileImage(Global.image as File)
                        : null,
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
                                              Global.image =
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
                                              Global.image =
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
                key: addContactKey,
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
                        onSaved: (val) {
                          Global.firstName = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter First Name First....";
                          }
                          return null;
                        },
                        controller: firstNameController,
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
                        onSaved: (val) {
                          Global.lastName = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Last Name First....";
                          }
                          return null;
                        },
                        controller: lastNameController,
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
                        onSaved: (val) {
                          Global.phone = val;
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
                        controller: phoneNumberController,
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
                        onSaved: (val) {
                          Global.email = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Email First....";
                          }
                          return null;
                        },
                        // onFieldSubmitted: (val) {
                        //   Navigator.of(context).pop();
                        //   setState(() {
                        //     if (addContactKey.currentState!.validate()) {
                        //       addContactKey.currentState!.save();
                        //
                        //       Contact c1 = Contact(
                        //         firstName: Global.firstName,
                        //         lastName: Global.lastName,
                        //         phone: Global.phone,
                        //         email: Global.email,
                        //         image: Global.image,
                        //       );
                        //       Global.allContacts.add(c1);
                        //     }
                        //   });
                        //   setState(() {});
                        // },
                        controller: emailController,
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