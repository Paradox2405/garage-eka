import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class EditProfileScreen extends StatefulWidget {
 
            


 @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
   final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      final TextEditingController emailController = TextEditingController();
      final TextEditingController nameController = TextEditingController();
      final TextEditingController phoneController = TextEditingController();

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
      if(document.id == uuserid){
        print('Document ID: ${document.id}');
        phoneController.text = document['phone'].toString() ?? 'Add Phone Number';
      }
    }
  } catch (e) {
    print('Error reading data: $e');
  }
}

Future<void> updatePhoneNumber(String userId, String newPhoneNumber) async {
  try {
    CollectionReference users = _firestore.collection('users');
    
    DocumentReference userRef = users.doc(userId);

    await userRef.update({'phone': newPhoneNumber});

    print('Phone number updated successfully');
  } catch (e) {
    print('Error updating phone number: $e');
  }
}

Future<void> updateProfileData() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateEmail(emailController.text);
      await user.updateDisplayName(nameController.text);
      updatePhoneNumber(user.uid, phoneController.text);
      Fluttertoast.showToast(
        msg: "Profile Update successful !",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  } catch (e) {
    print('Error updating profile: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
     Navigator.pushReplacementNamed(context, '/profile');
    },
  ),
        title: Text(
          'Edit Profile',
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
              Navigator.pushReplacementNamed(context, '/profile');
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
            ), 
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                
                Align(
  alignment: Alignment.centerLeft,
  child: Text(
    'Edit My Profile',
    style: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.040),
           

           
           TextField(
             controller: nameController,
              decoration: InputDecoration(
                labelText: 'Update Your Name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE3BA12)), 
                ),
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE3BA12)), 
                ),
                ),
            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.020),
TextField(
    controller: emailController, 

              decoration: InputDecoration(
                labelText: 'Update Your Email',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE3BA12)), 
                ),
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE3BA12)),
                ),
                ),
            ),

 SizedBox(height: MediaQuery.of(context).size.height * 0.020),
TextField(
  controller: phoneController, //
              decoration: InputDecoration(
                labelText: 'Update Your Phone',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE3BA12)), 
                ),
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE3BA12)), 
                ),
                ),
            ),

 SizedBox(height: MediaQuery.of(context).size.height * 0.050),

ElevatedButton(
              onPressed: () {
                updateProfileData();
              },
              child: Text(
    'Update Profile',
    style: TextStyle(
      fontSize: 17.0, 
    ),
  ),
              style: ElevatedButton.styleFrom(

    primary: Color(0xFFF7C910),
    onPrimary: Colors.white, 
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
    
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, 
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.home,color: Color(0xFF707477),),
              onPressed: () {
                 Navigator.pushReplacementNamed(context, '/home');
              },
              tooltip: 'Home',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.wrench,color: Color(0xFF707477),),
              onPressed: () {
                // Define the action for the search button
              },
              tooltip: 'Spare Parts',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.plus,color: Color(0xFF707477),),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/manufacture');
              },
              tooltip: 'Add New',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.car,color: Color(0xFF707477),),
              onPressed: () {
                // Define the action for the notifications button
              },
              tooltip: 'Service',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.comment,color: Color(0xFF707477),),
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
