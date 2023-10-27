// firebase_service.dart

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    assert(token != null);
    print("FCM Token: $token");

    // Here, you can optionally send this token to your server or save it locally.
  }
}
