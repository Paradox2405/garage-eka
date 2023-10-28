import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/scheduler.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;



class EditCarportScreen extends StatefulWidget {
  Map<String, dynamic> arguments;
  EditCarportScreen(this.arguments);
  @override
  _EditCarportScreenState createState() => _EditCarportScreenState();
}

class _EditCarportScreenState extends State<EditCarportScreen> {
  
  DateTime selectedDate = DateTime.now();
  DateTime selectedDatel = DateTime.now();
  DateTime selectedDates = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> scheduleNotification() async {
  
}

Future<void> updateDataInFirestore(String carDocumentID) async {
  try {
    DateTime date = DateTime.parse(selectedDate.toString());
    Timestamp timestamp = Timestamp.fromDate(date);

    DateTime datel = DateTime.parse(selectedDatel.toString());
    Timestamp timestampl = Timestamp.fromDate(datel);

    DateTime dates = DateTime.parse(selectedDates.toString());
    Timestamp timestamps = Timestamp.fromDate(dates);

    final User? user = FirebaseAuth.instance.currentUser;

    CollectionReference carportCollection = FirebaseFirestore.instance.collection('carport');

    // Use the provided carDocumentID to reference the specific document to update
    DocumentReference documentReference = carportCollection.doc(carDocumentID);

    // Set the updated data for the document
    await documentReference.set({
      'Insurance-expiration-date': timestampl,
      'license-expiration-date': timestamp,
      'next-service-date': timestamps,
      // You can update other fields here as well
    }, SetOptions(merge: true)); // Use merge option to update specific fields without overwriting

    Fluttertoast.showToast(
      msg: "Vehicle Updated Successfully!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
    print('Data updated in Firestore for document ID: $carDocumentID');
  } catch (e) {
    print('Error updating data in Firestore: $e');
  }
}





  Future<void> _selectDate(BuildContext context) async {
   final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

   Future<void> _selectDates(BuildContext context) async {
   final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDates,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
    if (picked != null && picked != selectedDates) {
      setState(() {
        selectedDates = picked;
      });
    }
  }

  Future<void> _selectDatel(BuildContext context) async {
   final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDatel,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
    if (picked != null && picked != selectedDatel) {
      setState(() {
        selectedDatel = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
  );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
        final arguments = widget.arguments;

            final Insurance = arguments['Insurance'] as String;
            final license = arguments['license'] as dynamic;
            final service = arguments['service'] as dynamic;
            final Model = arguments['Model'] as dynamic;
            final Manufacture = arguments['Manufacture'] as dynamic;
            final dID = arguments['DID'] as dynamic;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text(
          'Update Carport',
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
                'Update Reminders',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
            Container(
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromARGB(255, 183, 179, 179)), // Add a border
    borderRadius: BorderRadius.all(Radius.circular(5.0)), // Optional: Add border radius
    color: Colors.white, // Set background color to white
  ),
  child: Row(
    children: [
      Expanded(
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Insurance Expiration Date',
            border: InputBorder.none, // Remove the border from the input field
            contentPadding: EdgeInsets.all(10),
          ),
          child: Text(
              '${DateFormat('yyyy-MM-dd').format(selectedDatel.toLocal())}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      SizedBox(width: 10), 
      ElevatedButton(
  onPressed: () => _selectDatel(context),
  style: ElevatedButton.styleFrom(
    primary: Colors.white, // Set background color to white
    onPrimary: Colors.black, // Set text/icon color to black
        elevation: 0.0, // Set elevation to 0 to remove the shadow
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(
        Icons.calendar_today,
        color: Colors.black, // Set the icon color to black
      ),
    ],
  ),
),

    ],
  ),
),
             
              SizedBox(height: 50),
                Container(
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromARGB(255, 183, 179, 179)), // Add a border
    borderRadius: BorderRadius.all(Radius.circular(5.0)), // Optional: Add border radius
    color: Colors.white, // Set background color to white
  ),
  child: Row(
    children: [
      Expanded(
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'License Expiration Date',
            border: InputBorder.none, // Remove the border from the input field
            contentPadding: EdgeInsets.all(10),
          ),
          child: Text(
              '${DateFormat('yyyy-MM-dd').format(selectedDate.toLocal())}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      SizedBox(width: 10), 
      ElevatedButton(
  onPressed: () => _selectDate(context),
  style: ElevatedButton.styleFrom(
    primary: Colors.white, // Set background color to white
    onPrimary: Colors.black, // Set text/icon color to black
        elevation: 0.0, // Set elevation to 0 to remove the shadow
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(
        Icons.calendar_today,
        color: Colors.black, // Set the icon color to black
      ),
    ],
  ),
),

    ],
  ),
),

        SizedBox(height: 50),
           Container(
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromARGB(255, 183, 179, 179)), // Add a border
    borderRadius: BorderRadius.all(Radius.circular(5.0)), // Optional: Add border radius
    color: Colors.white, // Set background color to white
  ),
  child: Row(
    children: [
      Expanded(
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Last Service Date',
            border: InputBorder.none, // Remove the border from the input field
            contentPadding: EdgeInsets.all(10),
          ),
          child: Text(
              '${DateFormat('yyyy-MM-dd').format(selectedDates.toLocal())}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      SizedBox(width: 10), 
      ElevatedButton(
  onPressed: () => _selectDates(context),
  style: ElevatedButton.styleFrom(
    primary: Colors.white, // Set background color to white
    onPrimary: Colors.black, // Set text/icon color to black
        elevation: 0.0, // Set elevation to 0 to remove the shadow
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(
        Icons.calendar_today,
        color: Colors.black, // Set the icon color to black
      ),
    ],
  ),
),

    ],
  ),
),



        SizedBox(height: 50),


ElevatedButton(
      onPressed: () {
       updateDataInFirestore(dID);
      },
      style: ElevatedButton.styleFrom(
            primary: Color(0xFFF7C910), // Set the background color to F7C910
            shadowColor: Colors.transparent, // Remove shadow
          ),
       child: Container(
            width: double.infinity, // Make the button take up the full width
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                ),
              ),
            ),
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
