import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garage_eka/services_center/add.dart';
import 'package:garage_eka/user/nav.dart';
import 'package:garage_eka/user_home_screens/edit_carport.dart';
import 'package:garage_eka/user_home_screens/edit_profile_screen.dart';
import 'package:garage_eka/user_home_screens/profile_screen.dart';
import 'package:garage_eka/user_home_screens/reminder.dart';
import 'package:garage_eka/user_home_screens/selectmanufacture.dart';
import 'package:garage_eka/user_home_screens/selectmodel.dart';
import 'package:garage_eka/user_home_screens/viewport.dart';
import 'package:garage_eka/workshop/list.dart';
import 'package:garage_eka/workshop/nav.dart';
import 'firebase_options.dart';
import 'package:garage_eka/screens/login_screen.dart';
import 'package:garage_eka/screens/registration_screen.dart';
import 'package:garage_eka/screens/home_screen.dart';
import 'package:garage_eka/services/authentication_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase initialized.');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  final User? user = FirebaseAuth.instance.currentUser;

  Future<Widget> _redirectUserOrAdmin() async {
    if(user!=null){
      final userData = await _auth.readUserData();
      if (userData != null && userData['isAdmin']) {
        return AdminNav();
      } else {
        return MainScreen();
      }
    }
    return LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Auth App',
      home: FutureBuilder<Widget>(
        future: _redirectUserOrAdmin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!;
          }
          return const CircularProgressIndicator();
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/home': (context) => MainScreen(),
        '/admin': (context) => AdminNav(),
      },
    );
  }
}
