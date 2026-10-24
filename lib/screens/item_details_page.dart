
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class ItemDetailsPage extends StatelessWidget {
  final ItemModel item;

  const ItemDetailsPage({
    super.key,
    required this.item,
  });

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
            Center(
              child: Icon(
                item.type == 'Lost'
                    ? Icons.search
                    : Icons.inventory_2,
                size: 100,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Location: ${item.location}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Date: ${item.date}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Status: ${item.type}',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Contact feature will be added later.',
                      ),
                    ),
                  );
                },
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
