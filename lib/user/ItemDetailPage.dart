import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:garage_eka/user/vehicle.dart';

class ItemDetailPage extends StatelessWidget {
  final ItemModel item;

  ItemDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Color(0xFFf7c910),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "https://tyresnmore.com/media/catalog/product/cache/8008d333fec3cd28ed0e4978a7b2d709/s/p/sportdrive_suv_left.jpg",
                      fit: BoxFit.cover,
                      height: 220,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text("${item.name}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      leading: Icon(Icons.drive_eta),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      title:
                          Text("${item.brand}", style: TextStyle(fontSize: 16)),
                      leading: Icon(Icons.business),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text("\$${item.price}",
                          style: TextStyle(fontSize: 16, color: Colors.green)),
                      leading: Icon(Icons.money),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      title:
                          Text("${item.type}", style: TextStyle(fontSize: 16)),
                      leading: Icon(Icons.category),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 1.5, color: Colors.grey[400]),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    child: Text("Details: ${item.details}",
                        style: TextStyle(fontSize: 16)),
                  ),
                  Divider(thickness: 1.5, color: Colors.grey[400]),
                  SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0, // Setting the size of each star
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(item.id)
                          .update({'rating': rating})
                          .then((_) => print("Rating updated successfully!"))
                          .catchError((error) =>
                              print("Failed to update rating: $error"));
                    },
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        primary: Color(0xFFf7c910),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                      child: Text("Buy Now"),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
