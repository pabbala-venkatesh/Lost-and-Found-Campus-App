
import 'package:flutter/material.dart';
import '../services/item_store.dart';

class LostItemsPage extends StatelessWidget {
  const LostItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lostItems = ItemStore.items
        .where((item) => item.type == 'Lost')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost Items'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Previously added sample items
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.phone_android,
                size: 40,
              ),
              title: const Text('Black Smartphone'),
              subtitle: const Text('Library • Today'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.account_balance_wallet,
                size: 40,
              ),
              title: const Text('Black Wallet'),
              subtitle: const Text('Canteen • Yesterday'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.key,
                size: 40,
              ),
              title: const Text('Room Keys'),
              subtitle: const Text('Block A • 2 days ago'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),

          // Items submitted through the report form
          ...lostItems.map(
            (item) => Card(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
