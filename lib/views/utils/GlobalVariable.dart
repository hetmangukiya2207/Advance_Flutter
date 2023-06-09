import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/ContactModel.dart';

PageController pageController = PageController();

ImagePicker? picker = ImagePicker();

File? PeopleImage;
File? ProfileImage;


final GlobalKey<FormState> AddPeopleFormKey = GlobalKey<FormState>();
final GlobalKey<FormState> ChatPageKey = GlobalKey<FormState>();
final GlobalKey<FormState> SettingFormKey = GlobalKey<FormState>();

final TextEditingController NameController = TextEditingController();
String? name1;
final TextEditingController PhoneNumberController = TextEditingController();
String? pn1;
final TextEditingController ChatController = TextEditingController();
String? chat;

final TextEditingController ProfileNameController = TextEditingController();
String? ProfileName;
final TextEditingController ProfileBioController = TextEditingController();
String? ProfileBio;

class ContactList{
  static List<Contact> allContacts = [];
}

final TextEditingController ChatName = TextEditingController();
String? ChatFullName;

final TextEditingController ChatChat = TextEditingController();
String? ChatChatName;






