import 'package:chat_app_using_firebase/helper/AuthHelper.dart';
import 'package:chat_app_using_firebase/helper/FirestoreHelper.dart';
import 'package:chat_app_using_firebase/views/componets/Global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Are You Sure.."),
            content: Text("Do you Want to Exit..."),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Future.delayed(Duration.zero, () {
                      Get.until((route) => route.isFirst);
                    });
                  },
                  child: Text("Yes")),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("No"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        key: ScaffoldKey,
        drawer: Drawer(
          width: 300,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 80,
                foregroundImage: NetworkImage(
                    "${AuthHelper.auth_helper.firebaseAuth.currentUser?.photoURL}"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "${AuthHelper.auth_helper.firebaseAuth.currentUser?.email?.split("@")[0]}"),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Text("${AuthHelper.auth_helper.firebaseAuth.currentUser?.email}"),
              Divider(),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
              "Welcome ${AuthHelper.auth_helper.firebaseAuth.currentUser?.email?.split("@")[0]}"),
          leading: GestureDetector(
            onTap: () {
              ScaffoldKey.currentState?.openDrawer();
            },
            child: CircleAvatar(
              foregroundImage: NetworkImage(
                  "${AuthHelper.auth_helper.firebaseAuth.currentUser?.photoURL}"),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  AuthHelper.auth_helper.SignOut();
                  Get.offAllNamed('/LoginPage');
                },
                icon: Icon(Icons.power_settings_new))
          ],
        ),
        body: StreamBuilder(
          stream: FirestoreHelper.fireStore_Helper.fetchUsers(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>> my_data = snapshot.data;
              List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                  (my_data == null) ? [] : my_data.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                      child: ListTile(
                        onTap: () async {
                          Get.offAllNamed(
                            '/ChatPage',
                            arguments: <String>[
                              AuthHelper
                                  .auth_helper.firebaseAuth.currentUser!.uid,
                              data[i]['uid'],
                              data[i]['email']
                            ],
                          );
                          AllStreamMessages = await FirestoreHelper
                              .fireStore_Helper
                              .DisplayMessage(
                                  uid1: AuthHelper.auth_helper.firebaseAuth
                                      .currentUser!.uid,
                                  uid2: data[i]['uid']);
                        },
                        title: Text("${data[i]['email']}"),
                        subtitle: Text("${data[i]['uid']}"),
                        trailing: IconButton(
                          onPressed: () async {
                            await FirestoreHelper.fireStore_Helper
                                .deleteUser(uid: data[i]['uid']);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: LinearProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
