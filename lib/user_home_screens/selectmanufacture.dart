import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:garage_eka/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManufactureScreen extends StatefulWidget {
  @override
  _ManufactureScreenState createState() => _ManufactureScreenState();
}

class _ManufactureScreenState extends State<ManufactureScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> manufacturers = [];

  @override
  void initState() {
    super.initState();
    getAllManufacturers(); // Call to fetch data
  }

  Future<void> getAllManufacturers() async {
    try {
      CollectionReference manufacturersCollection = FirebaseFirestore.instance.collection('manufacturers');
      QuerySnapshot querySnapshot = await manufacturersCollection.get();

      setState(() {
        manufacturers = querySnapshot.docs;
      });
    } catch (e) {
      print('Error getting manufacturers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text(
          'Manufacturers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
            top: MediaQuery.of(context).size.height * 0.020,
            right: MediaQuery.of(context).size.width * 0.090,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Which car do you drive?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
  padding: const EdgeInsets.all(10), // Add padding for spacing around the list
  child: ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: (manufacturers.length / 2).ceil(),
    itemBuilder: (context, index) {
      var data1 = manufacturers[index * 2].data() as Map<String, dynamic>;
      String manufacturerName1 = data1['name'];
      String manufacturerImage1 = data1['logo'];
      String documentId1 = manufacturers[index * 2].id;

      Widget item1 = Container(
        padding: EdgeInsets.symmetric(horizontal: 0), // Add padding for spacing between items
        child: ImageTextButton(
          imagePath: manufacturerImage1,
          buttonText: manufacturerName1,
          manufacturerName: manufacturerName1,
          documentId: documentId1,
        ),
      );

      Widget item2;

      if (index * 2 + 1 < manufacturers.length) {
        var data2 = manufacturers[index * 2 + 1].data() as Map<String, dynamic>;
        String manufacturerName2 = data2['name'];
        String manufacturerImage2 = data2['logo'];
        String documentId2 = manufacturers[index * 2 + 1].id;

        item2 = Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10), // Add padding for spacing between items
          child: ImageTextButton(
            imagePath: manufacturerImage2,
            buttonText: manufacturerName2,
            manufacturerName: manufacturerName2,
            documentId: documentId2,
          ),
        );
      } else {
        item2 = SizedBox(width: 10); // Add an empty space for even item count
      }

      return Row(
        children: [item1, item2],
      );
    },
  ),
),
              SizedBox(height: 10),
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
              icon: Icon(FontAwesomeIcons.home, color: Color(0xFF707477)),
              onPressed: () {
                 Navigator.pushReplacementNamed(context, '/home');
              },
              tooltip: 'Home',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.wrench, color: Color(0xFF707477)),
              onPressed: () {
                // Define the action for the search button
              },
              tooltip: 'Spare Parts',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.plus, color: Color(0xFF707477)),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/manufacture');
              },
              tooltip: 'Add New',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.car, color: Color(0xFF707477)),
              onPressed: () {
                // Define the action for the notifications button
              },
              tooltip: 'Service',
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.comment, color: Color(0xFF707477)),
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

class ImageTextButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final String manufacturerName;
  final String documentId;

  ImageTextButton({
    required this.imagePath,
    required this.buttonText,
    required this.manufacturerName,
    required this.documentId,
  });

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      print('Manufacturer Name: $manufacturerName'); // Add this line for debugging
      Map<String, dynamic> arguments = {
        'manufacturerName': manufacturerName,
        'DocumentID': documentId,
      };
      Navigator.pushReplacementNamed(context, '/model', arguments: arguments);
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        borderRadius: BorderRadius.circular(10), // Set border radius to 6
      ),
      padding: EdgeInsets.all(10), // Add padding
      child: Column(
        children: [
          Image.network(
            imagePath,
            width: 110,
            height: 110,
          ),
          SizedBox(height: 10),
          Text(
            buttonText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
}
