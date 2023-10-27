import 'package:flutter/material.dart';

class AutoHubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto hub'),
        centerTitle: true,
        actions: [Icon(Icons.search)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network('IMAGE_URL'),
              SizedBox(height: 8.0),
              Text(
                'Adonz Automotive',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text('Muscat, Sultanate of Oman'),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500.'
                '\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              ),
              SizedBox(height: 12.0),
              Text(
                'We are specialised in',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network('LOGO_URL_1'),
                  Image.network('LOGO_URL_2'),
                  Image.network('LOGO_URL_3'),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Call'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Whatsapp'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
