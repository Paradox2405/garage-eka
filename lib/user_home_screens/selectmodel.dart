import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:garage_eka/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModelScreen extends StatefulWidget {



  
  @override
  _ModelScreenState createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> manufacturers = [];

  @override
  void initState() {
    super.initState();
    
  }

Future<void> getAllManufacturers(String documentId) async {
  try {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('models').get();

  if (querySnapshot.docs.isNotEmpty) {
    List<DocumentSnapshot> filteredManufacturers = [];

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;

      DocumentReference manufactureReference = data['manufacturer'] as DocumentReference;
      String manufacturePath = manufactureReference.path;
      List<String> pathParts = manufacturePath.split('/');
      String manufactureDocumentId = pathParts.last;

      if (manufactureDocumentId == documentId) {
        // Keep the document if the manufacturer matches the desired "documentId"
        filteredManufacturers.add(doc);
      }
    }

    setState(() {
      manufacturers = filteredManufacturers;
    });
  } else {
    print('No documents found in the "models" collection.');
  }
} catch (e) {
  print('Error getting documents: $e');
}

}



  @override
  Widget build(BuildContext context) {
          final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            final manufacturerName = arguments['manufacturerName'] as String;
            final documentId = arguments['DocumentID'] as dynamic;
            getAllManufacturers(documentId); // Call to fetch data
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/manufacture');
          },
        ),
        title: Text(
          '${manufacturerName}',
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
                'Which Model ?',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
             GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Display two items per row
                  crossAxisSpacing: 10, // Add horizontal spacing between items
                  mainAxisSpacing: 10, // Add vertical spacing between items
                ),
                itemCount: manufacturers.length,
                itemBuilder: (context, index) {
                  var data = manufacturers[index].data() as Map<String, dynamic>;
                  String manufacturerName = data['name'];
                  String manufacturerImage = data['image'];
                  String documentId = manufacturers[index].id;

                  return ImageTextButton(
                    imagePath: manufacturerImage,
                    buttonText: manufacturerName,
                    manufacturerName: manufacturerName,
                    documentId: documentId,
                  );
                },
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
        print('Button $documentId pressed');
        Map<String, dynamic> arguments = {
                'DocumentID': documentId,
            };
          Navigator.pushReplacementNamed(context, '/reminder', arguments: arguments);
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
            width: 100,
            height: 100,
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
