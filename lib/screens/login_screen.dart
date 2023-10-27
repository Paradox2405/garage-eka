import 'package:flutter/material.dart';
import 'package:garage_eka/services/authentication_service.dart';
import 'package:garage_eka/screens/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthenticationService _auth = AuthenticationService();

  void _signIn(BuildContext context) async {
    String? result = await _auth.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == "Signed in") {
      final userData=await _auth.readUserData();
      // Navigate to Home Screen
     if(userData!=null && userData['isAdmin']){
       Navigator.pushReplacementNamed(context, '/admin');
     }else {
       Navigator.pushReplacementNamed(context, '/home');
     }
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Sign-in failed. Please try again.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.amber, // Set the app theme color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            ElevatedButton(
              onPressed: () => _signIn(context),
              child: Text('Sign In'),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, // Set the button color
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => _navigateToRegister(context),
              child: Text(
                'Create an Account',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
