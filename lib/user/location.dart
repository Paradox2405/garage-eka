import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:garage_eka/user/workshop.dart';

class Location extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Location> {
  String? _prov;

  static const List<String> provinces = [
    'Central Province',
    'Eastern Province',
    'North Central Province',
    'Northern Province',
    'North Western Province',
    'Sabaragamuwa Province',
    'Southern Province',
    'Uva Province',
    'Western Province',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Location'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/sos.jpeg',
              scale: 3,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _prov,
              hint: Text("Select a Province"),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.deepPurple,
              ),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              items: [
                ...provinces.map((province) {
                  return DropdownMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          size: 14,
                          color: Colors.deepPurple,
                        ),
                        SizedBox(width: 10),
                        Text(province),
                      ],
                    ),
                    value: province,
                  );
                }).toList(),
              ],
              onChanged: (String? val) {
                if (val != null) {
                  setState(() {
                    _prov = val;
                  });
                  print(_prov);
                }
              },
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(
              onPressed: () {
                if(_prov!=null){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkshopCenterList(city: _prov!),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Select a location'),
                      ),
                      duration: Duration(seconds: 3), // You can set the duration as needed
                    ),
                  );

                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
              child: Text(
                'Find a Workshop',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
