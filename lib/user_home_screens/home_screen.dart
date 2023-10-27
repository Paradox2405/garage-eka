import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); // Define the flutterLocalNotificationsPlugin as a global variable

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');


  List<Map<String, dynamic>> carData = [];

  @override
  void initState() {
    super.initState();
    printCarData(user?.uid);
  }
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'Channel Name', // Replace with your channel name
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Notification Title', // Notification title
      'Notification Body', // Notification body
      platformChannelSpecifics,
    );
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
          data['dID'] = document.id;
          DocumentReference modelReference = data['model'];
          DocumentSnapshot modelSnapshot = await modelReference.get();
          Map<String, dynamic> modelData = modelSnapshot.data() as Map<String, dynamic>;

          DocumentReference manufacturerReference = modelData['manufacturer'];
          DocumentSnapshot manufacturerSnapshot = await manufacturerReference.get();
          Map<String, dynamic> manufacturerData = manufacturerSnapshot.data() as Map<String, dynamic>;

          data['modelName'] = modelData['name'];
          data['modelImage'] = modelData['image'];
          data['manufacturerName'] = manufacturerData['name'];

          carDataList.add(data);
        }
      }

      carData = carDataList;
    } catch (e) {
      print('Error reading car data: $e');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: carData.isEmpty
          ? Center(
        child: carData.isEmpty
            ? Text('No vehicle added')
            : CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: carData.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> data = carData[index];
          return GestureDetector(
            onTap: () {
              Map<String, dynamic> arguments = {
                'Insurance': '${dateFormat.format(data['Insurance-expiration-date'].toDate().toLocal())}',
                'license': '${dateFormat.format(data['license-expiration-date'].toDate().toLocal())}',
                'service': '${dateFormat.format(data['next-service-date'].toDate().toLocal())}',
                'Model': '${data['modelName']}',
                'Manufacture': '${data['manufacturerName']}',
                'DID': '${data['dID']}',
              };

              Navigator.pushNamed(
                context,
                '/view_port',
                arguments: arguments,
              );
            },

            child: Card(
              elevation: 3,
              margin: EdgeInsets.only(left: 20,right: 20,top: 20),

              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      data['modelImage'],
                      fit: BoxFit.cover,
                    ),
                    Text('\nInsurance Expiration Date: ${dateFormat.format(data['Insurance-expiration-date'].toDate().toLocal())}\n'),
                    Text('License Expiration Date: ${dateFormat.format(data['license-expiration-date'].toDate().toLocal())}\n'),
                    Text('Next Service Date: ${dateFormat.format(data['next-service-date'].toDate().toLocal())}\n'),
                    Text('${data['manufacturerName']}/${data['modelName']}'),


                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/manufacture');
        },
        backgroundColor: Color(0xFFF7C910),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}