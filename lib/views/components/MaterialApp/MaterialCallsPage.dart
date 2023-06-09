import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/GlobalVariable.dart';

class MaterialCallsPage extends StatefulWidget {
  const MaterialCallsPage({Key? key}) : super(key: key);

  @override
  State<MaterialCallsPage> createState() => _MaterialCallsPageState();
}

class _MaterialCallsPageState extends State<MaterialCallsPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: (ContactList.allContacts.isEmpty)
          ? Container(
              alignment: Alignment.center,
              child: const Text("No Any Calls Yet..."),
            )
          : ListView.builder(
              itemCount: ContactList.allContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: IconButton(
                    onPressed: () async {
                      Uri url = Uri.parse("tel:+91${ContactList.allContacts[index].phoneNumber}");

                      await launchUrl(url);
                    },
                    icon: Icon(
                      Icons.call,
                    ),
                  ),
                  title: Text(
                    ContactList.allContacts[index].fullName,
                    style: TextStyle(
                      fontSize: h * 0.025,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle:
                      Text("+91 ${ContactList.allContacts[index].phoneNumber}",style: TextStyle(
                        fontSize: h * 0.02,
                        fontWeight: FontWeight.w400,
                      ),),
                  leading: CircleAvatar(
                    radius: h * 0.04,
                    foregroundImage:
                        (ContactList.allContacts[index].image != null)
                            ? FileImage(ContactList.allContacts[index].image!)
                            : null,
                  ),
                );
              },
            ),
    );
  }
}
