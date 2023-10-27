import 'package:flutter/material.dart';

class Interior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf7c910),
        title: Text("My Shop"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(
                    'https://via.placeholder.com/150',
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
                        [
                          'Interior',
                          'Exterior',
                          'Engine',
                          'Fancy',
                          'OIL',
                          'Wheels'
                        ][index],
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
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
