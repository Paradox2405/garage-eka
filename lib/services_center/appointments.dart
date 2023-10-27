import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Appointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text(
          'Service Centers',
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "User's Appointments",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF484b9f)),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bookedSlots')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;

                    return ListTile(
                      title: Text(data['name'] ?? "No data"),
                      subtitle:
                          Text('${data['date'] ?? ""}\n${data['time'] ?? ""}'),
                      trailing: Chip(
                        label: Text(data['status'] ?? ""),
                        backgroundColor: data['status'] == 'Pending'
                            ? Colors.white
                            : data['status'] == 'Approved'
                                ? Colors.green
                                : data['status'] == 'Declined'
                                    ? Colors.red
                                    : Colors.yellow,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
