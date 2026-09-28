import 'package:flutter/material.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.phone_android,
              size: 100,
            ),

            const SizedBox(height: 20),

            const Text(
              'Black Smartphone',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Black smartphone with a protective case. '
              'It was lost inside the college library.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Location: College Library',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            const Text(
              'Date: Today',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            const Text(
              'Status: Lost',
              style: TextStyle(fontSize: 16),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone),
                label: const Text('Contact'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}