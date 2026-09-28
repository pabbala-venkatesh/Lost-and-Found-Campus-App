import 'package:flutter/material.dart';

class FoundItemsPage extends StatelessWidget {
  const FoundItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Found Items'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.headphones,
                size: 40,
              ),
              title: const Text('Wireless Earphones'),
              subtitle: const Text('Computer Lab • Today'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.water_drop,
                size: 40,
              ),
              title: const Text('Water Bottle'),
              subtitle: const Text('Sports Ground • Yesterday'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.book,
                size: 40,
              ),
              title: const Text('Programming Book'),
              subtitle: const Text('Library • 2 days ago'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}