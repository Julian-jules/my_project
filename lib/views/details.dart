import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final String image;

  const DetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, width: double.infinity, height: 250),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 22)),
                SizedBox(height: 10),
                Text("\$ $price", style: TextStyle(color: Colors.green)),
                SizedBox(height: 20),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}