import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/provider/ThemeProvider.dart';
import 'package:provider/provider.dart';
import '../../../provider/GlobalProvider.dart';
import '../../utils/GlobalVariable.dart';

class MaterialSettingsPage extends StatefulWidget {
  const MaterialSettingsPage({Key? key}) : super(key: key);

  @override
  State<MaterialSettingsPage> createState() => _MaterialSettingsPageState();
}

class _MaterialSettingsPageState extends State<MaterialSettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(h * 0.02),
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: h * 0.04,
                  ),
                  SizedBox(
                    width: w * 0.08,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile",
                      ),
                      Text(
                        "Update Profile Data",
                      ),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                      value: Provider.of<GlobalProvider>(context).Profile,
                      onChanged: (val) {
                        Provider.of<GlobalProvider>(context, listen: false)
                            .ProfileBtn(val);
                      }),
                ],
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
                                                  ProfileImage =
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
                                                  ProfileImage =
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
                                foregroundImage: (ProfileImage != null)
                                    ? FileImage(ProfileImage as File)
                                    : null,
                                radius: h * 0.06,
                                child: Icon(
                                  Icons.camera_alt,
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
                                  TextFormField(
                                    controller: ProfileNameController,
                                    onSaved: (val) {
                                      ProfileName = val;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Your Name...",
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  TextFormField(
                                    controller: ProfileBioController,
                                    onSaved: (val) {
                                      ProfileBio = val;
                                    },
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Your Bio...",
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (SettingFormKey.currentState!
                                              .validate()) {
                                            SettingFormKey.currentState!.save();
                                            ProfileNameController.text;
                                            ProfileBioController.text;
                                            ProfileImage;
                                          }
                                        },
                                        child: const Text(
                                          "SAVE",
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.06,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Provider.of<GlobalProvider>(context,
                                                  listen: false)
                                              .Profile = false;

                                          ProfileNameController.clear();
                                          ProfileBioController.clear();

                                          ProfileImage == null;
                                        },
                                        child: const Text(
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
              Row(
                children: [
                  Icon(
                    Icons.sunny,
                    size: h * 0.04,
                  ),
                  SizedBox(
                    width: w * 0.08,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Theme",
                      ),
                      Text(
                        "Chnage Theme",
                      ),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                    value:
                        Provider.of<ThemeProvider>(context, listen: true).isDark,
                    onChanged: (val) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .ChangeAppTheme(val);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
