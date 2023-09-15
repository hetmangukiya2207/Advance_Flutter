import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  sendNotification() async {
    String FCM_API = "https://fcm.googleapis.com/fcm/send";
    var myHeaders = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAALLUJSKY:APA91bFk0-6wLkjsvoiwLbQrEKfvIWxxuTLZnit341oiRc5kBUlUtMZlbSgywk2kxRBhydYZ4XyVprvE5_Ked0WfSCKbhZdqgvwqFMI9nmneTx8Wzf6_F86DUMwI0-0lYMMREe37fkwP"
    };
    var myBody = {
      "to":
          "ebMSmER9RM-YGkPDgHcg85:APA91bE_KW8odPlrMXqOyC5lc1m5uPy1XjsM7vedQctXE-_2Kjr83K4WaJFDY1M6pZe5NK-kb6ocLikdI0Hfs-CNLx21x15ChrvJQONPddrPj4YNbw03q_2a3LCM531LQkRPzUIePaFR",
      "notification": {
        "body": "mmmmmmmmmmmmmmmmmmmmmmmmmmmmm",
        "OrganizationId": "2",
        "content_available": true,
        "priority": "high",
        "subtitle": "Elementary School",
        "title": "Aapko Jo Rakhna Ho Wo"
      },
      "data": {
        "priority": "high",
        "sound": "app_sound.wav",
        "content_available": true,
        "bodyText": "New Announcement assigned",
        "organization": "Elementary school"
      }
    };
    http.Response response = await http.post(Uri.parse(FCM_API),
        headers: myHeaders, body: jsonEncode(myBody));

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      if (decodedData['success'] == 1) {
        log("==========================================");
        log("Notification Sent Successfully");
        log("==========================================");
      } else if (decodedData['success'] == 0) {
        log("==========================================");
        log("Notification Failed.......");
        log("==========================================");
      }
    }
  }
}
