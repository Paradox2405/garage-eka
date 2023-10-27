import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage_eka/services_center/appointments.dart';

class ServiceSlotBookingPage extends StatefulWidget {
  final Map<String, dynamic>? data;
  ServiceSlotBookingPage(this.data);
  @override
  _ServiceSlotBookingPageState createState() => _ServiceSlotBookingPageState();
}

class _ServiceSlotBookingPageState extends State<ServiceSlotBookingPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String? _brandValue = null; // to hold selected brand value
  String? _modelValue = null; // to hold selected model value

  String? selectedSlot;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? bookedSlot;

  @override
  void initState() {
    super.initState();
    // fetchBookedSlot();
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return "${now.month}/${now.day}/${now.year}";
  }

  Future<bool> saveToFirestore() async {
    if (selectedSlot == null) {
      _showSnackBar("Select a slot");
      return false;
    } else if (_nameController.text.isEmpty) {
      _showSnackBar("Type a name");
      return false;
    } else if (_mobileController.text.isEmpty) {
      _showSnackBar("Type a number");
      return false;
    } else if (_brandValue == null) {
      _showSnackBar("Select a brand");
      return false;
    } else if (_modelValue == null) {
      _showSnackBar("Select a model");
      return false;
    } else {
      return _saveDataToFirestore();
    }
  }

  Future<bool> _saveDataToFirestore() async {
    try {
      await firestore.collection('bookedSlots').add({
        'date': getCurrentDate(),
        'servicecenterid': widget.data?['userid'] ?? "789",
        'time': selectedSlot,
        'name': _nameController.text,
        'mobile': _mobileController.text,
        'brand': _brandValue,
        'model': _modelValue,
        'status':'Pending'
      });
      print("Data saved successfully with auto-generated ID.");
      return true;
    } catch (e) {
      print("Error saving data: $e");
      return false;
    }
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(message),
        ),
        duration: Duration(seconds: 3), // You can set the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> allTimes = [
      '8.00 am',
      '9.00 am',
      '10.00 am',
      '11.00 am',
      '1.00 pm',
      '2.00 pm',
      '4.00 pm'
    ];

    List<String> availableTimes =
        allTimes.where((time) => time != bookedSlot).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Service Centers'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        'ATI Auto Care',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: ()   {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Appointments(),
                            ),
                          );
                        },
                        child: Text('View Appointments'),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Pick a time from available slots'),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedSlot,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSlot = newValue!;
                      });
                    },
                    items: availableTimes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  TextField(
                    controller: _nameController, // Use controller here
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _mobileController, // Use controller here
                    decoration: InputDecoration(
                      labelText: 'Mobile',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _brandValue,
                    items: [
                      'Toyota',
                      'Honda',
                      'Nissan',
                      'Suzuki',
                      'Mitsubishi',
                      'Hyundai',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Brand',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Save the selected value to the state
                      setState(() {
                        _brandValue = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _modelValue,
                    items:
                    [
                      'Corolla',
                      'Civic',
                      'Altima',
                      'Swift',
                      'Outlander',
                      'Elantra',
                      'Accord',
                      'X-Trail',
                      'Vitz',
                      'Grand i10',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Save the selected value to the state
                      setState(() {
                        _modelValue = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('CANCEL'),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: ()  async {
                          bool isSaved = await saveToFirestore();
                          if (isSaved) {
                            _showSnackBar(
                                'Data saved successfully with auto-generated ID');
                            Navigator.pop(context);
                          };
                        },
                        child: Text('Submit'),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
