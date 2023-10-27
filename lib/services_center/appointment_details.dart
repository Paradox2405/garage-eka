import 'package:flutter/material.dart';

class Appointment_details extends StatelessWidget {
  Future<void> _showMessageBox(BuildContext context, String action) async {
    String title = action == 'decline' ? 'Declined!' : 'Success!';
    String description = action == 'decline'
        ? 'Appointment was canceled!'
        : 'Appointment was approved!';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: action == 'decline' ? Colors.red : Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(title, style: TextStyle(color: Colors.white)),
          content: Text(description, style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFf7c910),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Service Centers', style: TextStyle(color: Colors.black)),
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Appointments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('Sadeepa Samarasinghe',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF484b9f))),
              SizedBox(height: 20),
              ListTile(title: Text('Name: Sadeepa Samarasinghe')),
              ListTile(title: Text('Mobile No: 0771234567')),
              ListTile(title: Text('Brand: Toyota')),
              ListTile(title: Text('Model: Aqua')),
              ListTile(title: Text('Date: 15 - 09 - 2023')),
              ListTile(title: Text('Time: 10.10 am')),
              SizedBox(height: 10),
              Text('Description:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(
                  'Lorem ipsum sample text Lorem ipsum sample text Lorem ipsum sample text Lorem ipsum sample text Lorem ipsum sample text'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _showMessageBox(context, 'decline');
                      },
                      child: Text('DECLINE'),
                      style: ElevatedButton.styleFrom(primary: Colors.red)),
                  ElevatedButton(
                      onPressed: () {
                        _showMessageBox(context, 'accept');
                      },
                      child: Text('ACCEPT'),
                      style: ElevatedButton.styleFrom(primary: Colors.green)),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Spare Parts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Request'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Assistant'),
        ],
      ),
    );
  }
}
