import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/GlobalProvider.dart';
import '../../../provider/ThemeProvider.dart';
import '../../utils/GlobalVariable.dart';

class CupertinoSettingsPage extends StatefulWidget {
  const CupertinoSettingsPage({super.key});

  @override
  State<CupertinoSettingsPage> createState() => _CupertinoSettingsPageState();
}

class _CupertinoSettingsPageState extends State<CupertinoSettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return CupertinoPageScaffold(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CupertinoListTile(
          title: Text("Profile"),
          subtitle: Text("Update Profile Data"),
          leading: Icon(CupertinoIcons.person),
          trailing: CupertinoSwitch(
              value: Provider.of<GlobalProvider>(context).Profile,
              onChanged: (val) {
                Provider.of<GlobalProvider>(context, listen: false)
                    .ProfileBtn(val);
              }),
        ),
        SizedBox(height: h * 0.02),
        (Provider.of<GlobalProvider>(context).Profile == false)
            ? Container()
            : Container(
                height: h * 0.45,
                width: w,
                child: Padding(
                  padding: EdgeInsets.all(h * 0.02),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () async {
                                        XFile? imageXfile =
                                            await picker?.pickImage(
                                                source: ImageSource.camera);
                                        String ImagePath = imageXfile!.path;
                                        setState(() {
                                          ProfileImage = File(ImagePath);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Icon(CupertinoIcons.camera),
                                          Text("Camera"),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () async {
                                        XFile? imageXfile =
                                            await picker?.pickImage(
                                                source: ImageSource.gallery);
                                        String ImagePath = imageXfile!.path;
                                        setState(() {
                                          ProfileImage = File(ImagePath);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Icon(CupertinoIcons.folder),
                                          Text("File"),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            foregroundImage: (ProfileImage != null)
                                ? FileImage(ProfileImage as File)
                                : null,
                            radius: h * 0.06,
                            child: Icon(
                              CupertinoIcons.camera,
                              size: h * 0.03,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Form(
                          key: SettingFormKey,
                          child: Column(
                            children: [
                              CupertinoTextField(
                                controller: ProfileNameController,
                                textInputAction: TextInputAction.next,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                placeholder: "Enter Your Name...",
                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              CupertinoTextField(
                                controller: ProfileBioController,
                                textInputAction: TextInputAction.done,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                placeholder: "Enter Your Bio...",
                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      if (SettingFormKey.currentState!
                                          .validate()) {
                                        SettingFormKey.currentState!.save();
                                        ProfileNameController.text;
                                        ProfileBioController.text;
                                        ProfileImage;
                                      }
                                    },
                                    child: Text(
                                      "SAVE",
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.06,
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      Provider.of<GlobalProvider>(context,
                                              listen: false)
                                          .Profile = false;

                                      ProfileNameController.clear();
                                      ProfileBioController.clear();

                                      ProfileImage == null;
                                    },
                                    child: Text(
                                      "CLEAR",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        SizedBox(height: h * 0.02),
        CupertinoListTile(
          title: Text("Theme"),
          subtitle: Text("Change Theme"),
          leading: Icon(CupertinoIcons.sun_min),
          trailing: CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context, listen: true).isDark,
            onChanged: (val) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .ChangeAppTheme(val);
            },
          ),
        )
      ],
    ));
  }
}
