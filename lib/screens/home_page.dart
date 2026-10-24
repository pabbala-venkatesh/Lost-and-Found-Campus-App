
import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../services/item_store.dart';
import 'report_item_page.dart';
import 'lost_items_page.dart';
import 'found_items_page.dart';
import 'item_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<ItemModel> get searchResults {
    final query = searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return [];
    }

    return ItemStore.items.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.location.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);
    }).toList();
  }

  void openItem(ItemModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(item: item),
      ),
    );
  }

  Future<void> openReportPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReportItemPage(),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = searchResults;

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
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name, location or description',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (searchQuery.trim().isNotEmpty) ...[
              Text(
                'Search Results (${results.length})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: results.isEmpty
                    ? const Center(
                        child: Text('No matching reported items found.'),
                      )
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final item = results[index];

                          return Card(
                            child: ListTile(
                              leading: Icon(
                                item.type == 'Lost'
                                    ? Icons.search
                                    : Icons.inventory_2,
                              ),
                              title: Text(item.name),
                              subtitle: Text(
                                '${item.type} • ${item.location}',
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                              onTap: () => openItem(item),
                            ),
                          );
                        },
                      ),
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LostItemsPage(),
                          ),
                        );
                        if (mounted) setState(() {});
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Lost Items'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FoundItemsPage(),
                          ),
                        );
                        if (mounted) setState(() {});
                      },
                      icon: const Icon(Icons.inventory),
                      label: const Text('Found Items'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Recent Items',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ItemStore.items.isEmpty
                    ? const Center(
                        child: Text(
                          'No reports yet. Tap Report Item to get started.',
                        ),
                      )
                    : ListView.builder(
                        itemCount: ItemStore.items.length,
                        itemBuilder: (context, index) {
                          final item = ItemStore
                              .items[ItemStore.items.length - 1 - index];

                          return Card(
                            child: ListTile(
                              leading: Icon(
                                item.type == 'Lost'
                                    ? Icons.search
                                    : Icons.inventory_2,
                                size: 35,
                              ),
                              title: Text(item.name),
                              subtitle: Text(
                                '${item.type} • ${item.location}',
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                              onTap: () => openItem(item),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openReportPage,
        icon: const Icon(Icons.add),
        label: const Text('Report Item'),
      ),
    );
  }
}
