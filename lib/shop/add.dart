import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewItem extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemTypeController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemBrandController = TextEditingController();
  final TextEditingController _itemDetailsController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  void _submitData() async {
    try {
      await FirebaseFirestore.instance.collection('items').add({
        'type': _itemTypeController.text,
        'name': _itemNameController.text,
        'brand': _itemBrandController.text,
        'details': _itemDetailsController.text,
        'price': _itemPriceController.text,
      });
    } catch (error) {}
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.yellow,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'Success!',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          content: Text(
            'New product added successfully',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _submitData();
              },
              child: Text('OK', style: TextStyle(color: Colors.black)),
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Add New Item", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, size: 30),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _itemTypeController,
                    decoration: InputDecoration(
                      labelText: 'Item Type',
                      hintText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _itemNameController,
                    decoration: InputDecoration(
                      labelText: 'Item Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _itemBrandController,
                    decoration: InputDecoration(
                      labelText: 'Item Brand',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _itemDetailsController,
                    decoration: InputDecoration(
                      labelText: 'More details',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _itemPriceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showSuccessDialog(context);
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
