import 'dart:io';

class Contact {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  File? image;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.image,
  });
}