import 'package:flutter/material.dart';

import 'report_item_page.dart';
import 'lost_items_page.dart';
import 'found_items_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Lost & Found'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome 👋',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Find what you lost. Help return what you found.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search lost or found items',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LostItemsPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Lost Items'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FoundItemsPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.inventory),
                    label: const Text('Found Items'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Recent Items',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.phone_android,
                  size: 40,
                ),
                title: const Text('Lost Phone'),
                subtitle: const Text(
                  'Library • Today',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReportItemPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Report Item'),
      ),
    );
  }
}