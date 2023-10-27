import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:garage_eka/user/ItemDetailPage.dart';

class MyVehiclePage extends StatefulWidget {
  @override
  _MyVehiclePageState createState() => _MyVehiclePageState();
}

class _MyVehiclePageState extends State<MyVehiclePage> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('My Vehicle', style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreInstance
            .collection('items')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<ItemModel> items = snapshot.data!.docs
              .map((doc) => ItemModel.fromDocument(doc))
              .toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              ItemModel item = items[index];
              return Card(
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                        "https://tyresnmore.com/media/catalog/product/cache/8008d333fec3cd28ed0e4978a7b2d709/s/p/sportdrive_suv_left.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(item.name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text(item.price),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: item.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ignoreGestures: true, // Disable rating interactions

                      itemSize: 20.0, // Setting the size of each star
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemDetailPage(item: item)),
                        );
                      },
                      child: Text("Add to Cart"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ItemModel {
  final String brand;
  final String details;
  final String name;
  final String price;
  final String type;
  final double rating;
  final String id;

  ItemModel(
      {required this.brand,
      required this.details,
      required this.name,
      required this.price,
      required this.type,
      required this.rating,
      required this.id});

  static ItemModel fromDocument(DocumentSnapshot doc) {
    return ItemModel(
      brand: doc['brand'],
      details: doc['details'],
      name: doc['name'],
      price: doc['price'],
      type: doc['type'],
      rating: doc['rating'].toDouble(),
      id: doc.id,
    );
  }
}
