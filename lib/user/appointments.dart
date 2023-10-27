import 'package:flutter/material.dart';

class ServiceCenterPage extends StatefulWidget {
  @override
  _ServiceCenterPageState createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Service Centers'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ATI Auto Care',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Mobile',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    items:
                        ['Option1', 'Option2', 'Option3'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Brand',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    items:
                        ['Option1', 'Option2', 'Option3'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('CANCEL'),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('SUBMIT'),
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Spare Parts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}
