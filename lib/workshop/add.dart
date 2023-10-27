import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkshopRegistrationScreen extends StatefulWidget {
  @override
  _WorkshopRegistrationScreenState createState() =>
      _WorkshopRegistrationScreenState();
}

class _WorkshopRegistrationScreenState
    extends State<WorkshopRegistrationScreen> {
  final nameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final mobileController = TextEditingController();
  final whatsappController = TextEditingController();
  final descriptionController = TextEditingController();
  final provinceController = TextEditingController();
  String? _selectedValue;
  String? _prov;



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

  Future<bool> _saveToFirestore() async {
    if (_selectedValue == null) {
      _showSnackBar("Select a brand");
      return false;
    } else if (_prov==null) {
      _showSnackBar("Select a province");
      return false;
    } else if (nameController.text.isEmpty) {
      _showSnackBar("Type a name");
      return false;
    } else if (ownerNameController.text.isEmpty) {
      _showSnackBar("Type a owner name");
      return false;
    } else if (mobileController.text.isEmpty) {
      _showSnackBar("Add phone");
      return false;
    }  else if (whatsappController.text.isEmpty) {
      _showSnackBar("Add whatsapp number");
      return false;
    }  else if (descriptionController.text.isEmpty) {
      _showSnackBar("Add description");
      return false;
    }else {
      return _saveData();
    }
  }

  Future<bool> _saveData() async {
    Map<String, dynamic> dataToSave = {
      'Name': nameController.text,
      'OwnerName': ownerNameController.text,
      'Mobile': mobileController.text,
      'Whatsapp Number': whatsappController.text,
      'Description': descriptionController.text,
      'Province': _prov,
      'Brands': _selectedValue,
    };

    final firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('workshops').add(dataToSave);
      print("Data saved successfully!");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Data saved successfully!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return true;
    } catch (error) {
      _showSnackBar("Error saving data");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Workshop Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedValue,
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
                  labelText: 'Brands',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Save the selected value to the state
                  setState(() {
                    _selectedValue = value.toString();
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _prov,
                items: [
                  'Central Province',
                  'Eastern Province',
                  'North Central Province',
                  'Northern Province',
                  'North Western Province',
                  'Sabaragamuwa Province',
                  'Southern Province',
                  'Uva Province',
                  'Western Province',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Provinces',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Save the selected value to the state
                  setState(() {
                    _prov = value.toString();
                  });
                },
              ),

              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Garage name...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: ownerNameController,
                decoration: InputDecoration(
                  labelText: 'Name (Owner)',
                  hintText: 'Owner name ...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  prefixText: '+94 ',
                  labelText: 'Mobile',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: whatsappController,
                decoration: InputDecoration(
                  prefixText: '+94 ',
                  labelText: 'Whatsapp Number',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Lorem ipsum dummy text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {Navigator.pop(context);},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
             _saveToFirestore();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                    ),
                    child: Text('SUBMIT'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
