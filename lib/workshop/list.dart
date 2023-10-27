import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_eka/workshop/about.dart';
import 'package:garage_eka/workshop/add.dart';

class WorkshopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Workshop(),
    );
  }
}

class Workshop extends StatefulWidget {
  @override
  _WorkshopState createState() => _WorkshopState();
}

class _WorkshopState extends State<Workshop> {

  Future<void> deleteWorkshopWithName(String workshopName) async {
    try {
      // Get a reference to the workshops collection
      CollectionReference workshops =
          FirebaseFirestore.instance.collection('workshops');

      // Query to find the document with the specified name
      QuerySnapshot querySnapshot =
          await workshops.where('Name', isEqualTo: workshopName).get();

      // Delete each document found in the query
      querySnapshot.docs.forEach((doc) async {
        await workshops.doc(doc.id).delete();
      });

      print('Documents with name "$workshopName" deleted successfully.');
    } catch (e) {
      print('Error deleting documents: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text('Work Shop', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Work Shop',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkshopRegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Add Work Shop',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('workshops')
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

                      return Card(
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
                            Text(
                                data['Name'] ?? 'Service Center 0${index + 1}'),
                            Text(data['Province'] ?? 'SC 0${index + 1}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WorkshopAbout(data)),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    deleteWorkshopWithName(data['Name']);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
