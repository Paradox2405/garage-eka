import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text('My Shop', style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildShopBanner(),
            _buildRatingsAndReviews(),
            _buildShopProducts(),
          ],
        ),
      ),
    );
  }

  Widget _buildShopBanner() {
    return Stack(
      children: [
        Image.network(
          'https://hips.hearstapps.com/hmg-prod/images/2021-bmw-m4-manual-108-1619673989.jpg?crop=0.775xw:0.655xh;0.117xw,0.152xh&resize=1200:*', // <- Woman's Image
          fit: BoxFit.cover,
          height: 200,
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Text(
            'PRAVEEN MARKETPLACE',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingsAndReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ratings & Reviews (273)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        _buildRatingBar('5', Colors.amber, 0.8),
        _buildRatingBar('4', Colors.amber, 0.6),
        _buildRatingBar('3', Colors.amber, 0.4),
        _buildRatingBar('2', Colors.orange, 0.2),
        _buildRatingBar('1', Colors.red, 0.1),
        SizedBox(height: 10),
        Row(
          children: [
            Text('4.5', style: TextStyle(fontSize: 24)),
            Icon(Icons.star, color: Colors.amber),
            Text(' 273 Reviews'),
          ],
        ),
        SizedBox(height: 5),
        Text('88% Recommended'),
      ],
    );
  }

  Widget _buildRatingBar(String rating, Color color, double widthFactor) {
    return Row(
      children: [
        Text(rating),
        SizedBox(width: 5),
        Expanded(
          child: LinearProgressIndicator(
            value: widthFactor,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildShopProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shop Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 20),
        Center(
          child: Image.network(
            'https://hips.hearstapps.com/hmg-prod/images/2021-bmw-m4-manual-108-1619673989.jpg?crop=0.775xw:0.655xh;0.117xw,0.152xh&resize=1200:*', // <- Car Product Image
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
