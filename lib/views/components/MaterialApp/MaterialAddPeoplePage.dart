import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/ContactModel.dart';
import '../../../provider/GlobalProvider.dart';
import '../../utils/GlobalVariable.dart';

class MaterialAddPeoplePage extends StatefulWidget {
  const MaterialAddPeoplePage({Key? key}) : super(key: key);

  @override
  State<MaterialAddPeoplePage> createState() => _MaterialAddPeoplePageState();
}

class _MaterialAddPeoplePageState extends State<MaterialAddPeoplePage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(h * 0.02),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: h * 0.2,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    XFile? imageXfile =
                                    await picker?.pickImage(
                                        source:
                                        ImageSource.camera);
                                    String ImagePath =
                                        imageXfile!.path;
                                    setState(() {
                                      PeopleImage =
                                          File(ImagePath);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.camera_alt_sharp),
                                      Text("Camara"),
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    XFile? imageXfile =
                                    await picker?.pickImage(
                                        source: ImageSource
                                            .gallery);
                                    String ImagePath =
                                        imageXfile!.path;
                                    setState(() {
                                      PeopleImage =
                                          File(ImagePath);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.folder),
                                      Text("File"),
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                    foregroundImage:
                        (PeopleImage != null) ? FileImage(PeopleImage as File) : null,
                    radius: h * 0.08,
                    child: Icon(
                      Icons.camera_alt,
                      size: h * 0.04,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.04),
                Form(
                  key: AddPeopleFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: NameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Your Name...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          name1 = val;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Full Name",
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TextFormField(
                        controller: PhoneNumberController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Your Valid Mobile Number...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          pn1 = val;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone Number",
                          prefixIcon: Icon(
                            Icons.call,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TextFormField(
                        controller: ChatController,
                        onSaved: (val) {
                          chat = val;
                        },
                        onFieldSubmitted: (val) {
                          if (AddPeopleFormKey.currentState!.validate()) {
                            AddPeopleFormKey.currentState!.save();

                            print("===============================");
                            print(name1);
                            print(pn1);
                            print(chat);
                            print("===============================");
                          }
                        },
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Chat Conversation",
                          prefixIcon: Icon(
                            Icons.chat,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: Provider.of<GlobalProvider>(
                                        context,
                                        listen: false)
                                    .initialDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2024),
                                initialDatePickerMode: DatePickerMode.day,
                              );
                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .PickedDate(date!);
                            },
                            icon: Icon(Icons.calendar_month),
                          ),
                          SizedBox(
                            width: w * 0.02,
                          ),
                          Text(
                            "${Provider.of<GlobalProvider>(context).initialDate.day}/${Provider.of<GlobalProvider>(context).initialDate.month}/${Provider.of<GlobalProvider>(context).initialDate.year}",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              TimeOfDay? PickedTime = await showTimePicker(
                                context: context,
                                initialTime: Provider.of<GlobalProvider>(
                                        context,
                                        listen: false)
                                    .initialTime,
                              );
                              Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .PickedTime(PickedTime!);
                            },
                            icon: Icon(
                              Icons.watch,
                            ),
                          ),
                          SizedBox(
                            width: w * 0.02,
                          ),
                          Text(
                            "${Provider.of<GlobalProvider>(context).initialTime.hour}:${Provider.of<GlobalProvider>(context).initialTime.minute}",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (AddPeopleFormKey.currentState!.validate()) {
                              AddPeopleFormKey.currentState!.save();
                            }
                            NameController.text;
                            PhoneNumberController.text;
                            ChatController.text;
                            Provider.of<GlobalProvider>(context, listen: false)
                                .initialDate
                                .day
                                .toString();
                            Provider.of<GlobalProvider>(context, listen: false)
                                .initialDate
                                .month
                                .toString();
                            Provider.of<GlobalProvider>(context, listen: false)
                                .initialDate
                                .year
                                .toString();
                            Provider.of<GlobalProvider>(context, listen: false)
                                .initialTime!
                                .minute
                                .toString();
                            Provider.of<GlobalProvider>(context, listen: false)
                                .initialTime!
                                .hour
                                .toString();

                            Contact c1 = Contact(
                              fullName: NameController.text,
                              chat: ChatController.text,
                              phoneNumber: PhoneNumberController.text,
                              image: PeopleImage,
                              Dates: Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .initialDate
                                  .toString()
                                  .split("/"),
                              Months: Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .initialDate
                                  .month
                                  .toString()
                                  .split("/"),
                              Years: Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .initialDate
                                  .year
                                  .toString()
                                  .split("/"),
                              Minits: Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .initialTime
                                  .minute
                                  .toString()
                                  .split(":"),
                              Hours: Provider.of<GlobalProvider>(context,
                                      listen: false)
                                  .initialTime
                                  .hour
                                  .toString()
                                  .split(":"),
                            );

                            ContactList.allContacts.add(c1);
                            NameController.clear();
                            PhoneNumberController.clear();
                            ChatController.clear();

                            PeopleImage = null;
                          });
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
