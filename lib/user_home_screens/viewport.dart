import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:intl/intl.dart';


class ViewPortScreen extends StatefulWidget {
  @override
  _ViewPortScreenState createState() => _ViewPortScreenState();

}

class _ViewPortScreenState extends State<ViewPortScreen> {
    
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                          final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  List<Map<String, dynamic>> carData = [];

  @override
  void initState() {
    super.initState();
    printCarData(user?.uid);
  }

Future<bool> _showConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to perform this action?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false when 'No' is pressed
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true when 'Yes' is pressed
            },
          ),
        ],
      );
    },
  );
}

Future<void> deleteCar(String carDocumentID) async {
  try {
    await FirebaseFirestore.instance.collection('carport').doc(carDocumentID).delete();
      Navigator.pushReplacementNamed(context, '/home');
  } catch (e) {
    print('Error deleting car: $e');
  }
}

Future<void> printCarData(uuserid) async {
  try {
    CollectionReference carCollection = _firestore.collection('carport');
    QuerySnapshot querySnapshot = await carCollection.get();

    List<Map<String, dynamic>> carDataList = [];

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      String ownerUserId = data['owner'].id;
     
      if (uuserid == ownerUserId) {
        DocumentReference modelReference = data['model'];

        DocumentSnapshot modelSnapshot = await modelReference.get();

        Map<String, dynamic> modelData = modelSnapshot.data() as Map<String, dynamic>;

                DocumentReference manufacturerReference = modelData['manufacturer']; // Get the manufacturer reference
                        DocumentSnapshot manufacturerSnapshot = await manufacturerReference.get(); // Fetch the referenced document
              Map<String, dynamic> manufacturerData = manufacturerSnapshot.data() as Map<String, dynamic>;

        // Add the model and manufacturer names to the car data
        data['modelName'] = modelData['name'];
        data['manufacturerName'] = manufacturerData['name'];

        carDataList.add(data);
      }
    }

    carData = carDataList; // Update the carData list with retrieved data
  } catch (e) {
    print('Error reading car data: $e');
  }
  setState(() {}); // Update the UI with the retrieved data
}

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            final Insurance = arguments['Insurance'] as String;
            final license = arguments['license'] as dynamic;
            final service = arguments['service'] as dynamic;
            final Model = arguments['Model'] as dynamic;
            final Manufacture = arguments['Manufacture'] as dynamic;
            final dID = arguments['DID'] as dynamic;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Carport',
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
                 Image.network(
                            'https://pettagama.lk/wp-content/uploads/2023/10/Screenshot-2021-12-01-at-2.48-1-1.png',
                            fit: BoxFit.cover,
                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.040),

                        Container(
  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
  child: Align(
    alignment: Alignment.centerLeft,
    child: Text(
      '$Manufacture/$Model',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  ),
),
 Container(
  child: Align(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insurance Expiration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          '$Insurance',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.020),
        Text(
          'License Expiration',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
         Text(
          '$license',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
         SizedBox(height: MediaQuery.of(context).size.height * 0.020),
        Text(
          'Next Service',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
         Text(
          '$service',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),
  ),
),
                SizedBox(height: MediaQuery.of(context).size.height * 0.040),

Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () async {
          bool confirmed = await _showConfirmationDialog(context);

    if (confirmed) {
      deleteCar(dID);
    } else {
      
    }
        },
        style: ElevatedButton.styleFrom(
    primary: Colors.red, // Set the background color to red
    shadowColor: Colors.transparent, // Remove the shadow
  ),
        child: Text("Remove"),
      ),
    ),
    SizedBox(width: 10), // Add some spacing between the buttons
    Expanded(
      child: ElevatedButton(
        onPressed: () {
           Map<String, dynamic> arguments = {
      'Insurance': '${Insurance}',
      'license': '${license}',
      'service': '${service}',
      'Model': '${Model}',
      'Manufacture': '${Manufacture}',
      'DID': '${dID}',
    };

    Navigator.pushNamed(
      context,
      '/edit_port',
      arguments: arguments,
    );
        },
        style: ElevatedButton.styleFrom(
    primary: Color(0xFFF7C910), // Set the background color to F7C910
    shadowColor: Colors.transparent, // Remove the shadow
  ),
        child: Text("Update"),
      ),
    ),
  ],
),
                SizedBox(height: MediaQuery.of(context).size.height * 0.040),
           



             

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
