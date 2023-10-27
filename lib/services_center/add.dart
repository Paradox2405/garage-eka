import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add extends StatefulWidget {
  @override
  _ServiceCenterModifyState createState() => _ServiceCenterModifyState();
}

class _ServiceCenterModifyState extends State<Add> {
  String id = "";
  _ServiceCenterModifyState() {
    getIdFromSharedPreferences();
  }

  getIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('id', "789");

    id = prefs.getString('id')!;
  }

  void _showDialog(String title, String content, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.yellow,
          title: Center(
            child: Icon(
              Icons.check,
              size: 60,
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                content,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModifyDialog(Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            'Are you sure?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Do you want to modify this Service Center data?',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text('CONFIRM'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController _nameController = TextEditingController(text: '');

  TextEditingController _descriptionController =
      TextEditingController(text: '');

  TextEditingController _provinceController = TextEditingController(text: '');

  TextEditingController _mobileController = TextEditingController(text: '');

  TextEditingController _addressController = TextEditingController(text: '');

  TextEditingController _districtController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Center Modify',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 250,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Banner image'),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: 'Mobile',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _districtController,
              decoration: InputDecoration(
                labelText: 'District',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _provinceController,
              decoration: InputDecoration(
                labelText: 'Province',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                  },
                  child: Text('CANCEL'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    _showDialog(
                      'Success!',
                      'Service Center data modified successfully.',
                          () {},
                    );
                    _showModifyDialog(() async {
                      CollectionReference serviceCenters = FirebaseFirestore
                          .instance
                          .collection('serviceCenters');

                      await serviceCenters.doc().set({
                        'name': _nameController.text,
                        'mobile': _mobileController.text,
                        'address': _addressController.text,
                        'district': _districtController.text,
                        'province': _provinceController.text,
                        'description': _descriptionController.text,
                        'userid': id,
                        'rating': 0,
                      }).then((value) {
                        _showDialog(
                          'Success!',
                          'Service Center data modified successfully.',
                              () {
                                Navigator.pop(context);
                              },
                        );
                      }).catchError((error) {
                        print("Failed to add data: $error");
                      });
                    });
                  },
                  child: Text('MODIFY'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
