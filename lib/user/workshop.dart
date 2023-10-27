import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage_eka/user/appointment_book.dart';
import 'package:garage_eka/workshop/about.dart';

class WorkshopCenterList extends StatelessWidget {
  String city;
  WorkshopCenterList({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Workshops', style: TextStyle(color: Colors.black)),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           decoration: InputDecoration(
            //             hintText: 'Search Service Centers',
            //             prefixIcon: Icon(Icons.search),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 10),
            //     ],
            //   ),
            // ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('workshops')
                    .where('Province', isEqualTo: city)
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

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkshopAbout(data),
                            ),
                          );
                          print(docs[index].id);
                        },
                        child: Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  data['Image'] ??
                                      'https://i.pinimg.com/564x/91/c3/d1/91c3d130f87bb7d1ef43cab2e3854659.jpg', // Default image URL
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                data['Name'] ?? 'Service Center 0${index + 1}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Workshop 0${index + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                data['Province'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    data['Mobile'] ?? 'Not available',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),

    );
  }
}
