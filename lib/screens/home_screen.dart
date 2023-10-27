import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garage_eka/services/authentication_service.dart';

class HomeScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [IconButton(onPressed: ()=>AuthenticationService().signOut(), icon: Icon(Icons.logout_outlined))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Username: ${user?.displayName ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${user?.email ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
