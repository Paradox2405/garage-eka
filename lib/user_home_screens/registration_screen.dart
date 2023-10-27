import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_eka/services/authentication_service.dart';
import 'package:garage_eka/screens/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthenticationService _auth = AuthenticationService();

  void _register(BuildContext context) async {
    String? result = await _auth.register(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == "Registered") {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Color(0xFFF7C910),
      body: Padding(
         padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.10,
          top: MediaQuery.of(context).size.height * 0.18,
          right: MediaQuery.of(context).size.width * 0.10,
        ),
        child: Column(
          children: [
             Text(
                'Registration', // Add your heading text here
                style: TextStyle(
                fontSize: 30, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // You can change the fontWeight
              ),
            ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.090), // Add a top margin of 10% of the screen height

             TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Enter Your Username',
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
            
            SizedBox(height: MediaQuery.of(context).size.height * 0.020), // Add a top margin of 10% of the screen height

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


            SizedBox(height: MediaQuery.of(context).size.height * 0.020), // Add a top margin of 10% of the screen height

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Enter Your Password',
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

            
            
                       SizedBox(height: MediaQuery.of(context).size.height * 0.050), // Add a top margin of 10% of the screen height
 ElevatedButton(
              onPressed: () => _register(context), // Use a lambda function to call _signIn
              child: Text(
    'Register',
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
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
             child: Text(
    'Back to Login',
    style: TextStyle(
      color: Colors.white, 
      fontSize: 18.0, // Adjust the font size to your preference
    ),
  ),
            ),

            
          ],
        ),
      ),
    );
  }
}
