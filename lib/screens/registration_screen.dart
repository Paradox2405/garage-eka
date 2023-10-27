import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_eka/screens/login_screen.dart';
import 'package:garage_eka/services/authentication_service.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isAdmin = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthenticationService _auth = AuthenticationService();
  final FirebaseAuth _authData = FirebaseAuth.instance;

  void _register(BuildContext context) async {
    String? result = await _auth.register(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == "Registered") {
      _addUserToDatabase(_authData.currentUser);
      Fluttertoast.showToast(
        msg: "Registration successful. Please verify your email.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Registration failed. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  _addUserToDatabase(User? currentUser) async {
    // Assuming you've updated _auth.currentUser to User? type
    if (currentUser != null) {
      await firestore.collection('Users').doc(currentUser.uid).set({
        'UserName': currentUser.displayName,
        'Email': currentUser.email,
        'isAdmin':_isAdmin,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.amber, // Set the app theme color
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.amber, Colors.white],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Is Admin?',
                    style: TextStyle(fontSize: 16),
                  ),
                  Checkbox(
                    value: _isAdmin,
                    onChanged: (value) {
                      setState(() {
                        _isAdmin = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _register(context),
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber, // Set the button color
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'Back to Login',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
