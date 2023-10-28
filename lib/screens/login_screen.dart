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
      backgroundColor:Color(0xFFF7C910),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.10,
          top: MediaQuery.of(context).size.height * 0.10,
          right: MediaQuery.of(context).size.width * 0.10,
        ),

        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.070), // Add a top margin of 10% of the screen height
            Text(
              'Log In', // Add your heading text here
              style: TextStyle(
                fontSize: 30, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // You can change the fontWeight
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.080), // Add a top margin of 10% of the screen height
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter Your Email',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE3BA12)), // Border color when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE3BA12)), // Border color when not focused
                ),
                fillColor: Color(0xFFE3BA12), // Background color
                filled: true,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.030), // Add a top margin of 10% of the screen height
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter Your Password',
                fillColor: Color(0xFFE3BA12), // Background color
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE3BA12)), // Border color when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE3BA12)), // Border color when not focused
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _signIn(context), // Use a lambda function to call _signIn
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18.0, // Adjust the font size to your preference
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Background color
                onPrimary: Colors.black, // Text color
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.10,
                  top: MediaQuery.of(context).size.height * 0.018,
                  right: MediaQuery.of(context).size.width * 0.10,
                  bottom: MediaQuery.of(context).size.height * 0.018,
                ),
                elevation: 0.0,
              ),

            ),
            SizedBox(height: 10), // Add some space
            TextButton(
              onPressed: () => _navigateToRegister(context), // Call the navigation function
              child: Text(
                'Register Now',
                style: TextStyle(
                  color: Colors.white, // Set the text color to blue
                  fontSize: 18.0, // Set the font size to 16.0 (adjust as needed)
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
