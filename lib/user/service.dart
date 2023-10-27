import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage_eka/user/appointment_book.dart';

class Service extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: ServiceCenterList(),
    );
  }
}

class ServiceCenterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Service Centers', style: TextStyle(color: Colors.black)),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('serviceCenters')
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
                              builder: (context) => ServiceSlotBookingPage(data),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  data['Image'] ??
                                      'https://i.pinimg.com/564x/91/c3/d1/91c3d130f87bb7d1ef43cab2e3854659.jpg', // Default image URL
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(data['name'] ??
                                  'Service Center 0${index + 1}'),
                              Text(data['province']??'SC 0${index + 1}'),
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
