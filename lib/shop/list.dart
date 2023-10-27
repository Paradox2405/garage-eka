import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text("My Shop"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://5.imimg.com/data5/RC/AU/UU/SELLER-57230940/bmw-tyre-500x500.jpg',
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
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
