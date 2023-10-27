import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage_eka/services/authentication_service.dart';
import 'package:garage_eka/user/location.dart';
import 'package:garage_eka/user/vehicle.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text("Shops"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {AuthenticationService().signOut();}, icon:Icon( Icons.logout_outlined))],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('shops').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.count(
            crossAxisCount: 2,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Card(
                  child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyVehiclePage(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://www.autospotparts.com/wp-content/uploads/2014/05/local-auto-parts-store.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.yellow,
                      width: double.infinity,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            data['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Colombo',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
            }).toList(),
          );
        },
      ),
    );
  }
}
