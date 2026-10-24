
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/item_store.dart';
import 'item_details_page.dart';

class LostItemsPage extends StatelessWidget {
  const LostItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lostItems = ItemStore.items
        .where((item) => item.type == 'Lost')
        .toList();

    final sampleItems = [
      ItemModel(
        id: 'sample1',
        name: 'Black Smartphone',
        description:
            'Black smartphone with a protective case.',
        location: 'College Library',
        date: 'Today',
        type: 'Lost',
      ),
      ItemModel(
        id: 'sample2',
        name: 'Black Wallet',
        description: 'Black wallet lost near the canteen.',
        location: 'Canteen',
        date: 'Yesterday',
        type: 'Lost',
      ),
      ItemModel(
        id: 'sample3',
        name: 'Room Keys',
        description: 'Set of room keys.',
        location: 'Block A',
        date: '2 days ago',
        type: 'Lost',
      ),
    ];

    final allLostItems = [...sampleItems, ...lostItems];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost Items'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allLostItems.length,
        itemBuilder: (context, index) {
          final item = allLostItems[index];

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.search,
                size: 40,
              ),
              title: Text(item.name),
              subtitle: Text(
                '${item.location} • ${item.date}\n'
                '${item.description}',
              ),
              isThreeLine: true,
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ItemDetailsPage(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
