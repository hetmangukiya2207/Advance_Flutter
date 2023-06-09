import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/models/ContactModel.dart';
import 'package:platform_convert_app/views/utils/GlobalVariable.dart';
import 'package:provider/provider.dart';

import '../../../provider/GlobalProvider.dart';

class CupertinoAddPeoplePage extends StatefulWidget {
  const CupertinoAddPeoplePage({Key? key}) : super(key: key);

  @override
  State<CupertinoAddPeoplePage> createState() => _CupertinoAddPeoplePageState();
}

class _CupertinoAddPeoplePageState extends State<CupertinoAddPeoplePage> {
  final ImagePicker picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.16,
            ),
            SizedBox(
              height: h * 0.15,
              width: w,
              child: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              final XFile? imageXfile = await picker.pickImage(
                                source: ImageSource.camera,
                              );
                              String imagePath = imageXfile!.path;
                              setState(() {
                                image = File(imagePath);
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('Camera'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              final XFile? imageXfile = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              String imagePath = imageXfile!.path;
                              setState(() {
                                image = File(imagePath);
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('File'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: h * 0.05,
                  foregroundImage: (image != null) ? FileImage(image!) : null,
                  child: Icon(
                    Icons.camera_alt,
                    size: h * 0.05,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: AddPeopleFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      controller: NameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      placeholder: "Enter Full Name...",
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      controller: PhoneNumberController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      placeholder: "Enter Phone Number...",
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Chat Conversation",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      controller: ChatController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      placeholder: "Enter Conversation...",
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                CupertinoButton(
                    child: Icon(CupertinoIcons.calendar),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          message: SizedBox(
                            height: 200,
                            child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime:
                                Provider.of<GlobalProvider>(context)
                                    .initialDate,
                                dateOrder: DatePickerDateOrder.dmy,
                                onDateTimeChanged: (DateTime date) {
                                  Provider.of<GlobalProvider>(context,
                                      listen: false)
                                      .PickedDate(date);
                                }),
                          ),
                        ),
                      );
                    }),
                Text(
                  "${Provider.of<GlobalProvider>(context).initialDate.day}/${Provider.of<GlobalProvider>(context).initialDate.month}/${Provider.of<GlobalProvider>(context).initialDate.year}",
                ),
              ],
            ),
            Row(
              children: [
                CupertinoButton(
                    child: Icon(CupertinoIcons.time),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          message: SizedBox(
                            height: 200,
                            child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime:
                                Provider.of<GlobalProvider>(context)
                                    .initialDate,
                                dateOrder: DatePickerDateOrder.dmy,
                                onDateTimeChanged: (date) {
                                  Provider.of<GlobalProvider>(context,
                                      listen: false)
                                      .PickedTime(date as TimeOfDay);
                                }),
                          ),
                        ),
                      );
                    }),
                Text(
                  "${Provider.of<GlobalProvider>(context).initialTime.hour}:${Provider.of<GlobalProvider>(context).initialTime.minute}",
                ),
              ],
            ),
            CupertinoButton(
              onPressed: () {
                if (AddPeopleFormKey.currentState!.validate()) {
                  AddPeopleFormKey.currentState!.save();
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
                }
              },
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
              color: CupertinoColors.activeBlue,
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}