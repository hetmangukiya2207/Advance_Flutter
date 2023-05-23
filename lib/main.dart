import 'dart:io';
import 'package:contact_diary_app/providers/MainPovider.dart';
import 'package:contact_diary_app/views/screens/AddContactPage.dart';
import 'package:contact_diary_app/views/screens/DetailsPage.dart';
import 'package:contact_diary_app/views/screens/EditContactPage.dart';
import 'package:contact_diary_app/views/screens/Splashscreen.dart';
import 'package:contact_diary_app/views/utils/GlobalUtils.dart';
import 'package:contact_diary_app/views/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: (Provider.of<MainProvider>(context).isDarkView != true)
            ? ThemeData.light()
            : ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          'add_contact_page': (context) => addContactPage(),
          'splash_screen': (context) => splashScreen(),
          'detail_page': (context) => DetailPage(),
          'edit_contact_page': (context) => EditContactPage(),
          '/': (context) => Consumer<MainProvider>(
            builder: (context, provider, child) => Scaffold(
              appBar: AppBar(
                foregroundColor: (provider.isDarkView != false)
                    ? Colors.white
                    : Colors.black,
                backgroundColor: (provider.isDarkView != false)
                    ? Colors.black26
                    : Colors.white,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {
                      provider.changeTheme();
                    },
                    icon: const Icon(
                      Icons.circle,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      provider.changeView();
                    },
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                  ),
                ],
                title: const Text(
                  "Contacts",
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context)
                        .pushNamed('add_contact_page')
                        .then((value) => setState(() {}));

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
                child: Icon(Icons.add),
              ),
              body: Container(
                  alignment: Alignment.center,
                  child: (Global.allContacts.isEmpty)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath + P1,
                        color: (provider.isDarkView != false)
                            ? Colors.white
                            : Colors.black,
                        width: 120,
                      ),
                      Text(
                        "You have no contacts yet",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      )
                    ],
                  )
                      : (provider.isGridView != true)
                      ? ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('detail_page',
                              arguments:
                              Global.allContacts[index])
                              .then((value) => setState(() {}));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          foregroundImage:
                          (Global.allContacts[index].image !=
                              null)
                              ? FileImage(Global
                              .allContacts[index]
                              .image as File)
                              : null,
                          child: Text(
                            "${Global.allContacts[index].firstName![0].toUpperCase()}",
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                            "${Global.allContacts[index].firstName} ${Global.allContacts[index].lastName}"),
                        subtitle: Text(
                            "+91 ${Global.allContacts[index].phone}"),
                        trailing: IconButton(
                          onPressed: () async {
                            Uri call = Uri(
                              scheme: 'tel',
                              path:
                              Global.allContacts[index].phone,
                            );
                            await launchUrl(call);
                          },
                          icon: Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
                    itemCount: Global.allContacts.length,
                  )
                      : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: Global.allContacts.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('detail_page',
                                arguments:
                                Global.allContacts[index])
                                .then((value) => setState(() {}));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 12,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  child: Text(
                                    "${Global.allContacts[index].firstName![0].toUpperCase()}",
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  radius: 40,
                                  foregroundImage: (Global
                                      .allContacts[index]
                                      .image !=
                                      null)
                                      ? FileImage(Global
                                      .allContacts[index]
                                      .image as File)
                                      : null,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${Global.allContacts[index].firstName} ${Global.allContacts[index].lastName}",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "+91 ${Global.allContacts[index].phone}",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            ),
          ),
        });
  }
}