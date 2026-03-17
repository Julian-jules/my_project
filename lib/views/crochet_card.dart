import 'package:flutter/material.dart';

class CrochetCard extends StatelessWidget {
  final String name;
  final String image;
  final String price;

  const CrochetCard({
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,

      child: Column(
        children: [
          Expanded(child: Image.asset(image, fit: BoxFit.cover)),

          Padding(
            padding: const EdgeInsets.all(8),

            child: Column(
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),

                const SizedBox(height: 5),

                Text(price),

                const SizedBox(height: 5),

                const Icon(Icons.favorite_border),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
