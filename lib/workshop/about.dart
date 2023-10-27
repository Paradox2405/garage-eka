import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkshopAbout extends StatefulWidget {
  final Map<String, dynamic>? data;
  WorkshopAbout(this.data);
  @override
  _WorkshopAboutState createState() => _WorkshopAboutState();
}

class _WorkshopAboutState extends State<WorkshopAbout> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchInWhatsapp(String number) async {
    if (!await launchUrl(
      Uri.parse('https://wa.me/+94$number'),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Work Shop', style: TextStyle(color: Colors.black)),
        actions: [],
      ),
      body: ListView(
        children: [
          if (widget.data != null) ...[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.data?["Image"]??'https://www.allstoragesystems.com.au/wp-content/uploads/2020/06/Organising-your-Automotive-Workshop.jpg',
                    width: 400,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.data?["Name"]??"No Data",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.car_rental),
                      SizedBox(width: 8.0),
                      Text( widget.data?["Brands"]??"No Data",),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8.0),
                      Text( widget.data?["Mobile"]??"No Data",),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(width: 8.0),
                      Text( widget.data?["Description"]??"No Data",),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'We are specialised in',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        'https://www.carlogos.org/car-logos/bmw-logo-2020-gray.png',
                        width: 100,
                      ),
                      Image.network(
                        'https://www.carlogos.org/car-logos/ford-logo-2017-640.png',
                        width: 100,
                      ),
                      Image.network(
                       // 'https://www.carlogos.org/car-logos/toyota-logo-2020-europe-640.png',
                        'https://www.carlogos.org/car-logos/toyota-logo-2005-download.png',
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        'https://www.carlogos.org/car-logos/mazda-logo-2018-vertical-640.png',
                        width: 100,
                      ),
                      Image.network(
                        'https://www.carlogos.org/car-logos/hyundai-logo-2011-640.png',
                        width: 100,
                      ),
                      Image.network(
                        'https://www.carlogos.org/car-logos/nissan-logo-2020-black-show.png',
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _makePhoneCall( widget.data?["Mobile"]??"");
                        },
                        child: Text('Call'),
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _launchInWhatsapp( widget.data?["Whatsapp Number"]??"");
                        },
                        child: Text('Whatsapp'),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
