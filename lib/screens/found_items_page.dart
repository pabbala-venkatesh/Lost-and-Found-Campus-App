
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/item_store.dart';
import 'item_details_page.dart';

class FoundItemsPage extends StatelessWidget {
  const FoundItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final foundItems = ItemStore.items
        .where((item) => item.type == 'Found')
        .toList();

    final sampleItems = [
      ItemModel(
        id: 'found1',
        name: 'Wireless Earphones',
        description: 'Wireless earphones found in the lab.',
        location: 'Computer Lab',
        date: 'Today',
        type: 'Found',
      ),
      ItemModel(
        id: 'found2',
        name: 'Water Bottle',
        description: 'Water bottle found on campus.',
        location: 'Sports Ground',
        date: 'Yesterday',
        type: 'Found',
      ),
      ItemModel(
        id: 'found3',
        name: 'Programming Book',
        description: 'Programming book found in the library.',
        location: 'Library',
        date: '2 days ago',
        type: 'Found',
      ),
    ];

    final allFoundItems = [...sampleItems, ...foundItems];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Found Items'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allFoundItems.length,
        itemBuilder: (context, index) {
          final item = allFoundItems[index];

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.inventory_2,
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
