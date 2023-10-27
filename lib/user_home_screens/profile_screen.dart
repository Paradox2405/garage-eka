import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController licenseExpridecontroller =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = user?.email ?? '';
    nameController.text = user?.displayName ?? '';
    fetchData(user?.uid);
  }

  Future<void> fetchData(uuserid) async {
    try {
      CollectionReference users = _firestore.collection('users');

      QuerySnapshot querySnapshot = await users.get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        if (document.id == uuserid) {
          print('Document ID: ${document.id}');
          phoneController.text =
              document['phone'].toString() ?? 'Add Phone Number';
          // Convert the timestamp to a human-readable date
          Timestamp timestamp = document['license-expiry-date'];
          if (timestamp != null) {
            DateTime dateTime = timestamp.toDate();
            String formattedDate =
                "${dateTime.day}/${dateTime.month}/${dateTime.year}"; // You can customize the date format
            licenseExpridecontroller.text = formattedDate;
          } else {
            licenseExpridecontroller.text = 'Add Data';
          }
        }
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF7C910),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Define the action when the button is pressed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.090,
            top: MediaQuery.of(context).size.height * 0.000,
            right: MediaQuery.of(context).size.width * 0.090,
          ), // Adjust the padding as needed
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.040),
              //Content
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              TextField(
                controller: nameController, //
                decoration: InputDecoration(
                  labelText: '',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.020),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              TextField(
                controller: emailController, //
                decoration: InputDecoration(),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.020),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mobile',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              TextField(
                controller: phoneController, //
                decoration: InputDecoration(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.020),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'License expiration date',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              TextField(
                controller: licenseExpridecontroller, //
                decoration: InputDecoration(),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.050),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/edit_profile');
                }, // Use a lambda function to call _signIn
                child: Text(
                  'Update Profile',
                  style: TextStyle(
                    fontSize: 17.0, // Adjust the font size to your preference
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF7C910),
                  onPrimary: Colors.white, // Text color
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.049,
                    top: MediaQuery.of(context).size.height * 0.013,
                    right: MediaQuery.of(context).size.width * 0.049,
                    bottom: MediaQuery.of(context).size.height * 0.013,
                  ),
                  elevation: 0.0,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Adjust the location as needed
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(
            255, 255, 255, 255), // Set the background color of the bottom bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.home,
                color: Color(0xFF707477),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              tooltip: 'Home',
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.wrench,
                color: Color(0xFF707477),
              ),
              onPressed: () {
                // Define the action for the search button
              },
              tooltip: 'Spare Parts',
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.plus,
                color: Color(0xFF707477),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/manufacture');
              },
              tooltip: 'Add New',
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.car,
                color: Color(0xFF707477),
              ),
              onPressed: () {
                // Define the action for the notifications button
              },
              tooltip: 'Service',
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.comment,
                color: Color(0xFF707477),
              ),
              onPressed: () {
                // Define the action for the settings button
              },
              tooltip: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
